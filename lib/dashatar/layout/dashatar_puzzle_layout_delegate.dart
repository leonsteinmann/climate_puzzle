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
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16),
                    children: [
                      buildUpperCase("CO", Colors.yellow),
                      buildLowerCase("2", Colors.yellow),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16),
                    children: [
                      buildUpperCase("CH", Colors.red),
                      buildLowerCase("4", Colors.red),
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
                    style: TextStyle(fontSize: 16),
                    children: [
                      buildUpperCase("N", Colors.green),
                      buildLowerCase("2", Colors.green),
                      buildUpperCase("O", Colors.green),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    style: TextStyle(fontSize: 16),
                    children: [
                      buildUpperCase("Fluorinated gases \n HFC", Colors.blue),
                      buildLowerCase("s", Colors.blue),
                      buildUpperCase(", PFC", Colors.blue),
                      buildLowerCase("s", Colors.blue),
                      buildUpperCase(", SF", Colors.blue),
                      buildLowerCase("6", Colors.blue),
                      buildUpperCase(", NF", Colors.blue),
                      buildLowerCase("3", Colors.blue),
                      buildUpperCase("", Colors.blue),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }

  TextSpan buildUpperCase(String text, Color color) {
    return TextSpan(
      text: text,
      style: PuzzleTextStyle.composition.copyWith(color: color),
    );
  }

  WidgetSpan buildLowerCase(String text, Color color) {
    return WidgetSpan(
      child: Transform.translate(
        offset: const Offset(0.0, 4.0),
        child: Text(
          text,
          style: PuzzleTextStyle.composition.copyWith(color: color),
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