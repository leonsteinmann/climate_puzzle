import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/puzzle/widgets/puzzle_thermometer.dart';
import 'package:very_good_slide_puzzle/theme/themes/themes.dart';
import 'package:very_good_slide_puzzle/theme/widgets/widgets.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

import '../../timer/bloc/timer_bloc.dart';

/// {@template dashatar_score}
/// Displays the score of the solved Dashatar puzzle.
/// {@endtemplate}
class DashatarScore extends StatelessWidget {
  /// {@macro dashatar_score}
  const DashatarScore({Key? key}) : super(key: key);

  static const _smallImageOffset = Offset(360, 160);
  static const _mediumImageOffset = Offset(480, 100);
  static const _largeImageOffset = Offset(480, 100);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((DashatarThemeBloc bloc) => bloc.state.theme);
    final state = context.watch<PuzzleBloc>().state;
    final timer = context.select((TimerBloc bloc) => bloc.state);

    final l10n = context.l10n;

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (currentSize) {
        final height =
            currentSize == ResponsiveLayoutSize.small ? 374.0 : 355.0;

        final imageOffset = currentSize == ResponsiveLayoutSize.large
            ? _largeImageOffset
            : (currentSize == ResponsiveLayoutSize.medium
                ? _mediumImageOffset
                : _smallImageOffset);

        final imageHeight =
            currentSize == ResponsiveLayoutSize.small ? 374.0 : 437.0;

        final completedTextWidth =
            currentSize == ResponsiveLayoutSize.small ? 160.0 : double.infinity;

        final wellDoneTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline4Soft
            : PuzzleTextStyle.headline3;

        final timerTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline5
            : PuzzleTextStyle.headline4;

        final timerIconSize = currentSize == ResponsiveLayoutSize.small
            ? const Size(21, 21)
            : const Size(28, 28);

        final timerIconPadding =
            currentSize == ResponsiveLayoutSize.small ? 4.0 : 6.0;

        final numberOfMovesTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline5
            : PuzzleTextStyle.headline4;

        return ClipRRect(
          key: const Key('dashatar_score'),
          borderRadius: BorderRadius.circular(22),
          child: Container(
            width: double.infinity,
            height: height,
            color: PuzzleColors.black,
            child: Stack(
              children: [
                Positioned(
                  left: imageOffset.dx,
                  top: imageOffset.dy,
                  child: Image.asset(
                    'assets/images/earth_background.png',
                    height: imageHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: double.infinity,),
                      Container(
                        key: const Key('dashatar_score_completed'),
                        child: AnimatedDefaultTextStyle(
                          style: PuzzleTextStyle.headline5.copyWith(
                            color: PuzzleColors.roseLightAccent,
                          ),
                          duration: PuzzleThemeAnimationDuration.textStyle,
                          child: Text(l10n.dashatarSuccessCompleted),
                        ),
                      ),
                      const ResponsiveGap(
                        small: 8,
                        medium: 16,
                        large: 16,
                      ),
                      AnimatedDefaultTextStyle(
                        key: const Key('dashatar_score_well_done'),
                        style: wellDoneTextStyle.copyWith(
                          color: PuzzleColors.white,
                        ),
                        duration: PuzzleThemeAnimationDuration.textStyle,
                        child: Text(l10n.dashatarSuccessWellDone),
                      ),
                      /*const ResponsiveGap(
                        small: 24,
                        medium: 32,
                        large: 32,
                      ),*/
                      /*AnimatedDefaultTextStyle(
                        key: const Key('dashatar_score_score'),
                        style: PuzzleTextStyle.headline5.copyWith(
                          color: theme.defaultColor,
                        ),
                        duration: PuzzleThemeAnimationDuration.textStyle,
                        child: Text(l10n.dashatarSuccessScore),
                      ),*/
                      const ResponsiveGap(
                        small: 8,
                        medium: 9,
                        large: 9,
                      ),
                      buildSmallThermometer(timer),
                      const ResponsiveGap(
                        small: 8,
                        medium: 9,
                        large: 9,
                      ),
                      DashatarTimer(
                        textStyle: timerTextStyle,
                        iconSize: timerIconSize,
                        yearPadding: timerIconPadding,
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      const ResponsiveGap(
                        small: 2,
                        medium: 8,
                        large: 8,
                      ),
                      /*AnimatedDefaultTextStyle(
                        key: const Key('dashatar_score_number_of_moves'),
                        style: numberOfMovesTextStyle.copyWith(
                          color: PuzzleColors.white,
                        ),
                        duration: PuzzleThemeAnimationDuration.textStyle,
                        child: Text(
                          l10n.dashatarSuccessNumberOfMoves(
                            state.numberOfMoves.toString(),
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Stack buildSmallThermometer(TimerState timer) {
    final _secTo2100 = (2100.0 - DateTime.now().year.toDouble())*3;
    const _startOffset = 30.0;

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
}

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}
