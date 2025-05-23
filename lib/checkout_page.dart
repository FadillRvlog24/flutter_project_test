import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'transaksi_berhasilPage.dart';

class CheckoutPage extends StatefulWidget {
  final Map<String, int> layananDipilih;
  final int totalHarga;
  final List<dynamic> layananList;

  CheckoutPage({
    required this.layananDipilih,
    required this.totalHarga,
    required this.layananList,
  });

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  final TextEditingController _jarakController = TextEditingController();

  String? _selectedDeliveryType;
  String _status = "pending";
  DateTime _waktuPemesanan = DateTime.now();
  double _biayaPengiriman = 0;
  String? _snapToken;
  bool _isLoadingPayment = false;
  late final WebViewController _webViewController;

  final List<String> jenisPengiriman = ["Drop Off", "Pickup"];

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            // Periksa status pembayaran dari Midtrans
            if (request.url.contains('transaction_status=settlement') ||
                request.url.contains('transaction_status=capture')) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TransaksiBerhasilPage(),
                ),
              );
              return NavigationDecision.prevent;
            } else if (request.url.contains('transaction_status=pending')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Pembayaran tertunda, silakan cek status.")),
              );
              return NavigationDecision.prevent;
            } else if (request.url.contains('transaction_status=deny') ||
                request.url.contains('transaction_status=expire') ||
                request.url.contains('transaction_status=cancel')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Pembayaran gagal, silakan coba lagi.")),
              );
              setState(() {
                _snapToken = null; // Kembali ke form checkout
              });
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    (_webViewController.platform as AndroidWebViewController)
        .setMediaPlaybackRequiresUserGesture(false);
  }

  void _hitungBiayaPengiriman() {
    if (_selectedDeliveryType == "Drop Off") {
      _biayaPengiriman = 0;
    } else if (_selectedDeliveryType == "Pickup") {
      String jarakText = _jarakController.text.trim();
      if (jarakText.isEmpty) {
        _biayaPengiriman = 0;
        return;
      }
      double? jarak = double.tryParse(jarakText);
      if (jarak != null && jarak >= 0) {
        if (jarak <= 3) {
          _biayaPengiriman = 5000;
        } else if (jarak <= 5) {
          _biayaPengiriman = 10000;
        } else {
          _biayaPengiriman = 15000 + ((jarak - 5) * 1000);
        }
      } else {
        _biayaPengiriman = 0;
      }
    } else {
      _biayaPengiriman = 0;
    }
  }

  Future<void> submitCheckout() async {
    _hitungBiayaPengiriman();
    setState(() {
      _isLoadingPayment = true;
    });

    try {
      // Ambil token dari shared_preferences
      String? token = await getToken();
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Anda belum login! Silakan login terlebih dahulu.")),
        );
        return;
      }

      // Kirim request HTTP dengan JSON
      var response = await http.post(
        Uri.parse('http://192.168.1.20:8000/api/pesanan'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'nama': _namaController.text,
          'no_telepon': _teleponController.text,
          'alamat': _alamatController.text,
          'total_pembayaran': widget.totalHarga + _biayaPengiriman,
          'metode_pembayaran': 'Midtrans',
          'layanan_dipesan': widget.layananDipilih.keys.join(', '),
          'waktu_pemesanan': _waktuPemesanan.toIso8601String(),
          'status': _status,
          'jenis_pengiriman': _selectedDeliveryType ?? "",
          'jarak': _jarakController.text.isNotEmpty ? _jarakController.text : null,
          'catatan': _catatanController.text.isNotEmpty ? _catatanController.text : null,
        }),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        setState(() {
          _snapToken = jsonResponse['snap_token'];
          if (_snapToken != null) {
            _webViewController.loadRequest(Uri.parse(
                'https://app.sandbox.midtrans.com/snap/v2/vtweb/$_snapToken'));
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Pesanan dibuat, lanjutkan ke pembayaran")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal membuat pesanan: ${response.body}")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan, periksa koneksi Anda!")),
      );
    } finally {
      setState(() {
        _isLoadingPayment = false;
      });
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  @override
  Widget build(BuildContext context) {
    _hitungBiayaPengiriman();

    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: _snapToken == null
          ? SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(_namaController, "Nama"),
            _buildTextField(_teleponController, "No. Telepon",
                type: TextInputType.phone),
            _buildTextField(_alamatController, "Alamat"),
            _buildTextField(_catatanController, "Catatan (Opsional)"),
            DropdownButtonFormField<String>(
              value: _selectedDeliveryType,
              decoration: InputDecoration(labelText: "Jenis Pengiriman"),
              items: jenisPengiriman.map((jenis) {
                return DropdownMenuItem(value: jenis, child: Text(jenis));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDeliveryType = value;
                });
              },
            ),
            if (_selectedDeliveryType == "Pickup")
              _buildTextField(_jarakController, "Jarak ke lokasi (km)",
                  type: TextInputType.number),
            SizedBox(height: 20),
            _buildLayananList(),
            Divider(thickness: 1),
            Text(
              "Total Bayar: Rp ${(widget.totalHarga + _biayaPengiriman).toStringAsFixed(0)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoadingPayment
                  ? null
                  : () {
                if (_selectedDeliveryType == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            "Pilih jenis pengiriman terlebih dahulu!")),
                  );
                  return;
                }
                submitCheckout();
              },
              child: Text(_isLoadingPayment
                  ? "Memproses..."
                  : "Lanjutkan ke Pembayaran"),
            ),
          ],
        ),
      )
          : WebViewWidget(controller: _webViewController),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildLayananList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Layanan yang dipilih:",
            style: TextStyle(fontWeight: FontWeight.bold)),
        ...widget.layananDipilih.keys.map((item) => Text("- $item")).toList(),
      ],
    );
  }
}