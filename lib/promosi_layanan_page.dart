import 'package:flutter/material.dart';

class PromosiLayananPage extends StatefulWidget {
  @override
  _PromosiLayananPageState createState() => _PromosiLayananPageState();
}

class _PromosiLayananPageState extends State<PromosiLayananPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final promosiList = [
      {
        "judul": "25k dapat apa?, dapat cuci disini dongs!",
        "deskripsi": "Hanya 25k kamu bisa cuci sepatu disini loh,buruan pesan!",
        "gambar": "assets/Jasa cuci sepatu promosi 1.png"
      },
      {
        "judul": "Shoes cleaning promo",
        "deskripsi": "Shoes cleaning promo cuma cuma, hanya 70k",
        "gambar": "assets/Jasa cuci sepatu promosi 1 (9).png"
      },
      {
        "judul": "Diskon nih!",
        "deskripsi": "Diskon 15% berlaku untuk shoes cleaning",
        "gambar": "assets/Jasa cuci sepatu promosi 1 (4).png"
      },
      {
        "judul": "Cuci sepatu bergaransi, kapan lagi coba!",
        "deskripsi": "Hanya di kami cuci sepatu bergaransi!, diskon 30% pula",
        "gambar": "assets/Jasa cuci sepatu promosi 1 (2).png"
      },
      {
        "judul": "Shoes wash promo nih le!",
        "deskripsi": "Temukan promo menarik hanya di @mbahsuh",
        "gambar": "assets/Jasa cuci sepatu promosi 1 (7).png"
      },
      {
        "judul": "boots promo",
        "deskripsi":
            "Boots kamu perlu di repair/cuci dengan harga yang terjangkau?, disini tempatnya, diskon 30 %",
        "gambar": "assets/Jasa cuci sepatu promosi 1 (4).png"
      },
    ];

    final layananList = [
      {
        "judul": "SHOES TREATMENT",
        "layanan": [
          {
            "nama": "QUICK CLEAN",
            "deskripsi":
                "Pembersihan bagian luar sepatu termasuk sol dan upper. (20K/ 5 Hours)",
            "gambar": "assets/images/quickclean.jpg"
          },
          {
            "nama": "DEEP CLEAN",
            "deskripsi":
                "Pembersihan menyeluruh bagian luar dan dalam sepatu, termasuk sol dan tali sepatu. (40K/ 3 Days)",
            "gambar": "assets/images/treatment_deepcleaning.jpg"
          },
          {
            "nama": "LEATHER CARE",
            "deskripsi":
                "Pembersihan khusus untuk sepatu berbahan kulit, termasuk pembersihan noda dan pemberian conditioner. (55K/ 3 Days)",
            "gambar": "assets/images/sepatukulit.jpg"
          },
          {
            "nama": "KIDS SHOES CLEANING",
            "deskripsi":
                "Pembersihan sepatu bagian luar dalam untuk sepatu dengan size dibawah 34 (20K/ 2 Days)",
            "gambar": "assets/images/kidsshoes.jpg"
          },
          {
            "nama": "WOMEN SHOES",
            "deskripsi":
                "Pembersihan khusus untuk sepatu wanita seperti High heels, Flat shoes dan Wedges (25K/ 2 Days)",
            "gambar": "assets/images/sepatuwanita.jpg"
          },
          {
            "nama": "UNYELLOWING MIDSOLE",
            "deskripsi":
                "Mengembalikan warna pada bagian midsole yang menguning akibat oksidasi + quick clean (65k/ 4 days)",
            "gambar": "assets/images/Unyellowing.jpg"
          }
        ]
      },
      {
        "judul": "AUGMENT",
        "layanan": [
          {
            "nama": "CAP CLEANING",
            "deskripsi": "Pencucian pada seluruh bagian topi  (20K/ 2 Days)",
            "gambar": "assets/images/capcleaning.jpg"
          },
          {
            "nama": "SANDALS CLEANING",
            "deskripsi": "Pencucian pada seluruh bagian sandal (23K/ 2 Days )",
            "gambar": "assets/images/sandalclean.jpg"
          },
          {
            "nama": "REGLUE MINOR",
            "deskripsi":
                "Pengeleman ulang pada beberapa bagian yang telah terkelupas (40k/2 days)",
            "gambar": "assets/images/reglueminor.jpg"
          },
          {
            "nama": "REGLUE FULL",
            "deskripsi":
                "Melakukan Pengeleman ulang pada Seluruh bagian yang terkelupas (80K/ 3 Days)",
            "gambar": "assets/images/reglueshoes.jpg"
          },
          {
            "nama": "WATERPROOFING",
            "deskripsi":
                "Pemberian cairan waterproof agar sepatu tidak mudah kotor(efek daun talas) (45K)",
            "gambar": "assets/images/waterproofingshoes.jpg"
          },
          {
            "nama": "NEXT DAY",
            "deskripsi":
                "Percepat treatment Jadi 1 Hari Pengerjaan ( Khusus treatment pencucian) Mereparasi ulang bagian tertentu pada sepatu (35K)",
            "gambar": "assets/images/cleaning.jpeg"
          },
          {
            "nama": "REPARATION",
            "deskripsi": "Reparasi sepatu mulai dari 125K",
            "gambar": "assets/images/reparationshoes.jpg"
          }
        ]
      },
      {
        "judul": "REPAINT TREATMENT",
        "layanan": [
          {
            "nama": "REPAINT CANVAS",
            "deskripsi":
                "Pewarnaan ulang pada bagian upper canvas yang telah pudar (100K-130K/7 Days)",
            "gambar": "assets/images/repaintcanvas.jpg"
          },
          {
            "nama": "REPAINT LEATHER",
            "deskripsi":
                "Pewarnaan ulang pada bagian upper Kulit yang telah pudar (135K-160K/7 Days)",
            "gambar": "assets/images/Repaint_leather_shoes.jpg"
          },
          {
            "nama": "CAP REPAINT",
            "deskripsi":
                "Pewarnaan ulang pada bagian topi yang telah pudar (110K/ 7 Days)",
            "gambar": "assets/images/repaintcap.jpg"
          },
          {
            "nama": "BAG REPAINT",
            "deskripsi":
                "Pewarnaan ulang pada tas yang telah pudar (110K-200K/7 Days)",
            "gambar": "assets/images/bagrepaint.jpg"
          },
          {
            "nama": "MIDSOLE /BOOTS REPAINT",
            "deskripsi":
                "Pewarnaan ulang pada bagian midsole yang telah pudar (125K/ 7 Days)",
            "gambar": "assets/images/mindsolebootsrepaint.jpg"
          },
          {
            "nama": "CHEKERBOARD REPAINT",
            "deskripsi":
                "Pewarnaan ulang pada bagian upper Chekerboard yang telah pudar (135K/ 7 Days)",
            "gambar": "assets/images/Checkerboardrepaint.jpg"
          }
        ]
      },
      {
        "judul": "BAGS TREATMENT",
        "layanan": [
          {
            "nama": "BACKPACK",
            "deskripsi":
                "Membersihkan tas backpack dengan ukuran (25-50 cm * 15 - 22cm * 30 - 80cm) (80K - 250K)",
            "gambar": "assets/images/backpack.jpg"
          },
          {
            "nama": "SMALL BAG",
            "deskripsi":
                "Membersihkan tas kecil dengan ukuran rata-rata (20 - 30cm * 10 - 15cm * 25 - 35cm) (35K-50K)",
            "gambar": "assets/images/smallbag.jpg"
          },
          {
            "nama": "MEDIUM BAG",
            "deskripsi":
                "Membersihkan tas ukuran sedang dengan dimensi rata-rata (30 - 45cm * 15 - 25cm * 35 - 50cm) (60K-75K)",
            "gambar": "assets/images/mediumbag.jpg"
          },
          {
            "nama": "LEATHER BAG (S)",
            "deskripsi":
                "Membersihkan tas kulit ukuran kecil (20-30 cm x 10 - 15cm * 25 - 35cm ) (45K -70K)",
            "gambar": "assets/images/smallleatherbag.jpg"
          },
          {
            "nama": "LEATHER BAG (M)",
            "deskripsi":
                "Membersihkan tas kulit ukuran sedang (30-45 cm x 15 - 25cm * 35 - 50cm ) (75K - 100K)",
            "gambar": "assets/images/leathermediumbag.png"
          },
          {
            "nama": "LEATHER BAG (L)",
            "deskripsi":
                "Membersihkan tas kulit ukuran besar (45-60 cm x 25 - 30cm * 50 - 70cm ) (110K-150K)",
            "gambar": "assets/images/leatherbaglarge.jpg"
          }
        ]
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Promosi & Layanan Menarik"),
      ),
      body: ListView(
        controller: _scrollController, // <--- Tambahkan controller di sini
        padding: EdgeInsets.all(16),
        children: [
          Text("Promo Terbaru",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...promosiList.map((promo) => Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                margin: EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(
                        promo["gambar"]!,
                        width:
                            double.infinity, // Lebar sesuai ukuran asli gambar
                        height: MediaQuery.of(context)
                            .size
                            .width, // 1:1 ratio (persegi)
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(promo["judul"]!,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text(promo["deskripsi"]!),
                        ],
                      ),
                    )
                  ],
                ),
              )),
          SizedBox(height: 20),
          Text("Layanan Kami",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...layananList.map((kategori) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(kategori["judul"] as String,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  SizedBox(height: 8),
                  ...(kategori["layanan"] as List<dynamic>)
                      .map((layanan) => Card(
                            child: ListTile(
                              leading: Image.asset(layanan["gambar"] as String,
                                  width: 50),
                              title: Text(layanan["nama"] as String,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(layanan["deskripsi"] as String),
                            ),
                          ))
                ],
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        child: Icon(Icons.arrow_upward),
        tooltip: 'Kembali ke atas',
      ),
    );
  }
}
