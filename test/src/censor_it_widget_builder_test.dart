import 'package:censor_it_flutter/censor_it_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/helpers.dart';

void main() {
  group('CensorItWidget.widgetBuilder', () {
    testWidgets('renders clean text without a placeholder', (tester) async {
      await pumpApp(
        tester,
        CensorItWidget.widgetBuilder(
          cleanText,
          builder: (context, word) => const Icon(Icons.block),
        ),
      );

      expect(find.byIcon(Icons.block), findsNothing);
      expect(
        find.textContaining(cleanText, findRichText: true),
        findsOneWidget,
      );
    });

    testWidgets('replaces profanity with a widget', (tester) async {
      await pumpApp(
        tester,
        CensorItWidget.widgetBuilder(
          profaneText,
          builder: (context, word) => const Icon(Icons.block),
        ),
      );

      expect(find.byIcon(Icons.block), findsOneWidget);
      expect(find.textContaining('Fuck', findRichText: true), findsNothing);
    });

    testWidgets('builds a widget for every match', (tester) async {
      await pumpApp(
        tester,
        CensorItWidget.widgetBuilder(
          twoMatchesText,
          builder: (context, word) => const Icon(Icons.block),
        ),
      );

      expect(find.byIcon(Icons.block), findsNWidgets(2));
    });

    testWidgets('passes the real word to the builder, once per match', (
      tester,
    ) async {
      final words = <String>[];

      await pumpApp(
        tester,
        CensorItWidget.widgetBuilder(
          twoMatchesText,
          builder: (context, word) {
            words.add(word);
            return const SizedBox(width: 10, height: 10);
          },
        ),
      );

      expect(words, hasLength(2));
      expect(words.every((w) => w.isNotEmpty), isTrue, reason: '$words');
    });
  });
}
