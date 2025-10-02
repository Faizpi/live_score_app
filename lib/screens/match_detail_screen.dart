import 'package:flutter/material.dart';
import 'package:live_score/main.dart';
import 'package:live_score/models/match_model.dart';
import 'package:flutter/services.dart';
import 'package:live_score/widgets/glassmorphic_container.dart';

class MatchDetailScreen extends StatelessWidget {
  final Match match;
  const MatchDetailScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    // Perubahan besar: Menggunakan Stack sebagai dasar layout
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Lapis 1: Latar Belakang Gradasi Berkelanjutan (STATIS)
          _buildContinuousBackground(),

          // Lapis 2: Konten yang Bisa di-scroll (ditempatkan di atas latar belakang)
          _buildScrollableContent(context),
          
          // Lapis 3: Tombol Pause yang juga statis posisinya
          // Tampilkan tombol pause hanya jika pertandingan Live
          if (match.isLive)
            Positioned(
              // Posisikan sekitar 3/4 dari area header
              top: 320, 
              left: 0,
              right: 0,
              child: Center(
                child: GlassmorphicContainer(
                  borderRadius: 50,
                  padding: const EdgeInsets.all(12),
                  margin: EdgeInsets.zero,
                  child: const Icon(Icons.pause, color: Colors.white, size: 30),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Widget untuk Latar Belakang
  Widget _buildContinuousBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(match.matchImage),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      // Gradien halus di atas gambar
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.6), // Vignette atas
              Colors.transparent,
              AppColors.background.withOpacity(0.8), // Mulai gelap
              AppColors.background, // Sepenuhnya gelap
            ],
            stops: const [0.0, 0.4, 0.7, 1.0], // Atur titik gradien
          ),
        ),
      ),
    );
  }

  // Widget untuk Konten yang bisa di-scroll
  Widget _buildScrollableContent(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverAppBar transparan HANYA untuk tombol kembali & chip Live
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          actions: [
            if (match.isLive)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                    child: const Text('Live', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
          ],
        ),

        // Spacer untuk menciptakan area 'hero image' di bawah AppBar
        const SliverToBoxAdapter(
          child: SizedBox(height: 450.0), // Beri ruang kosong yang besar
        ),

        // Konten utama (kartu skor & odds)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                GlassmorphicContainer(
                  child: Column(
                    children: [
                      Text(match.league, style: TextStyle(color: AppColors.textGrey, fontSize: 14)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TeamDisplay(name: match.team1Name, logo: match.team1Logo),
                          Column(
                            children: [
                              Text('${match.team1Score} - ${match.team2Score}', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(
                                match.matchTime,
                                style: TextStyle(
                                  color: match.isLive ? Colors.red : AppColors.textGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          TeamDisplay(name: match.team2Name, logo: match.team2Logo),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                GlassmorphicContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OddsButton(label: '1', value: match.odds1),
                      OddsButton(label: 'X', value: match.oddsX),
                      OddsButton(label: '2', value: match.odds2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Helper Widgets (TeamDisplay & OddsButton) tidak ada perubahan
class TeamDisplay extends StatelessWidget {
    // ... kode sama seperti sebelumnya
  final String name;
  final String logo;
  const TeamDisplay({super.key, required this.name, required this.logo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(logo, width: 60, height: 60),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}

class OddsButton extends StatelessWidget {
    // ... kode sama seperti sebelumnya
  final String label;
  final String value;
  const OddsButton({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: AppColors.textGrey, fontSize: 16)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }
}