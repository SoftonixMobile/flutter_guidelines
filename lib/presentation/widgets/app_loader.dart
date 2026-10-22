import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/presentation/theme/index.dart';

class const AppLoader({super.key}) extends StatefulWidget {
  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState()
    extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _scale = Tween<double>(begin: 0.85, end: 1.05).animate(curve);
    _opacity = Tween<double>(begin: 0.5, end: 1).animate(curve);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorsTheme.background,
      body: Center(
        child: FadeTransition(
          opacity: _opacity,
          child: ScaleTransition(
            scale: _scale,
            child: Assets.images.logoShort.image(width: 96, height: 96),
          ),
        ),
      ),
    );
  }
}
