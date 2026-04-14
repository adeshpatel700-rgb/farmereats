import 'package:farmer_eats/core/theme/app_assets.dart';
import 'package:farmer_eats/core/theme/app_colors.dart';
import 'package:farmer_eats/core/theme/app_text_styles.dart';
import 'package:farmer_eats/core/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      title: 'Quality',
      body:
          'Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain. ',
      color: Color(0xFF5EA25F),
      imagePath: AppAssets.onboardingQuality,
    ),
    _OnboardingData(
      title: 'Convenient',
      body:
          'Order fresh produce from the comfort of your home, delivered to your door.',
      color: Color(0xFFD5715B),
      imagePath: AppAssets.onboardingConvenient,
    ),
    _OnboardingData(
      title: 'Local',
      body: 'Support your local farming community and eat fresh every day.',
      color: Color(0xFFF8C569),
      imagePath: AppAssets.onboardingLocal,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (!mounted) {
      return;
    }
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final bool isLast = _currentIndex == _pages.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: isLast
                    ? const SizedBox(height: 48)
                    : TextButton(
                        onPressed: _completeOnboarding,
                        child: const Text('Skip', style: AppTextStyles.link),
                      ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) =>
                      setState(() => _currentIndex = index),
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Column(
                      children: [
                        Container(
                          height: 280,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: page.color,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
                            child: Image.asset(
                              page.imagePath,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                        Text(page.title, style: AppTextStyles.headline),
                        const SizedBox(height: 14),
                        Text(
                          page.body,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body.copyWith(
                            color: const Color(0xBF1A1A1A),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: _pages.length,
                effect: const WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 8,
                  dotColor: AppColors.border,
                  activeDotColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: 22),
              AppPrimaryButton(
                label: 'Join the movement!',
                backgroundColor: _pages[_currentIndex].color,
                onPressed: () async {
                  if (isLast) {
                    await _completeOnboarding();
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _completeOnboarding,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingData {
  const _OnboardingData({
    required this.title,
    required this.body,
    required this.color,
    required this.imagePath,
  });

  final String title;
  final String body;
  final Color color;
  final String imagePath;
}
