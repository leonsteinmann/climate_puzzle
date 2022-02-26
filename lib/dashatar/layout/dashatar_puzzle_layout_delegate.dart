import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

import '../../colors/colors.dart';
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
  Widget backgroundBuilder(PuzzleState state) {
    return Positioned(
      bottom: 74,
      right: 50,
      child: Container(),
      /*child: ResponsiveLayoutBuilder(
        small: (_, child) => const SizedBox(),
        medium: (_, child) => const SizedBox(),
        large: (_, child) => const DashatarThemePicker(),
      ),*/
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
                  children: [
                    buildCompositionText(),
                    Image.asset(
                      'assets/images/earth_background.png',
                      key: const Key('earth_background'),
                    ),
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
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          buildUpperCase("CH", main2, fontSize),
                          buildLowerCase("4", main2, fontSize),
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
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        children: [
                          buildUpperCase("HFC", main4, fontSize),
                          buildLowerCase("s", main4, fontSize),
                          buildUpperCase(", PFC", main4, fontSize),
                          buildLowerCase("s", main4, fontSize),
                          buildUpperCase(", \nSF", main4, fontSize),
                          buildLowerCase("6", main4, fontSize),
                          buildUpperCase(", NF", main4, fontSize),
                          buildLowerCase("3", main4, fontSize),
                          buildUpperCase("", main4, fontSize),
                        ],
                      ),
                    ),
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
        offset: Offset(0.0, fontSize/2),
        child: Text(
          text,
          style: PuzzleTextStyle.composition.copyWith(color: color, fontSize: fontSize),
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