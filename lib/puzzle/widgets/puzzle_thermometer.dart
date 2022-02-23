import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/timer/bloc/timer_bloc.dart';
import 'package:very_good_slide_puzzle/typography/text_styles.dart';
import '../../colors/colors.dart';
import '../../layout/layout.dart';
import '../../layout/responsive_gap.dart';

class PuzzleThermometer extends StatefulWidget {

  @override
  State<PuzzleThermometer> createState() => _PuzzleBackgroundAtmosphere();
}

class _PuzzleBackgroundAtmosphere extends State<PuzzleThermometer> with SingleTickerProviderStateMixin {

  final double _startOffset = 30.0;
  final double _secTo2100 = 2100.0 - DateTime.now().year.toDouble();

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timer = context.select((TimerBloc bloc) => bloc.state);

    return Column(
      children: [
        const ResponsiveGap(
          small: 20,
          medium: 83,
          large: 220,
        ),
        ResponsiveLayoutBuilder(
          small: (context, __) => Center(
            child: Container(

            ),
          ),
          medium: (context, __) => Center(
            child: Container(

            ),
          ),
          large: (context, __) => Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // paris agreement indicator line
                Container(
                  padding: EdgeInsets.only(left: 30.0, bottom: _BoardSize.large/1-20),
                  child: SizedBox(
                    height: 2.0,
                    width: 50.0,
                    child:
                    Container(
                      color: PuzzleColors.redLightAccent,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 140.0, bottom: _BoardSize.large/1-15),
                  child: Text(
                    "No policies",
                    style: PuzzleTextStyle.bodyXSmall.copyWith(color: PuzzleColors.redLightAccent,),
                  ),
                ),
                //
                // paris agreement indicator line
                Container(
                  padding: EdgeInsets.only(left: 30.0, bottom: _BoardSize.large/3),
                  child: SizedBox(
                    height: 2.0,
                    width: 50.0,
                    child:
                    Container(
                      color: PuzzleColors.blueLightAccent,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 140.0, bottom: _BoardSize.large/3+5),
                  child: Text(
                    "Paris Agreement",
                    style: PuzzleTextStyle.bodyXSmall.copyWith(color: PuzzleColors.blueLightAccent,),
                  ),
                ),
                // year counter
                AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: const BoxDecoration(
                    ),
                    padding: EdgeInsets.only(right: 200, bottom: _BoardSize.large/2,),
                    child: Text("${DateTime.now().year.toDouble() + timer.secondsElapsed}", style: PuzzleTextStyle.headline4.copyWith(color: Colors.white),)
                ),
                // background frame
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  height: _BoardSize.large,
                  width: 20,
                ),
                // filled part of frame
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  //height: (timer.secondsElapsed < yearsTo2100) ? value : _BoardSize.large,
                  height: (timer.secondsElapsed < _secTo2100) ? (_BoardSize.large - _startOffset)/_secTo2100 * timer.secondsElapsed + _startOffset : _BoardSize.large,
                  width: 20,
                ),
                // player indicator line
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                  padding: EdgeInsets.only(right: 60.0, bottom: (timer.secondsElapsed < _secTo2100) ? (_BoardSize.large - _startOffset)/_secTo2100 * timer.secondsElapsed + 28.0 : _BoardSize.large - 2,),
                  child: SizedBox(
                    height: 2.0,
                    width: 60.0,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
                // temperature text
                AnimatedContainer(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 500),
                  padding: EdgeInsets.only(right: 75.0, bottom: (timer.secondsElapsed < _secTo2100) ? (_BoardSize.large - _startOffset)/_secTo2100 * timer.secondsElapsed + 35.0 : _BoardSize.large + 5,),
                  child: Text("+ ${(timer.secondsElapsed*3/_secTo2100 + 1).toStringAsFixed(1)}°C", style: TextStyle(color: Colors.white),)
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class YearCounter extends StatefulWidget {
  /// {@macro dashatar_countdown_go}
  const YearCounter({Key? key}) : super(key: key);

  @override
  State<YearCounter> createState() => _YearCounterState();
}

class _YearCounterState extends State<YearCounter>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> inOpacity;
  late Animation<double> inScale;
  late Animation<double> outScale;
  late Animation<double> outOpacity;
  late Animation<RelativeRect> inOutPosition;
  late Animation<double> position;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    inOpacity = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.37, curve: Curves.decelerate),
      ),
    );

    inScale = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.37, curve: Curves.decelerate),
      ),
    );

    outOpacity = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.63, 1, curve: Curves.easeIn),
      ),
    );

    outScale = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.63, 1, curve: Curves.easeIn),
      ),
    );

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timer = context.select((TimerBloc bloc) => bloc.state);

    return FadeTransition(
      opacity: outOpacity,
      child: FadeTransition(
        opacity: inOpacity,
        child: ScaleTransition(
          scale: outScale,
          child: ScaleTransition(
            scale: inScale,
            child: Text(
              "${DateTime.now().year.toDouble() + timer.secondsElapsed}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}


abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}