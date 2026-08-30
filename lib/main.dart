import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Ducati',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: Colors.red),
      ),
      home: const CatalogScreen(),
    );
  }
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: Text(
          'Katalog Ducati',
          style: GoogleFonts.bebasNeue(fontSize: 28, letterSpacing: 2),
        ),
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      // Menggunakan LayoutBuilder untuk mendeteksi ukuran layar / window desktop
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Menentukan apakah layar tergolong lebar (desktop/tablet) atau kecil (mobile)
          bool isDesktop = constraints.maxWidth > 600;

          // Menghitung alokasi lebar untuk setiap kartu:
          // Jika desktop, bagi layar menjadi 2 bagian (dikurangi total padding & jarak spasi).
          // Jika mobile, ambil lebar penuh (dikurangi padding kiri-kanan).
          double cardWidth = isDesktop
              ? (constraints.maxWidth - 48) / 2 // 48 = padding kiri 16 + padding kanan 16 + spasi tengah 16
              : constraints.maxWidth - 32;      // 32 = padding kiri 16 + padding kanan 16

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            // Menggunakan Wrap sebagai pengganti Column agar item berbaris ke samping lalu turun ke bawah
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: const ProductCard(
                    imagePath: 'assets/images/panigale.png',
                    title: 'Ducati Panigale V4',
                    price: 'Rp 1.300.000.000',
                    tag: 'Sportbike',
                    isNetworkImage: false,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const ProductCard(
                    imagePath: 'assets/images/streetfighter.png',
                    title: 'Ducati Streetfighter V4',
                    price: 'Rp 1.100.000.000',
                    tag: 'Nakedbike',
                    isNetworkImage: false,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const ProductCard(
                    imagePath: 'assets/images/diavel.png',
                    title: 'Ducati Diavel V4',
                    price: 'Rp 1.250.000.000',
                    tag: 'Cruiser',
                    isNetworkImage: false,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const ProductCard(
                    imagePath: 'assets/images/multistrada.png',
                    title: 'Ducati Multistrada V2',
                    price: 'Rp 1.150.000.000',
                    tag: 'Adventure',
                    isNetworkImage: false,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const ProductCard(
                    imagePath: 'https://www.scramblerducati.com/wp-content/uploads/bikes/icon/62-yellow/Scrambler-Icon-yellow-Next-Gen-riding-moto-1024x576-hero.png',
                    title: 'Ducati Scrambler Icon',
                    price: 'Rp 450.000.000',
                    tag: 'Classic',
                    isNetworkImage: true,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Komponen Widget Reusable untuk Kartu Produk
class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String tag;
  final bool isNetworkImage;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.tag,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    // Container sebagai pembungkus fleksibel dengan margin, padding, border, dan warna[cite: 1]
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
// Penggunaan Stack untuk menumpuk gambar dengan badge/tag
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                // Menggunakan AspectRatio (16:9) agar tinggi gambar menyesuaikan lebar secara proporsional
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: isNetworkImage
                      ? Image.network(
                    imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red.shade700,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            // Penggunaan Row untuk menyusun judul/harga dan tombol aksi[cite: 1]
            child: Row(
              children: [
                // Penggunaan Expanded untuk memastikan teks mengambil sisa ruang dan mencegah overflow[cite: 1]
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                        ),
                        // Menangani teks panjang agar menjadi elipsis (titik-titik)[cite: 1]
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        price,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Detail'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
