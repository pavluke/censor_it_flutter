import 'package:censor_it_flutter/censor_it_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/helpers.dart';

void main() {
  const style = TextStyle(fontSize: 14);
  const censoredStyle = TextStyle(color: Colors.red);

  TextSpanBuilder buildFor(String text) => TextSpanBuilder(
    censorIt: CensorIt.mask(text),
    style: style,
    censoredStyle: censoredStyle,
  );

  group('TextSpanBuilder', () {
    group('buildSpans', () {
      test('returns a single plain span when there is no profanity', () {
        final spans = buildFor(cleanText).buildSpans(revealAll: false);

        expect(spans, hasLength(1));
        expect(spans.single.text, cleanText);
        expect(spans.single.style, style);
      });

      test('returns a single empty span for an empty string', () {
        final spans = buildFor('').buildSpans();

        expect(spans, hasLength(1));
        expect(spans.single.text, '');
      });

      test('revealAll: true restores the original text', () {
        final spans = buildFor(profaneText).buildSpans(revealAll: true);

        expect(plainText(spans), profaneText);
      });

      test('revealAll: false hides the original word', () {
        final spans = buildFor(profaneText).buildSpans(revealAll: false);

        expect(plainText(spans).toLowerCase(), isNot(contains('fuck')));
      });

      test('applies censoredStyle only to censored spans', () {
        final spans = buildFor(profaneText).buildSpans(revealAll: false);

        expect(spans.where((s) => s.style == censoredStyle), isNotEmpty);
        expect(spans.where((s) => s.style == style), isNotEmpty);
      });
    });

    group('with several matches', () {
      test('does not duplicate the surrounding text', () {
        final spans = buildFor(twoMatchesText).buildSpans(revealAll: false);
        final text = plainText(spans);

        expect(countOccurrences(text, 'this'), 1, reason: 'got: $text');
        expect(countOccurrences(text, 'that'), 1, reason: 'got: $text');
      });

      test('keeps the original length when masking', () {
        final spans = buildFor(twoMatchesText).buildSpans(revealAll: false);
        final text = plainText(spans);

        expect(text.length, twoMatchesText.length, reason: 'got: $text');
      });

      test('revealAll: true restores the original text', () {
        final spans = buildFor(twoMatchesText).buildSpans(revealAll: true);

        expect(plainText(spans), twoMatchesText);
      });
    });
  });
}
