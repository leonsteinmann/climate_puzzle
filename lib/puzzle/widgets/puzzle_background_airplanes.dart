import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

class BackgroundAirplaneWidget extends StatefulWidget {
  /// {@macro dashatar_countdown_seconds_to_begin}
  const BackgroundAirplaneWidget({
    Key? key,
    required this.backgroundSize,
    required this.airplaneSize,
    required this.duration,
    required this.startPosition,
    required this.endPosition,
  }) : super(key: key);

  /// The number of seconds before the puzzle is started.
  final double backgroundSize;
  final double airplaneSize;
  final int duration;
  final List<double> startPosition;
  final List<double> endPosition;


  @override
  State<BackgroundAirplaneWidget> createState() =>
      _BackgroundAirplaneWidgetState();
}

class _BackgroundAirplaneWidgetState
    extends State<BackgroundAirplaneWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> inScale;
  late Animation<double> outScale;
  late Animation<double> inOpacity;
  late Animation<double> outOpacity;
  late RectTween position;



  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );

    position = RectTween(
      begin: Rect.fromLTWH(widget.startPosition[0], widget.startPosition[1], widget.airplaneSize, widget.airplaneSize),
      end: Rect.fromLTWH(widget.endPosition[0], widget.endPosition[1], widget.airplaneSize, widget.airplaneSize),
    );

    inScale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    outScale = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1, curve: Curves.easeOutCubic),
      ),
    );

    inOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.3, curve: Curves.easeOutCubic),
      ),
    );

    outOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.7, 1, curve: Curves.easeOutCubic),
      ),
    );
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double getAngleFromVectors(List<double> v1, List<double> v2) {
    /// return the angle in which the airplane is flying vs base vector (vertical)
    var baseV = <double>[0,1];
    var v = <double>[v2[0]-v1[0], v2[1]-v1[1]];
    var vLen = sqrt(pow(v[0], 2) + pow(v[1], 2));
    final List<double> directV = [v[0]/vLen, v[1]/vLen];

    num a = baseV[0]*directV[0] + baseV[1] * directV[1];
    num b = sqrt(pow(baseV[0], 2) + pow(baseV[1], 2));
    num c = sqrt(pow(directV[0], 2) + pow(directV[1], 2));
    return acos(a/b/c);

  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select((DashatarThemeBloc bloc) => bloc.state.theme);

    return RelativePositionedTransition(
      size: Size.square(widget.backgroundSize),
      rect: position.animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0, 1, curve: Curves.easeInOutCubic),
        ),
      ),
      child: FadeTransition(
        opacity: inOpacity,
        child: FadeTransition(
          opacity: outOpacity,
          child: ScaleTransition(
            scale: inScale,
            child: ScaleTransition(
              scale: outScale,
              child: Transform(
                transform: Matrix4.rotationZ(pi + getAngleFromVectors(widget.startPosition, widget.endPosition)),
                child: Image.asset(
                  'assets/images/airplane.png',
                  //key: const Key('airplane'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}