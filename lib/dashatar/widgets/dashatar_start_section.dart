import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/theme/widgets/puzzleDescription.dart';

import '../../colors/colors.dart';

/// {@template dashatar_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
class DashatarStartSection extends StatelessWidget {
  /// {@macro dashatar_start_section}
  const DashatarStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((DashatarPuzzleBloc bloc) => bloc.state.status);

    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        /*padding: EdgeInsets.all(20),
        decoration: const BoxDecoration(
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
        ),*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ResponsiveGap(
              small: 10,
              medium: 20,
              large: 151,
            ),

            PuzzleTitle(
              key: puzzleTitleKey,
              title: context.l10n.puzzleChallengeTitle,
            ),
            const ResponsiveGap(large: 16),
            PuzzleDescription(
                key: puzzleDescriptionKey,
                text: context.l10n.puzzleChallengeDescription,
            ),
            const ResponsiveGap(
              small: 10,
              medium: 15,
              large: 32,
            ),
            /*NumberOfMovesAndTilesLeft(
              key: numberOfMovesAndTilesLeftKey,
              numberOfMoves: state.numberOfMoves,
              numberOfTilesLeft: status == DashatarPuzzleStatus.started
                  ? state.numberOfTilesLeft
                  : state.puzzle.tiles.length - 1,
            ),*/
            /*const ResponsiveGap(
              small: 5,
              medium: 10,
              large: 32,
            ),*/
            ResponsiveLayoutBuilder(
              small: (_, __) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DashatarPuzzleActionButton(),
                ],
              ),
              medium: (_, __) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DashatarPuzzleActionButton(),
                ],
              ),
              large: (_, __) => const DashatarPuzzleActionButton(),
            ),
            /*ResponsiveLayoutBuilder(
              small: (_, __) => const DashatarTimer(),
              medium: (_, __) => const DashatarTimer(),
              large: (_, __) => const SizedBox(),
            ),*/
          ],
        ),
      ),
    );
  }
}
