import 'package:censor_it_flutter/censor_it_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/helpers.dart';

void main() {
  group('CensorItWidget.textBuilder', () {
    testWidgets('renders clean text unchanged', (tester) async {
      await pumpApp(
        tester,
        CensorItWidget.textBuilder(
          cleanText,
          builder: (context, word) => '[censored]',
        ),
      );

      expect(find.text(cleanText), findsOneWidget);
    });

    testWidgets('replaces profanity with builder output', (tester) async {
      await pumpApp(
        tester,
        CensorItWidget.textBuilder(
          profaneText,
          builder: (context, word) => '[censored]',
        ),
      );

      expect(
        find.textContaining('[censored]', findRichText: true),
        findsOneWidget,
      );
      expect(find.textContaining('Fuck', findRichText: true), findsNothing);
    });

    testWidgets('passes the original word to the builder', (tester) async {
      final words = <String>[];

      await pumpApp(
        tester,
        CensorItWidget.textBuilder(
          profaneText,
          builder: (context, word) {
            words.add(word);
            return '[censored]';
          },
        ),
      );

      expect(words, isNotEmpty);
      expect(words.first.toLowerCase(), contains('fuck'));
    });

    group('with censoredStyle', () {
      testWidgets('replaces profanity and keeps the rest of the text', (
        tester,
      ) async {
        await pumpApp(
          tester,
          CensorItWidget.textBuilder(
            profaneText,
            builder: (context, word) => '[censored]',
            censoredStyle: const TextStyle(color: Colors.red),
          ),
        );

        expect(
          find.textContaining('[censored]', findRichText: true),
          findsOneWidget,
        );
        expect(
          find.textContaining('this', findRichText: true),
          findsOneWidget,
        );
      });

      testWidgets('calls the builder exactly once per match', (tester) async {
        var calls = 0;

        await pumpApp(
          tester,
          CensorItWidget.textBuilder(
            profaneText,
            censoredStyle: const TextStyle(color: Colors.red),
            builder: (context, word) {
              calls++;
              return '[censored]';
            },
          ),
        );

        expect(calls, 1);
      });
    });
  });
}
