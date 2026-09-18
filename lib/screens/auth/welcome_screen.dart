import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../theme/renon_colors.dart';
import '../../theme/renon_spacing.dart';
import '../../widgets/renon_buttons.dart';
import '../../widgets/renon_logo.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: RenonColors.ink,
      body: SafeArea(
        child: Stack(
          children: [
            // Background glow.
            Positioned(
              top: size.height * 0.08,
              left: size.width * 0.15,
              right: size.width * 0.15,
              child: IgnorePointer(
                child: Container(
                  height: size.width * 0.75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFC6F135)
                            .withValues(alpha: 0.10),
                        blurRadius: 110,
                        spreadRadius: 35,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: RenonSpacing.lg,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      size.height - MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28),

                    // Top brand.
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: RenonLogo(
                        size: 48,
                        showWordmark: true,
                        onDark: true,
                      ),
                    ),

                    SizedBox(height: size.height * 0.075),

                    // Hero section.
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: size.width * 0.46,
                            height: size.width * 0.46,
                            decoration: BoxDecoration(
                              color: const Color(0xFF202520),
                              borderRadius: BorderRadius.circular(38),
                              border: Border.all(
                                color: const Color(0xFFC6F135)
                                    .withValues(alpha: 0.12),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFC6F135)
                                      .withValues(alpha: 0.08),
                                  blurRadius: 45,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: RenonLogo(
                                size: 105,
                                onDark: true,
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          const Text(
                            'Find what you need.\nWherever you are.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              height: 1.22,
                              letterSpacing: -0.6,
                            ),
                          ),

                          const SizedBox(height: 14),

                          const Text(
                            'Products. People. Services.\nAll connected in one place.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF969D98),
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: size.height * 0.085),

                    // Bottom content.
                    const Text(
                      'Your world, connected.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                        letterSpacing: -0.8,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Discover trusted people, products and services '
                      'around you.',
                      style: TextStyle(
                        color: RenonColors.softText,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 26),

                    // Primary CTA.
                    RenonPrimaryButton(
                      label: 'Get started',
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.accountType,
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    // Login CTA.
                    Theme(
                      data: Theme.of(context).copyWith(
                        outlinedButtonTheme:
                            OutlinedButtonThemeData(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xFF343A36),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      child: RenonSecondaryButton(
                        label: 'I already have an account',
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.login,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    Center(
                      child: Text(
                        "By continuing, you agree to Renon's Terms & Privacy Policy.",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF676C68),
                          fontSize: 10.5,
                          height: 1.4,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}