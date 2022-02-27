import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../colors/colors.dart';
import '../../puzzle/widgets/puzzle_background_airplanes.dart';
import '../../typography/typography.dart';

/// {@template dashatar_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [DashatarTheme].
/// {@endtemplate}
class DashatarPuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro dashatar_puzzle_layout_delegate}
  const DashatarPuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: child,
      ),
      child: (_) => DashatarStartSection(state: state),
    );
  }

  @override
  Widget endSectionBuilder(PuzzleState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const ResponsiveGap(
          small: 23,
          medium: 32,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => const DashatarPuzzleActionButton(),
          medium: (_, child) => const DashatarPuzzleActionButton(),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 54,
        ),
        /*ResponsiveLayoutBuilder(
          small: (_, child) => const DashatarThemePicker(),
          medium: (_, child) => const DashatarThemePicker(),
          large: (_, child) => const SizedBox(),
        ),*/
        const ResponsiveGap(
          small: 32,
          medium: 54,
        ),
        const ResponsiveGap(
          large: 130,
        ),
        const DashatarCountdown(),
      ],
    );
  }

  @override
  Widget boardBuilder(int size, List<Widget> tiles) {
    return Stack(
      children: [
        Column(
          children: [
            const ResponsiveGap(
              small: 21,
              medium: 34,
              large: 96,
            ),
            DashatarPuzzleBoard(tiles: tiles),
            const ResponsiveGap(
              large: 96,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) {
    return DashatarPuzzleTile(
      tile: tile,
      state: state,
    );
  }

  @override
  Widget whitespaceTileBuilder() {
    return const SizedBox();
  }

  @override
  List<Object?> get props => [];

  @override
  Widget boardBackgroundBuilder() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            const ResponsiveGap(
              small: 32,
              medium: 48,
              large: 96,
            ),
            ResponsiveLayoutBuilder(
              small: (_, __) => SizedBox.square(
                dimension: _BoardSize.small*1.5,
                child: Stack(
                  /// TODO:Alignement to center??
                  children: [
                    buildCompositionText(),
                    Image.asset(
                      'assets/images/earth_background.png',
                      key: const Key('earth_background'),
                    ),
                    /*Stack(
                      children: buildAirplanes(_BoardSize.small*1.5, 5, _),
                    ),*/
                  ],
                ),
              ),
              medium: (_, __) => SizedBox.square(
                dimension: _BoardSize.medium*1.5,
                child: Stack(
                  children: [
                    buildCompositionText(),
                    Image.asset(
                      'assets/images/earth_background.png',
                      key: const Key('earth_background'),
                    ),
                    Stack(
                      children: buildAirplanes(_BoardSize.medium*1.5, 15, _),
                    ),
                  ],
                ),
              ),
              large: (_, __) => SizedBox.square(
                dimension: _BoardSize.large*1.5,
                child: Stack(
                  children: [
                    buildCompositionText(),
                    Image.asset(
                      'assets/images/earth_background.png',
                      key: const Key('earth_background'),
                    ),
                    Stack(
                      children: buildAirplanes(_BoardSize.large*1.5, 20,  _),
                    ),
                  ],
                ),
              ),
            ),
            const ResponsiveGap(
              large: 96,
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Column(
            children: const [
              ResponsiveGap(
                small: 42,
                medium: 58,
                large: 120,
              ),
              DashatarTimer()
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> buildAirplanes(double earthSize, double airplaneSize, BuildContext context) {
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    /*List<Widget> airplanes = [];
    for (var i = 0; i < state.numberOfCorrectTiles; i++) {
      airplanes.add(
          BackgroundAirplaneWidget(
            backgroundSize: earthSize,
            airplaneSize: 25,
            duration: (Random().nextDouble() * 5 + 4).round(),
            startPosition: [earthSize/15 * i, earthSize/15 * i],
            endPosition: [earthSize - earthSize/15 * i, earthSize - earthSize/15 * i],
          )
      );
      print(airplanes[i]);
    };
    return airplanes;*/
    return [
      BackgroundAirplaneWidget(
        backgroundSize: earthSize,
        airplaneSize: airplaneSize,
        duration: 6,
        startPosition: [earthSize*0.16, earthSize*0.3],
        endPosition: [earthSize*0.14, earthSize*0.5],
      ),
      BackgroundAirplaneWidget(
        backgroundSize: earthSize,
        airplaneSize: airplaneSize,
        duration: 12,
        startPosition: [earthSize*0.83, earthSize*0.8],
        endPosition: [earthSize*0.26, earthSize*0.26],
      ),
      BackgroundAirplaneWidget(
        backgroundSize: earthSize,
        airplaneSize: airplaneSize,
        duration: 7,
        startPosition: [earthSize*0.7, earthSize*0.2],
        endPosition: [earthSize*0.2, earthSize*0.7],
      ),
      BackgroundAirplaneWidget(
        backgroundSize: earthSize,
        airplaneSize: airplaneSize,
        duration: 5,
        startPosition: [earthSize*0.7, earthSize*0.2],
        endPosition: [earthSize*0.26, earthSize*0.26],
      ),
      BackgroundAirplaneWidget(
        backgroundSize: earthSize,
        airplaneSize: airplaneSize,
        duration: 9,
        startPosition: [earthSize*0.9, earthSize*0.3],
        endPosition: [earthSize*0.8, earthSize*0.78],
      ),
      BackgroundAirplaneWidget(
        backgroundSize: earthSize,
        airplaneSize: airplaneSize,
        duration: 6,
        startPosition: [earthSize*0.95, earthSize*0.55],
        endPosition: [earthSize*0.68, earthSize*0.28],
      ),
    ];
  }

  ResponsiveLayoutBuilder buildCompositionText() {
    const main1 = PuzzleColors.orangeLightAccent;
    const main2 = PuzzleColors.redLightAccent;
    const main3 = PuzzleColors.roseLightAccent;
    const main4 = PuzzleColors.lilaLightAccent;

    return ResponsiveLayoutBuilder(
        small: (_, child) => child!,
        medium: (_, child) => child!,
        large: (_, child) => child!,
        child: (currentSize) {
          final fontSize = currentSize == ResponsiveLayoutSize.small ? 16.0 : 22.0;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          buildUpperCase("CO", main1, fontSize),
                          buildLowerCase("2", main1, fontSize),
                          buildUpperCase(" | 80%", main1, fontSize),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          buildUpperCase("CH", main2, fontSize),
                          buildLowerCase("4", main2, fontSize),
                          buildUpperCase(" | 10%", main2, fontSize),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          buildUpperCase("N", main3, fontSize),
                          buildLowerCase("2", main3, fontSize),
                          buildUpperCase("O", main3, fontSize),
                          buildUpperCase(" | 7%", main3, fontSize),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                            children: [
                              buildUpperCase("HFC", main4, fontSize-4),
                              buildLowerCase("s", main4, fontSize-4),
                              buildUpperCase(" PFC", main4, fontSize-4),
                              buildLowerCase("s", main4, fontSize-4),
                              buildUpperCase(" \nSF", main4, fontSize-4),
                              buildLowerCase("6", main4, fontSize-4),
                              buildUpperCase(" NF", main4, fontSize-4),
                              buildLowerCase("3", main4, fontSize-4),
                            ],
                          ),
                        ),
                        RichText(
                          text: buildUpperCase(" | 3%", main4, fontSize),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        },
    );
  }

  TextSpan buildUpperCase(String text, Color color, double fontSize) {
    return TextSpan(
      text: text,
      style: PuzzleTextStyle.composition.copyWith(color: color, fontSize: fontSize),
    );
  }

  WidgetSpan buildLowerCase(String text, Color color, double fontSize) {
    return WidgetSpan(
      child: Transform.translate(
        offset: Offset(0.0, fontSize/2-4),
        child: Text(
          text,
          style: PuzzleTextStyle.composition.copyWith(color: color, fontSize: fontSize-4),
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