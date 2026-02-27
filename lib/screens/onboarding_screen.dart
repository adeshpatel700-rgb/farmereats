import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Quality',
      description:
          'Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain. ',
      color: AppColors.primaryGreen,
    ),
    OnboardingData(
      title: 'Convenient',
      description:
          'Our team of delivery drivers will make sure your orders are picked up on time and promptly delivered to your customers.',
      color: AppColors.primaryRed,
    ),
    OnboardingData(
      title: 'Local',
      description:
          'We love the earth and know you do too! Join us in reducing our carbon footprint one order at a time. ',
      color: AppColors.primaryYellow,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: _pages.length,
          itemBuilder: (context, index) {
            return OnboardingPage(
              data: _pages[index],
              pageNumber: index + 1,
              currentPage: _currentPage,
              totalPages: _pages.length,
              onJoinPressed: _navigateToLogin,
              onLoginPressed: _navigateToLogin,
            );
          },
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.color,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final int pageNumber;
  final int currentPage;
  final int totalPages;
  final VoidCallback onJoinPressed;
  final VoidCallback onLoginPressed;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.pageNumber,
    required this.currentPage,
    required this.totalPages,
    required this.onJoinPressed,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Illustration container with rounded corners
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: data.color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: _buildIllustration()),
            ),
          ),
          const SizedBox(height: 32),
          // Title
          Text(
            data.title,
            style: GoogleFonts.beVietnamPro(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              data.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.beVietnamPro(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textGrey,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == currentPage
                      ? AppColors.textDark
                      : AppColors.textGrey.withOpacity(0.3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Join button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onJoinPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: data.color,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 0,
              ),
              child: Text(
                'Join the movement!',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Login link
          TextButton(
            onPressed: onLoginPressed,
            child: Text(
              'Login',
              style: GoogleFonts.beVietnamPro(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textDark,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    // Custom illustration placeholders for each page
    switch (pageNumber) {
      case 1:
        return _buildQualityIllustration();
      case 2:
        return _buildConvenientIllustration();
      case 3:
        return _buildLocalIllustration();
      default:
        return const SizedBox();
    }
  }

  Widget _buildQualityIllustration() {
    return CustomPaint(
      painter: FarmScenePainter(),
      size: const Size(double.infinity, double.infinity),
    );
  }

  Widget _buildConvenientIllustration() {
    return CustomPaint(
      painter: HouseScenePainter(),
      size: const Size(double.infinity, double.infinity),
    );
  }

  Widget _buildLocalIllustration() {
    return CustomPaint(
      painter: ForestScenePainter(),
      size: const Size(double.infinity, double.infinity),
    );
  }
}

// Farm Scene Painter
class FarmScenePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Sky with birds
    final birdPaint = Paint()
      ..color = const Color(0xFF2C5F2D).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw birds
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.2, 40),
        width: 20,
        height: 10,
      ),
      3.14,
      3.14,
      false,
      birdPaint,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.3, 30),
        width: 20,
        height: 10,
      ),
      3.14,
      3.14,
      false,
      birdPaint,
    );

    // Ground/grass
    final groundPaint = Paint()..color = const Color(0xFF2C5F2D);
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.65, size.width, size.height * 0.35),
      groundPaint,
    );

    // Trees on left (rounded)
    final treeDarkGreen = Paint()..color = const Color(0xFF1F4620);
    final treeGreen = Paint()..color = const Color(0xFF2D7A3E);
    final treeTrunk = Paint()..color = const Color(0xFF6B4423);

    // Left tree 1
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.15, size.height * 0.5, 8, 30),
      treeTrunk,
    );
    canvas.drawCircle(
      Offset(size.width * 0.19, size.height * 0.48),
      20,
      treeGreen,
    );
    canvas.drawCircle(
      Offset(size.width * 0.19, size.height * 0.45),
      15,
      treeDarkGreen,
    );

    // Left tree 2
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.25, size.height * 0.55, 8, 25),
      treeTrunk,
    );
    canvas.drawCircle(
      Offset(size.width * 0.29, size.height * 0.53),
      18,
      treeGreen,
    );

    // Wind turbine
    final turbinePole = Paint()
      ..color = const Color(0xFF3A3A3A)
      ..strokeWidth = 4;
    canvas.drawLine(
      Offset(size.width * 0.35, size.height * 0.35),
      Offset(size.width * 0.35, size.height * 0.65),
      turbinePole,
    );
    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.35),
      5,
      Paint()..color = Colors.white,
    );

    // Red barn (main building)
    final barnPaint = Paint()..color = const Color(0xFFC62828);
    final barnRoof = Paint()..color = const Color(0xFF8B1E1E);
    final barnDoor = Paint()..color = const Color(0xFF5D1010);

    // Barn body
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.4, size.height * 0.45, 80, 60),
      barnPaint,
    );
    // Barn roof
    final roofPath = Path();
    roofPath.moveTo(size.width * 0.38, size.height * 0.45);
    roofPath.lineTo(size.width * 0.48, size.height * 0.35);
    roofPath.lineTo(size.width * 0.58, size.height * 0.45);
    roofPath.close();
    canvas.drawPath(roofPath, barnRoof);

    // Barn door
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.45, size.height * 0.55, 20, 25),
      barnDoor,
    );
    // X on door
    canvas.drawLine(
      Offset(size.width * 0.45, size.height * 0.62),
      Offset(size.width * 0.52, size.height * 0.75),
      Paint()
        ..color = const Color(0xFFC62828)
        ..strokeWidth = 2,
    );
    canvas.drawLine(
      Offset(size.width * 0.52, size.height * 0.62),
      Offset(size.width * 0.45, size.height * 0.75),
      Paint()
        ..color = const Color(0xFFC62828)
        ..strokeWidth = 2,
    );

    // Small shed (left of barn)
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.32, size.height * 0.55, 30, 35),
      barnPaint,
    );
    // Small roof
    final smallRoofPath = Path();
    smallRoofPath.moveTo(size.width * 0.31, size.height * 0.55);
    smallRoofPath.lineTo(size.width * 0.365, size.height * 0.48);
    smallRoofPath.lineTo(size.width * 0.42, size.height * 0.55);
    smallRoofPath.close();
    canvas.drawPath(smallRoofPath, barnRoof);

    // Trees on right
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.65, size.height * 0.52, 8, 28),
      treeTrunk,
    );
    canvas.drawCircle(
      Offset(size.width * 0.69, size.height * 0.50),
      18,
      treeGreen,
    );

    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.75, size.height * 0.48, 8, 32),
      treeTrunk,
    );
    canvas.drawCircle(
      Offset(size.width * 0.79, size.height * 0.46),
      20,
      treeDarkGreen,
    );

    // Fence
    final fencePaint = Paint()..color = const Color(0xFF6B4423);
    for (int i = 0; i < 12; i++) {
      final x = size.width * 0.15 + (i * 25.0);
      canvas.drawRect(Rect.fromLTWH(x, size.height * 0.7, 4, 25), fencePaint);
    }
    // Horizontal fence bars
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.15, size.height * 0.75, size.width * 0.7, 3),
      fencePaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.15, size.height * 0.85, size.width * 0.7, 3),
      fencePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// House Scene Painter
class HouseScenePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Clouds
    final cloudPaint = Paint()
      ..color = const Color(0xFFE8B4A0).withOpacity(0.7);

    // Cloud 1
    canvas.drawCircle(Offset(size.width * 0.25, 60), 25, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.3, 65), 20, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.35, 62), 22, cloudPaint);

    // Cloud 2
    canvas.drawCircle(Offset(size.width * 0.65, 80), 22, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.7, 75), 25, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.75, 78), 20, cloudPaint);

    // House walls (orange/yellow)
    final housePaint = Paint()..color = const Color(0xFFFF9F4A);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.3, size.height * 0.45, 120, 90),
      housePaint,
    );

    // Roof (red)
    final roofPaint = Paint()..color = const Color(0xFFD84B3B);
    final roofPath = Path();
    roofPath.moveTo(size.width * 0.25, size.height * 0.45);
    roofPath.lineTo(size.width * 0.5, size.height * 0.25);
    roofPath.lineTo(size.width * 0.75, size.height * 0.45);
    roofPath.close();
    canvas.drawPath(roofPath, roofPaint);

    // Chimney (dark)
    final chimneyPaint = Paint()..color = const Color(0xFF2C2C2C);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.42, size.height * 0.32, 15, 30),
      chimneyPaint,
    );

    // Roof circle window
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.35),
      12,
      Paint()..color = const Color(0xFFFFD54F),
    );
    // Window cross
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.32),
      Offset(size.width * 0.5, size.height * 0.38),
      Paint()
        ..color = const Color(0xFF2C2C2C)
        ..strokeWidth = 2,
    );
    canvas.drawLine(
      Offset(size.width * 0.47, size.height * 0.35),
      Offset(size.width * 0.53, size.height * 0.35),
      Paint()
        ..color = const Color(0xFF2C2C2C)
        ..strokeWidth = 2,
    );

    // Windows
    final windowPaint = Paint()..color = const Color(0xFF7DD4E8);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.38, size.height * 0.55, 20, 25),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.62, size.height * 0.55, 20, 25),
      windowPaint,
    );

    // Door
    final doorPaint = Paint()..color = const Color(0xFF5D4037);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.46, size.height * 0.58, 25, 40),
      doorPaint,
    );

    // Fence at bottom
    final fencePaint = Paint()..color = const Color(0xFF3E2723);
    for (int i = 0; i < 15; i++) {
      final x = size.width * 0.2 + (i * 20.0);
      canvas.drawRect(Rect.fromLTWH(x, size.height * 0.75, 3, 20), fencePaint);
    }
    // Horizontal bars
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.2, size.height * 0.80, size.width * 0.6, 2),
      fencePaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.2, size.height * 0.88, size.width * 0.6, 2),
      fencePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Forest Scene Painter
class ForestScenePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background trees (dark orange circles)
    final tree1Paint = Paint()..color = const Color(0xFFE07A3F);
    final tree2Paint = Paint()..color = const Color(0xFFD65D2F);
    final tree3Paint = Paint()..color = const Color(0xFFFF6B35);

    // Left tree - round orange
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.45),
      45,
      tree1Paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.42),
      35,
      tree2Paint,
    );

    // Center tall triangular tree (red/orange)
    final trianglePath1 = Path();
    trianglePath1.moveTo(size.width * 0.45, size.height * 0.25);
    trianglePath1.lineTo(size.width * 0.35, size.height * 0.55);
    trianglePath1.lineTo(size.width * 0.55, size.height * 0.55);
    trianglePath1.close();
    canvas.drawPath(trianglePath1, Paint()..color = const Color(0xFFFF4F3B));

    // Second layer triangle
    final trianglePath2 = Path();
    trianglePath2.moveTo(size.width * 0.45, size.height * 0.35);
    trianglePath2.lineTo(size.width * 0.38, size.height * 0.60);
    trianglePath2.lineTo(size.width * 0.52, size.height * 0.60);
    trianglePath2.close();
    canvas.drawPath(trianglePath2, Paint()..color = const Color(0xFFE84A3D));

    // Right triangular tree (orange)
    final trianglePath3 = Path();
    trianglePath3.moveTo(size.width * 0.75, size.height * 0.28);
    trianglePath3.lineTo(size.width * 0.65, size.height * 0.58);
    trianglePath3.lineTo(size.width * 0.85, size.height * 0.58);
    trianglePath3.close();
    canvas.drawPath(trianglePath3, Paint()..color = const Color(0xFFFF8C42));

    // Tree trunks
    final trunkPaint = Paint()..color = const Color(0xFF6B4423);

    // Left tree trunk
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.18, size.height * 0.53, 12, 35),
      trunkPaint,
    );

    // Center tree trunk
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.43, size.height * 0.60, 12, 35),
      trunkPaint,
    );

    // Right tree trunk
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.73, size.height * 0.58, 12, 35),
      trunkPaint,
    );

    // Small decorative elements (dots/leaves falling)
    final dotPaint = Paint()..color = const Color(0xFFFFB84D);
    canvas.drawCircle(
      Offset(size.width * 0.3, size.height * 0.35),
      4,
      dotPaint,
    );
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.4), 4, dotPaint);
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.45),
      4,
      dotPaint,
    );

    // Dashed line elements
    final dashPaint = Paint()
      ..color = const Color(0xFF2C2C2C).withOpacity(0.3)
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(size.width * 0.55, size.height * 0.42),
      Offset(size.width * 0.62, size.height * 0.42),
      dashPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.63, size.height * 0.42),
      Offset(size.width * 0.68, size.height * 0.42),
      dashPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
