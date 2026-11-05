import 'package:censor_it_flutter/censor_it_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/helpers.dart';

void main() {
  group('CensorItWidget.overlayBuilder', () {
    testWidgets('renders clean text without building overlays', (
      tester,
    ) async {
      var called = false;

      await pumpApp(
        tester,
        CensorItWidget.overlayBuilder(
          cleanText,
          builder: (context, word, revealed) {
            called = true;
            return const SizedBox();
          },
        ),
      );

      expect(find.text(cleanText), findsOneWidget);
      expect(called, isFalse);
    });

    testWidgets('builds an overlay for the profane word', (tester) async {
      String? receivedWord;

      await pumpApp(
        tester,
        CensorItWidget.overlayBuilder(
          profaneText,
          builder: (context, word, revealed) {
            receivedWord = word;
            return const ColoredBox(key: Key('overlay'), color: Colors.black);
          },
        ),
      );

      expect(find.byKey(const Key('overlay')), findsWidgets);
      expect(receivedWord?.toLowerCase(), contains('fuck'));
    });

    testWidgets('starts in the hidden state', (tester) async {
      bool? revealedOnFirstBuild;

      await pumpApp(
        tester,
        CensorItWidget.overlayBuilder(
          profaneText,
          builder: (context, word, revealed) {
            revealedOnFirstBuild ??= revealed;
            return const SizedBox();
          },
        ),
      );

      expect(revealedOnFirstBuild, isFalse);
    });

    group('onTap', () {
      Widget overlay({bool Function(bool)? onTap}) =>
          CensorItWidget.overlayBuilder(
            profaneText,
            onTap: onTap,
            builder: (context, word, revealed) =>
                Text(revealed ? 'revealed' : 'hidden'),
          );

      testWidgets('toggles the revealed state', (tester) async {
        await pumpApp(tester, overlay(onTap: (isRevealed) => !isRevealed));

        expect(find.text('hidden'), findsWidgets);
        expect(find.text('revealed'), findsNothing);

        await tester.tap(find.byType(CensorItOverlayBuilder));
        await tester.pump();

        expect(find.text('revealed'), findsWidgets);
        expect(find.text('hidden'), findsNothing);

        await tester.tap(find.byType(CensorItOverlayBuilder));
        await tester.pump();

        expect(find.text('hidden'), findsWidgets);
        expect(find.text('revealed'), findsNothing);
      });

      testWidgets('receives the current revealed state', (tester) async {
        final received = <bool>[];

        await pumpApp(
          tester,
          overlay(
            onTap: (isRevealed) {
              received.add(isRevealed);
              return !isRevealed;
            },
          ),
        );

        await tester.tap(find.byType(CensorItOverlayBuilder));
        await tester.pump();
        await tester.tap(find.byType(CensorItOverlayBuilder));
        await tester.pump();

        expect(received, [false, true]);
      });

      testWidgets('is ignored when null', (tester) async {
        await pumpApp(tester, overlay());

        await tester.tap(find.byType(CensorItOverlayBuilder));
        await tester.pump();

        expect(find.text('hidden'), findsWidgets);
        expect(find.text('revealed'), findsNothing);
      });
    });

    group('layout', () {
      testWidgets('does not throw when the width is unbounded', (
        tester,
      ) async {
        await pumpApp(
          tester,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CensorItWidget.overlayBuilder(
                profaneText,
                builder: (context, word, revealed) =>
                    const ColoredBox(color: Colors.black),
              ),
            ],
          ),
          width: null,
        );

        expect(tester.takeException(), isNull);
      });
    });
  });
}
