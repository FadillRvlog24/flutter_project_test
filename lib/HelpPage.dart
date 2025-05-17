import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bantuan"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: const [
            Text("Hubungi kami di:", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Email: mbahsuh@gmail.com"),
            Text("WhatsApp: +62 821-2902-2786"),
            SizedBox(height: 20),
            Text("Pertanyaan Umum:", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("• Bagaimana cara memesan layanan di mbahsuh?\n• Apakah bisa request layanan?\n• Metode pembayaran apa saja yang tersedia?")
          ],
        ),
      ),
    );
  }
}
