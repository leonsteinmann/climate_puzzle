import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

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
        padding: const EdgeInsets.only(left: 50, right: 32),
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
        ResponsiveLayoutBuilder(
          small: (_, child) => const DashatarThemePicker(),
          medium: (_, child) => const DashatarThemePicker(),
          large: (_, child) => const SizedBox(),
        ),
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
      child: ResponsiveLayoutBuilder(
        small: (_, child) => const SizedBox(),
        medium: (_, child) => const SizedBox(),
        large: (_, child) => const DashatarThemePicker(),
      ),
    );
  }

  @override
  Widget boardBuilder(int size, List<Widget> tiles) {
    return Stack(
      children: [
        Positioned(
          top: 24,
          left: 0,
          right: 0,
          child: ResponsiveLayoutBuilder(
            small: (_, child) => const SizedBox(),
            medium: (_, child) => const SizedBox(),
            large: (_, child) => const DashatarTimer(),
          ),
        ),
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
    return Column(
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
    );
  }

  Padding buildCompositionText() {
    return Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "CO",
                        style: PuzzleTextStyle.composition.copyWith(color: Colors.white),
                      ),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(0.0, 4.0),
                          child: Text(
                            '2',
                            style: PuzzleTextStyle.composition.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "CH",
                        style: PuzzleTextStyle.composition.copyWith(color: Colors.red),
                      ),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(0.0, 4.0),
                          child: Text(
                            '4',
                            style: PuzzleTextStyle.composition.copyWith(color: Colors.red),
                          ),
                        ),
                      ),
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
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "N",
                        style: PuzzleTextStyle.composition.copyWith(color: Colors.black),
                      ),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(0.0, 4.0),
                          child: Text(
                            '2',
                            style: PuzzleTextStyle.composition.copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "O",
                        style: PuzzleTextStyle.composition.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "H",
                        style: PuzzleTextStyle.composition.copyWith(color: Colors.blue),
                      ),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(0.0, 4.0),
                          child: Text(
                            '2',
                            style: PuzzleTextStyle.composition.copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "O",
                        style: PuzzleTextStyle.composition.copyWith(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }
}

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}