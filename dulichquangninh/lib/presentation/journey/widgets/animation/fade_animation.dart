import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum FadeProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..scene(
        begin: Duration.zero,
        end: const Duration(milliseconds: 500),
      )
          .tween(
        FadeProps.opacity,
        Tween<double>(begin: 0.0, end: 1.0),
      )
          .tween(
        FadeProps.translateY,
        Tween<double>(begin: -30.0, end: 0.0),
        curve: Curves.easeOut,
      );

    return CustomAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.get(FadeProps.opacity),
          child: Transform.translate(
            offset: Offset(0, value.get(FadeProps.translateY)),
            child: child,
          ),
        );
      },
    );
  }
}
