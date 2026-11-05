import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// Text without any profanity.
const cleanText = 'Hello world';

/// Text with a single profane word.
const profaneText = 'Fuck this!';

/// Text with two profane words separated by regular words.
const twoMatchesText = 'Fuck this, fuck that';

/// Pumps [child] inside a [MaterialApp] with a bounded [width].
///
/// Pass `width: null` to leave the width unbounded.
Future<void> pumpApp(
  WidgetTester tester,
  Widget child, {
  double? width = 300,
}) => tester.pumpWidget(
  MaterialApp(
    home: Scaffold(
      body: Center(
        child: width == null ? child : SizedBox(width: width, child: child),
      ),
    ),
  ),
);

/// Joins the plain text of [spans], skipping widget placeholders.
String plainText(List<InlineSpan> spans) =>
    spans.map((s) => s.toPlainText(includePlaceholders: false)).join();

/// Counts case-insensitive occurrences of [part] in [source].
int countOccurrences(String source, String part) =>
    part.toLowerCase().allMatches(source.toLowerCase()).length;
