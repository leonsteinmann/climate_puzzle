import 'dart:html' as html;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
  final double _secTo2100 = (2100.0 - DateTime.now().year.toDouble())*3;

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  void htmlOpenLink(String url) {
    html.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final timer = context.select((TimerBloc bloc) => bloc.state);

    return Column(
      children: [
        const ResponsiveGap(
          small: 10,
          medium: 20,
          large: 180,
        ),
        ResponsiveLayoutBuilder(
          small: (context, __) => Center(
            child: buildSmallThermometer(timer),
          ),
          medium: (context, __) => Center(
            child: buildMiddleThermometer(timer),
          ),
          large: (context, __) => Center(
            child: buildLargeThermometer(timer),
          ),
        ),
        const SizedBox(height: 10,),
        buildThermometerDescription(),
      ],
    );
  }

  ResponsiveLayoutBuilder buildThermometerDescription() {
    return ResponsiveLayoutBuilder(
        small: (_, child) => child!,
        medium: (_, child) => child!,
        large: (_, child) => child!,
        child: (currentSize) {
          final fontSize = currentSize == ResponsiveLayoutSize.small ? 10.0 : 14.0;
          final width = currentSize == ResponsiveLayoutSize.small ? 300.0 : 400.0;
          return SizedBox(
            width: width,
            child: Column(
              children: [
                Text(
                  "Projected global warming",
                  textAlign: TextAlign.center,
                  style: PuzzleTextStyle.thermometer.copyWith(fontSize: fontSize+6),
                ),
                SizedBox(height: 4,),
                Text(
                  "relative to preindustrial levels. Concrete values depend on future population levels, social values, technological change and many more factors.",
                  textAlign: TextAlign.center,
                  style: PuzzleTextStyle.thermometer.copyWith(fontSize: fontSize, fontWeight: FontWeight.normal),
                ),
                RichText(
                  softWrap: true,
                  text: TextSpan(
                    style: PuzzleTextStyle.thermometer.copyWith(fontSize: fontSize, decoration: TextDecoration.underline,),
                    text: "\nRead more",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        htmlOpenLink("https://en.wikipedia.org/wiki/Climate_change_mitigation_scenarios");
                      },
                  ),
                ),
              ],
            ),
          );
        },
    );
  }

  Stack buildSmallThermometer(TimerState timer) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        // No policy indicator line
        Container(
          padding: EdgeInsets.only(left: _BoardSize.small, top: 20),
          child: SizedBox(
            height: 20.0,
            width: 2.0,
            child:
            Container(
              color: PuzzleColors.redLightAccent,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: _BoardSize.small-15, top: 60),
          child: Text(
            "> 4°C",
            style: PuzzleTextStyle.thermometer.copyWith(color: PuzzleColors.redLightAccent,),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: _BoardSize.small*2/3, top: 20),
          child: SizedBox(
            height: 20.0,
            width: 2.0,
            child:
            Container(
              color: PuzzleColors.roseLightAccent,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: _BoardSize.small*2/3-15, top: 60),
          child: Text(
            "+ 3°C",
            style: PuzzleTextStyle.thermometer.copyWith(color: PuzzleColors.roseLightAccent,),
          ),
        ),
        // paris agreement indicator line
        Container(
          padding: EdgeInsets.only(left: _BoardSize.small/3, top: 20),
          child: SizedBox(
            height: 20.0,
            width: 2.0,
            child:
            Container(
              color: PuzzleColors.lilaLightAccent,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: _BoardSize.small/3-15, top: 60),
          child: Text(
            "+ 2°C",
            style: PuzzleTextStyle.thermometer.copyWith(color: PuzzleColors.lilaLightAccent,),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: _BoardSize.small/3-40, top: 90),
          child: Text(
            "(Paris Agreement)",
            style: PuzzleTextStyle.thermometer.copyWith(color: PuzzleColors.lilaLightAccent, fontSize:11),
          ),
        ),
        // player indicator line
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          padding: EdgeInsets.only(left: (timer.secondsElapsed < _secTo2100) ? (_BoardSize.small - _startOffset)/_secTo2100 * timer.secondsElapsed + 13.0 : _BoardSize.small - 2, bottom: 30,),
          child: SizedBox(
            height: 30,
            width: 4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                color: (timer.secondsElapsed*3/_secTo2100 + 1 < 2) ? PuzzleColors.blueLightAccent :
                (timer.secondsElapsed*3/_secTo2100 + 1 < 3) ? PuzzleColors.lilaLightAccent :
                (timer.secondsElapsed*3/_secTo2100 + 1 < 4) ? PuzzleColors.roseLightAccent :
                PuzzleColors.redLightAccent,
              ),
            ),
          ),
        ),
        // temperature text
        AnimatedContainer(
            curve: Curves.ease,
            duration: const Duration(milliseconds: 500),
            padding: EdgeInsets.only(left: (timer.secondsElapsed < _secTo2100) ? (_BoardSize.small - _startOffset)/_secTo2100 * timer.secondsElapsed + 0.0 : _BoardSize.small + 5, bottom: 80),
            child: Text(
              "${(timer.secondsElapsed*3/_secTo2100 + 1).toStringAsFixed(1)}°C",
              textAlign: TextAlign.center,
              style: PuzzleTextStyle.thermometer.copyWith(
                  color: (timer.secondsElapsed*3/_secTo2100 + 1 < 2) ? PuzzleColors.blueLightAccent :
                  (timer.secondsElapsed*3/_secTo2100 + 1 < 3) ? PuzzleColors.lilaLightAccent :
                  (timer.secondsElapsed*3/_secTo2100 + 1 < 4) ? PuzzleColors.roseLightAccent :
                  PuzzleColors.redLightAccent,
                  fontSize: 20
              ),
            )
        ),
        // background frame
        Container(
          decoration: const BoxDecoration(
            //border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight, // 10% of the width, so there are ten blinds.
              colors: <Color>[
                PuzzleColors.blueLightAccent,
                PuzzleColors.lilaLightAccent,
                PuzzleColors.roseLightAccent,
                PuzzleColors.redLightAccent,
              ], // red to yellow
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          height: 20,
          width: _BoardSize.small + 10,
        ),
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            //border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: PuzzleColors.blueLightAccent,
          ),
        )
      ],
    );
  }

  Stack buildMiddleThermometer(TimerState timer) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        // No policy indicator line
        Container(
          padding: EdgeInsets.only(left: _BoardSize.medium, top: 20),
          child: SizedBox(
            height: 20.0,
            width: 2.0,
            child:
            Container(
              color: PuzzleColors.redLightAccent,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: _BoardSize.medium-15, top: 60),
          child: Text(
            "> 4°C",
            style: PuzzleTextStyle.thermometer.copyWith(color: PuzzleColors.redLightAccent,),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: _BoardSize.medium*2/3, top: 20),
          child: SizedBox(
            height: 20.0,
            width: 2.0,
            child:
            Container(
              color: PuzzleColors.roseLightAccent,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: _BoardSize.medium*2/3-15, top: 60),
          child: Text(
            "+ 3°C",
            style: PuzzleTextStyle.thermometer.copyWith(color: PuzzleColors.roseLightAccent,),
          ),
        ),
        // paris agreement indicator line
        Container(
          padding: EdgeInsets.only(left: _BoardSize.medium/3, top: 20),
          child: SizedBox(
            height: 20.0,
            width: 2.0,
            child:
            Container(
              color: PuzzleColors.lilaLightAccent,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: _BoardSize.medium/3-15, top: 60),
          child: Text(
            "+ 2°C",
            style: PuzzleTextStyle.thermometer.copyWith(color: PuzzleColors.lilaLightAccent,),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: _BoardSize.medium/3-40, top: 90),
          child: Text(
            "(Paris Agreement)",
            style: PuzzleTextStyle.thermometer.copyWith(color: PuzzleColors.lilaLightAccent, fontSize:11),
          ),
        ),
        // player indicator line
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          padding: EdgeInsets.only(left: (timer.secondsElapsed < _secTo2100) ? (_BoardSize.medium - _startOffset)/_secTo2100 * timer.secondsElapsed + 13.0 : _BoardSize.medium - 2, bottom: 30,),
          child: SizedBox(
            height: 30,
            width: 4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                color: (timer.secondsElapsed*3/_secTo2100 + 1 < 2) ? PuzzleColors.blueLightAccent :
                (timer.secondsElapsed*3/_secTo2100 + 1 < 3) ? PuzzleColors.lilaLightAccent :
                (timer.secondsElapsed*3/_secTo2100 + 1 < 4) ? PuzzleColors.roseLightAccent :
                PuzzleColors.redLightAccent,
              ),
            ),
          ),
        ),
        // temperature text
        AnimatedContainer(
            curve: Curves.ease,
            duration: const Duration(milliseconds: 500),
            padding: EdgeInsets.only(left: (timer.secondsElapsed < _secTo2100) ? (_BoardSize.medium - _startOffset)/_secTo2100 * timer.secondsElapsed + 0.0 : _BoardSize.medium + 5, bottom: 80),
            child: Text(
              "${(timer.secondsElapsed*3/_secTo2100 + 1).toStringAsFixed(1)}°C",
              textAlign: TextAlign.center,
              style: PuzzleTextStyle.thermometer.copyWith(
                  color: (timer.secondsElapsed*3/_secTo2100 + 1 < 2) ? PuzzleColors.blueLightAccent :
                  (timer.secondsElapsed*3/_secTo2100 + 1 < 3) ? PuzzleColors.lilaLightAccent :
                  (timer.secondsElapsed*3/_secTo2100 + 1 < 4) ? PuzzleColors.roseLightAccent :
                  PuzzleColors.redLightAccent,
                  fontSize: 20
              ),
            )
        ),
        // background frame
        Container(
          decoration: const BoxDecoration(
            //border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight, // 10% of the width, so there are ten blinds.
              colors: <Color>[
                PuzzleColors.blueLightAccent,
                PuzzleColors.lilaLightAccent,
                PuzzleColors.roseLightAccent,
                PuzzleColors.redLightAccent,
              ], // red to yellow
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          height: 20,
          width: _BoardSize.medium + 10,
        ),
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            //border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: PuzzleColors.blueLightAccent,
          ),
        )
      ],
    );
  }


  Stack buildLargeThermometer(TimerState timer) {
    return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // No policy indicator line
              Container(
                padding: EdgeInsets.only(left: 60.0, bottom: _BoardSize.large/1),
                child: SizedBox(
                  height: 2.0,
                  width: 60.0,
                  child:
                  Container(
                    color: PuzzleColors.roseLightAccent,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 75.0, bottom: _BoardSize.large/1+5),
                child: Text(
                  "> 4°C",
                  style: PuzzleTextStyle.thermometer.copyWith(color: PuzzleColors.redLightAccent,),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 60.0, bottom: _BoardSize.large*2/3),
                child: SizedBox(
                  height: 2.0,
                  width: 60.0,
                  child:
                  Container(
                    color: PuzzleColors.roseLightAccent,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 75.0, bottom: _BoardSize.large*2/3+5),
                child: Text(
                  "+ 3°C",
                  style: PuzzleTextStyle.thermometer.copyWith(color: PuzzleColors.roseLightAccent,),
                ),
              ),
              // paris agreement indicator line
              Container(
                padding: EdgeInsets.only(left: 60.0, bottom: _BoardSize.large/3),
                child: SizedBox(
                  height: 2.0,
                  width: 60.0,
                  child:
                  Container(
                    color: PuzzleColors.lilaLightAccent,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 75.0, bottom: _BoardSize.large/3+5),
                child: Text(
                  "+ 2°C",
                  style: PuzzleTextStyle.thermometer.copyWith(color: PuzzleColors.lilaLightAccent,),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 130.0, bottom: _BoardSize.large/3-20),
                child: Text(
                  "(Paris Agreement)",
                  style: PuzzleTextStyle.thermometer.copyWith(color: PuzzleColors.lilaLightAccent, fontSize:11),
                ),
              ),
              // player indicator line
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
                padding: EdgeInsets.only(right: 90.0, bottom: (timer.secondsElapsed < _secTo2100) ? (_BoardSize.large - _startOffset)/_secTo2100 * timer.secondsElapsed + 13.0 : _BoardSize.large - 2,),
                child: SizedBox(
                  height: 4.0,
                  width: 90.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      color: (timer.secondsElapsed*3/_secTo2100 + 1 < 2) ? PuzzleColors.blueLightAccent :
                      (timer.secondsElapsed*3/_secTo2100 + 1 < 3) ? PuzzleColors.lilaLightAccent :
                      (timer.secondsElapsed*3/_secTo2100 + 1 < 4) ? PuzzleColors.roseLightAccent :
                      PuzzleColors.redLightAccent,
                    ),
                  ),
                ),
              ),
              // temperature text
              AnimatedContainer(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 500),
                padding: EdgeInsets.only(right: 100.0, bottom: (timer.secondsElapsed < _secTo2100) ? (_BoardSize.large - _startOffset)/_secTo2100 * timer.secondsElapsed + 15.0 : _BoardSize.large + 5,),
                child: Text(
                  "+ ${(timer.secondsElapsed*3/_secTo2100 + 1).toStringAsFixed(1)}°C",
                  style: PuzzleTextStyle.thermometer.copyWith(
                  color: (timer.secondsElapsed*3/_secTo2100 + 1 < 2) ? PuzzleColors.blueLightAccent :
                    (timer.secondsElapsed*3/_secTo2100 + 1 < 3) ? PuzzleColors.lilaLightAccent :
                    (timer.secondsElapsed*3/_secTo2100 + 1 < 4) ? PuzzleColors.roseLightAccent :
                    PuzzleColors.redLightAccent,
                  fontSize: 20
                  ),
                )
              ),
              // background frame
              Container(
                decoration: const BoxDecoration(
                  //border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter, // 10% of the width, so there are ten blinds.
                    colors: <Color>[
                      PuzzleColors.blueLightAccent,
                      PuzzleColors.lilaLightAccent,
                      PuzzleColors.roseLightAccent,
                      PuzzleColors.redLightAccent,
                    ], // red to yellow
                    tileMode: TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),
                height: _BoardSize.large + 10,
                width: 20,
              ),
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  //border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: PuzzleColors.blueLightAccent,
                ),
              )
            ],
          );
  }
}

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}