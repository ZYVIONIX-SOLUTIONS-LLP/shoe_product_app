import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:shoe_product/views/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _arrowsController;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF171514),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    // Arrow sliding-up animation (1.6 seconds loop)
    _arrowsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _arrowsController.repeat();
  }

  @override
  void dispose() {
    _arrowsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF171514),
        body: Stack(
          children: [
            // Smooth bottom radial glow fading into the dark background
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0.0, 1.2),
                    radius: 1.3,
                    colors: [
                      Color(0x3DFF5A1F), // Soft orange/red glow
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final height = constraints.maxHeight;
                  final width = constraints.maxWidth;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // 1. Large background text "NIKE" behind the shoe
                      Positioned(
                        top: height * 0.12,
                        child: IgnorePointer(
                          child: Text(
                            'NIKE',
                            style: TextStyle(
                              fontSize: width * 0.38,
                              fontWeight: FontWeight.w900,
                              color: Colors.white.withOpacity(0.03),
                              letterSpacing: 4,
                            ),
                          ),
                        ),
                      ),

                      // 2. Soft orange shadow/glow underneath the shoe
                      Positioned(
                        top: height * 0.44,
                        child: IgnorePointer(
                          child: Container(
                            width: width * 0.55,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFFF5A1F,
                                  ).withOpacity(0.18),
                                  blurRadius: 30,
                                  spreadRadius: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // 3. Interactive 3D ModelViewer Widget replacing the static asset
                      Positioned(
                        top: height * 0.15,
                        child: SizedBox(
                          width: width * 0.9,
                          height: height * 0.35,
                          child: const ModelViewer(
                            backgroundColor: Colors.transparent,
                            src:
                                'https://modelviewer.dev/shared-assets/models/glTF-Sample-Assets/Models/MaterialsVariantsShoe/glTF-Binary/MaterialsVariantsShoe.glb',
                            alt: 'A 3D model of a shoe',
                            ar: false,
                            autoRotate: true,
                            cameraControls: true,
                            disableZoom: true,
                          ),
                        ),
                      ),

                      // 4. Headline, subtitle, animated chevrons and Get Started actions
                      Positioned(
                        bottom: height * 0.05,
                        left: 20,
                        right: 20,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'LIVE YOUR\nPERFECT',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                height: 1.15,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Smart, gorgeous & fashionable',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.80),
                                fontSize: 13,
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(height: height * 0.08),
                            _AnimatedChevrons(controller: _arrowsController),
                            const SizedBox(height: 6),
                            const Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedChevrons extends StatelessWidget {
  final AnimationController controller;
  const _AnimatedChevrons({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final progress = controller.value;
        return SizedBox(
          height: 28,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: progress * 14,
                child: Opacity(
                  opacity: (1.0 - progress).clamp(0.0, 1.0),
                  child: const Icon(
                    Icons.keyboard_double_arrow_up_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
