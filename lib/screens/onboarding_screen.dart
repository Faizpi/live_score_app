import 'package:flutter/material.dart';
import 'package:live_score/main.dart'; // Import AppColors

// Perubahan: Mengubah menjadi StatefulWidget
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Data untuk halaman onboarding yang bisa di-slide
  final List<String> onboardingImages = [
    'assets/images/dml.jpeg',
    'assets/images/ly.jpeg',
    'assets/images/dd.jpeg',
  ];

  // Variabel untuk melacak halaman yang sedang aktif
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Lapis 1: PageView untuk gambar latar belakang yang bisa di-slide
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingImages.length,
            onPageChanged: (int page) {
              // Update state saat halaman berubah
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              // Membangun gambar dengan efek fade untuk setiap item
              return _buildFadingImage(onboardingImages[index]);
            },
          ),

          // Lapis 2: Konten Teks dan Tombol (STATIS/TIDAK BERGERAK)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Step into the game',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const Row(
                    children: [
                      Text(
                        'Own the win',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(
                        Icons.sports_soccer_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.emoji_events_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Join the action make your moves\nand claim your victory',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Perubahan: Indikator halaman yang dinamis
                  _buildPageIndicator(),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Get started',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk membuat indikator halaman secara dinamis
  Widget _buildPageIndicator() {
    return Row(
      children: List.generate(onboardingImages.length, (index) {
        bool isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: isActive ? 24.0 : 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryGreen : Colors.white38,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  // Perubahan: Widget ini sekarang menerima path gambar sebagai parameter
  Widget _buildFadingImage(String imagePath) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.9),
            Colors.transparent,
          ],
          stops: const [0.5, 0.7, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: Image.asset(
        imagePath, // Menggunakan path gambar dari parameter
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
