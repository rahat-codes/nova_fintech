
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/nova_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/gradient_background.dart';
import '../../../core/widgets/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const int _cardCount = 3;

  late final PageController _pageController;
  Timer? _autoPlayTimer;
  Timer? _resumeTimer;

  int _currentPage = 0;
  bool _isUserInteracting = false;

  final List<Map<String, String>> _cards = [
    {
      'title': 'Set up card',
      'subtitle': 'Your card, your control',
      'emoji': '💳',
    },
    {
      'title': 'Send money',
      'subtitle': 'Move money instantly',
      'emoji': '💸',
    },
    {
      'title': 'Save smarter',
      'subtitle': 'Build your financial future',
      'emoji': '💰',
    },
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: 0.78,
    );

    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();

    _autoPlayTimer = Timer.periodic(
      const Duration(seconds: 3),
          (_) {
        if (!mounted ||
            !_pageController.hasClients ||
            _isUserInteracting) {
          return;
        }

        final nextPage = (_currentPage + 1) % _cardCount;

        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeInOutCubic,
        );
      },
    );
  }

  void _pauseAutoPlay() {
    _resumeTimer?.cancel();
    _autoPlayTimer?.cancel();
    _isUserInteracting = true;
  }

  void _resumeAutoPlay() {
    _resumeTimer?.cancel();

    _resumeTimer = Timer(
      const Duration(milliseconds: 800),
          () {
        if (!mounted) return;

        _isUserInteracting = false;
        _startAutoPlay();
      },
    );
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _resumeTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),

                        const Text(
                          'nova',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -2,
                            color: NovaColors.white,
                          ),
                        ),

                        const SizedBox(height: 24),

                        _buildCarousel(),

                        const SizedBox(height: 24),

                        _buildPageIndicator(),

                        const SizedBox(height: 34),

                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 28,
                          ),
                          child: Text(
                            'Open an account in 3 minutes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              height: 1.2,
                              fontWeight: FontWeight.w800,
                              color: NovaColors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 35,
                          ),
                          child: Text(
                            'No paperwork. Just your ID and a selfie.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: NovaColors.mutedWhite,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                          ),
                          child: PrimaryButton(
                            label: 'Go to app',
                            onPressed: () {
                              _autoPlayTimer?.cancel();
                              _resumeTimer?.cancel();
                              context.go('/home');
                            },
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 260,
      child: Listener(
        onPointerDown: (_) => _pauseAutoPlay(),
        onPointerUp: (_) => _resumeAutoPlay(),
        onPointerCancel: (_) => _resumeAutoPlay(),
        child: PageView.builder(
          controller: _pageController,
          itemCount: _cardCount,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double page = _currentPage.toDouble();

                if (_pageController.hasClients &&
                    _pageController.position.hasContentDimensions) {
                  page = _pageController.page ??
                      _currentPage.toDouble();
                }

                final difference = (page - index).abs();

                final scale =
                (1 - difference * 0.13).clamp(0.82, 1.0);

                final opacity =
                (1 - difference * 0.35).clamp(0.55, 1.0);

                return Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity,
                    child: child,
                  ),
                );
              },
              child: _buildFeatureCard(_cards[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeatureCard(Map<String, String> card) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      child: GlassContainer(
        radius: 30,
        blur: 20,
        opacity: 0.15,
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: NovaColors.cardGradient,
              ),
              child: Center(
                child: Text(
                  card['emoji']!,
                  style: const TextStyle(
                    fontSize: 48,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Text(
              card['title']!,
              style: const TextStyle(
                color: NovaColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              card['subtitle']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: NovaColors.mutedWhite,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _cardCount,
            (index) {
          final isActive = _currentPage == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            width: isActive ? 24 : 7,
            height: 7,
            decoration: BoxDecoration(
              color: isActive
                  ? NovaColors.coral
                  : NovaColors.glassBorder,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}
