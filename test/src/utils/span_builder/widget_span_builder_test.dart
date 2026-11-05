import 'package:censor_it_flutter/censor_it_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/helpers.dart';

void main() {
  const style = TextStyle(fontSize: 14);
  const marker = SizedBox(key: Key('marker'), width: 10, height: 10);

  WidgetSpanBuilder buildFor(
    String text, {
    PlaceholderAlignment? alignment,
    TextBaseline? baseline,
  }) => WidgetSpanBuilder(
    censorIt: CensorIt.mask(text),
    style: style,
    child: marker,
    alignment: alignment ?? PlaceholderAlignment.middle,
    baseline: baseline ?? TextBaseline.ideographic,
  );

  group('WidgetSpanBuilder', () {
    group('buildSpans', () {
      test('returns a single TextSpan when there is no profanity', () {
        final spans = buildFor(cleanText).buildSpans(revealAll: false);

        expect(spans, hasLength(1));
        expect(spans.single, isA<TextSpan>());
      });

      test('revealAll: false replaces profanity with a WidgetSpan', () {
        final spans = buildFor(profaneText).buildSpans(revealAll: false);
        final widgetSpans = spans.whereType<WidgetSpan>().toList();

        expect(widgetSpans, hasLength(1));
        expect(widgetSpans.single.child, marker);
      });

      test('revealAll: true contains no WidgetSpan and keeps the text', () {
        final spans = buildFor(profaneText).buildSpans(revealAll: true);

        expect(spans.whereType<WidgetSpan>(), isEmpty);
        expect(plainText(spans), profaneText);
      });

      test('creates a WidgetSpan per match', () {
        final spans = buildFor(twoMatchesText).buildSpans(revealAll: false);

        expect(spans.whereType<WidgetSpan>(), hasLength(2));
      });
    });

    group('alignment and baseline', () {
      test('are passed to the WidgetSpan', () {
        final span = buildFor(
          profaneText,
          alignment: PlaceholderAlignment.top,
          baseline: TextBaseline.alphabetic,
        ).buildSpans(revealAll: false).whereType<WidgetSpan>().single;

        expect(span.alignment, PlaceholderAlignment.top);
        expect(span.baseline, TextBaseline.alphabetic);
      });

      test('default to middle and ideographic', () {
        final span = WidgetSpanBuilder(
          censorIt: CensorIt.mask(profaneText),
          style: style,
          child: marker,
        ).buildSpans(revealAll: false).whereType<WidgetSpan>().single;

        expect(span.alignment, PlaceholderAlignment.middle);
        expect(span.baseline, TextBaseline.ideographic);
      });
    });
  });
}
