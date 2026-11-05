import 'package:material_ui/material_ui.dart';

import 'base_span_builder.dart';

/// {@template widget_span_builder}
/// A span builder that creates [WidgetSpan] objects for censored text.
///
/// {@macro base_span_builder}
///
/// This implementation replaces censored words with widgets using [WidgetSpan].
/// When [revealAll] is true, the original text is shown instead of the widget.
///
/// The replacement widget is given either as a fixed [child] or built per
/// match with [childBuilder], which receives the original profane word.
/// If both are given, [childBuilder] takes precedence.
///
/// Example:
/// ```dart
/// final builder = WidgetSpanBuilder(
///   censorIt: CensorIt.mask('Fuck this!'),
///   style: TextStyle(color: Colors.black),
///   child: Icon(Icons.block, size: 16),
///   alignment: .middle,
/// );
/// final spans = builder.buildSpans(revealAll: false);
/// ```
/// {@endtemplate}
class WidgetSpanBuilder extends BaseSpanBuilder<InlineSpan> {
  /// {@macro widget_span_builder}
  WidgetSpanBuilder({
    required super.censorIt,
    required super.style,
    this.child,
    this.childBuilder,
    this.alignment = PlaceholderAlignment.middle,
    this.baseline = TextBaseline.ideographic,
  }) : assert(
         child != null || childBuilder != null,
         'Either child or childBuilder must be provided.',
       );

  /// The widget to display in place of every censored word.
  final Widget? child;

  /// Builds the widget to display in place of a censored word.
  ///
  /// Receives the original profane word. Takes precedence over [child].
  final Widget Function(String word)? childBuilder;

  /// How to align the widget vertically within the text line.
  final PlaceholderAlignment alignment;

  /// The baseline to use when [alignment] is [.baseline].
  final TextBaseline? baseline;

  @override
  InlineSpan buildPlainSpan(String text) => TextSpan(
    text: text,
    style: style,
  );

  @override
  InlineSpan buildCensoredSpan(
    String originalWord,
    int index,
    bool revealedAll,
  ) => revealedAll
      ? TextSpan(text: originalWord, style: style)
      : WidgetSpan(
          alignment: alignment,
          baseline: baseline,
          child: childBuilder?.call(originalWord) ?? child!,
        );
}
