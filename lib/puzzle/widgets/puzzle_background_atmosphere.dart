

import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

import '../../layout/layout.dart';
import '../../layout/responsive_gap.dart';

class PuzzleBackgroundAtmosphere extends StatefulWidget {

  @override
  State<PuzzleBackgroundAtmosphere> createState() => _PuzzleBackgroundAtmosphere();
}

class _PuzzleBackgroundAtmosphere extends State<PuzzleBackgroundAtmosphere> with SingleTickerProviderStateMixin {

  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync:this, duration: PuzzleThemeAnimationDuration.backgroundPulse);
    _animationController?.repeat(reverse: true);
    _animation = Tween<double>(begin: 100,end: 200.0).animate(_animationController!)..addListener((){setState(() {});});
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
          large: 96,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => Center(
            child: Container(
              width: _BoardSize.small*1.3,
              height: _BoardSize.small*1.3,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(0, 255, 255, 255),
                  boxShadow: [BoxShadow(
                    color: const Color.fromARGB(50, 255, 255, 178),
                      blurRadius: _animation!.value,
                      spreadRadius: _animation!.value,
                  )]
              ),
            ),
          ),
          medium: (_, __) => Center(
            child: Container(
              width: _BoardSize.medium*1.3,
              height: _BoardSize.medium*1.3,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(0, 255, 255, 255),
                  boxShadow: [BoxShadow(
                    color: const Color.fromARGB(50, 255, 255, 178),
                    blurRadius: _animation!.value,
                    spreadRadius: _animation!.value,
                  )]
              ),
            ),
          ),
          large: (_, __) => Center(
            child: Container(
              width: _BoardSize.large*1.3,
              height: _BoardSize.large*1.3,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(0, 255, 255, 255),
                  boxShadow: [BoxShadow(
                    color: const Color.fromARGB(50, 255, 255, 178),
                    blurRadius: _animation!.value,
                    spreadRadius: _animation!.value,
                  )]
              ),
            ),
          ),
        ),
        const ResponsiveGap(
          large: 96,
        ),
      ],
    );
  }
}

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}
