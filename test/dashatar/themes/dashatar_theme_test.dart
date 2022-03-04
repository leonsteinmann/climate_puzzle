// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

import '../../helpers/helpers.dart';

void main() {
  group('DashatarTheme', () {
    group('BlueDashatarTheme', () {
      test('supports value comparisons', () {
        expect(
          BlueDashatarTheme(),
          equals(BlueDashatarTheme()),
        );
      });

      test('uses DashatarPuzzleLayoutDelegate', () {
        expect(
          BlueDashatarTheme().layoutDelegate,
          equals(DashatarPuzzleLayoutDelegate()),
        );
      });

      test('dashAssetForTile returns correct assets', () {
        final tile = MockTile();
        const tileValue = 6;
        when(() => tile.value).thenReturn(tileValue);
        expect(
          BlueDashatarTheme().dashAssetForTile(tile),
          equals('assets/images/dashatar/blue/6.png'),
        );
      });
    });

    group('GreenDashatarTheme', () {
      test('supports value comparisons', () {
        expect(
          DarkTheme(),
          equals(DarkTheme()),
        );
      });

      test('uses DashatarPuzzleLayoutDelegate', () {
        expect(
          DarkTheme().layoutDelegate,
          equals(DashatarPuzzleLayoutDelegate()),
        );
      });

      test('dashAssetForTile returns correct assets', () {
        final tile = MockTile();
        const tileValue = 6;
        when(() => tile.value).thenReturn(tileValue);
        expect(
          DarkTheme().dashAssetForTile(tile),
          equals('assets/images/dashatar/green/6.png'),
        );
      });
    });

    group('YellowDashatarTheme', () {
      test('supports value comparisons', () {
        expect(
          YellowDashatarTheme(),
          equals(YellowDashatarTheme()),
        );
      });

      test('uses DashatarPuzzleLayoutDelegate', () {
        expect(
          YellowDashatarTheme().layoutDelegate,
          equals(DashatarPuzzleLayoutDelegate()),
        );
      });

      test('dashAssetForTile returns correct assets', () {
        final tile = MockTile();
        const tileValue = 6;
        when(() => tile.value).thenReturn(tileValue);
        expect(
          YellowDashatarTheme().dashAssetForTile(tile),
          equals('assets/images/dashatar/yellow/6.png'),
        );
      });
    });
  });
}
