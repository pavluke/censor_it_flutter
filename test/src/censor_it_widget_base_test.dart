import 'package:censor_it_flutter/censor_it_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/helpers.dart';

String _noop(BuildContext context, String word) => '***';

void main() {
  group('CensorItWidget', () {
    group('factory constructors', () {
      test('textBuilder creates CensorItTextBuilder', () {
        const widget = CensorItWidget.textBuilder('text', builder: _noop);

        expect(widget, isA<CensorItTextBuilder>());
        expect(widget.text, 'text');
      });

      test('widgetBuilder creates CensorItWidgetBuilder', () {
        final widget = CensorItWidget.widgetBuilder(
          'text',
          builder: (context, word) => const SizedBox(),
        );

        expect(widget, isA<CensorItWidgetBuilder>());
      });

      test('overlayBuilder creates CensorItOverlayBuilder', () {
        final widget = CensorItWidget.overlayBuilder(
          'text',
          builder: (context, word, revealed) => const SizedBox(),
        );

        expect(widget, isA<CensorItOverlayBuilder>());
      });
    });

    group('style merging', () {
      testWidgets('custom style is merged over theme bodyMedium', (
        tester,
      ) async {
        await pumpApp(
          tester,
          const CensorItWidget.textBuilder(
            'Hello',
            builder: _noop,
            style: TextStyle(fontSize: 33),
          ),
        );

        final text = tester.widget<Text>(find.text('Hello'));

        expect(text.style?.fontSize, 33);
      });

      testWidgets('falls back to the theme style when style is null', (
        tester,
      ) async {
        await pumpApp(
          tester,
          const CensorItWidget.textBuilder('Hello', builder: _noop),
        );

        final context = tester.element(find.text('Hello'));
        final text = tester.widget<Text>(find.text('Hello'));

        expect(
          text.style?.fontSize,
          Theme.of(context).textTheme.bodyMedium?.fontSize,
        );
      });
    });
  });
}
