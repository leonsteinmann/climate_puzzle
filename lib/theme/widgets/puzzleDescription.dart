import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template puzzle_title}
/// Displays the title of the puzzle in the given color.
/// {@endtemplate}
class PuzzleDescription extends StatelessWidget {
  /// {@macro puzzle_title}
  const PuzzleDescription({
    Key? key,
    required this.text,
    this.color,
  }) : super(key: key);

  /// The title to be displayed.
  final String text;

  /// The color of [text], defaults to [PuzzleTheme.titleColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final titleColor = color ?? theme.titleColor;

    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(
        child: SizedBox(
          width: 300,
          child: Center(
            child: child,
          ),
        ),
      ),
      medium: (context, child) => Center(
        child: SizedBox(
          width: 300,
          child: Center(
            child: child,
          ),
        ),
      ),
      large: (context, child) => SizedBox(
        width: 300,
        child: child,
      ),
      child: (currentSize) {
        final textStyle = (currentSize == ResponsiveLayoutSize.large
            ? PuzzleTextStyle.bodySmall
            : PuzzleTextStyle.bodyXSmall)
            .copyWith(color: titleColor);

        final textAlign = currentSize == ResponsiveLayoutSize.small
            ? TextAlign.center
            : TextAlign.left;

        return AnimatedDefaultTextStyle(
          style: textStyle,
          duration: PuzzleThemeAnimationDuration.textStyle,
          child: Text(
            text,
            textAlign: textAlign,
          ),
        );
      },
    );
  }
}