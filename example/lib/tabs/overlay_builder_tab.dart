import 'package:censor_it_flutter/censor_it_flutter.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/text_styles.dart';
import '../widgets/example_label.dart';
import '../widgets/info_card.dart';
import '../widgets/result_card.dart';

class OverlayBuilderTab extends StatelessWidget {
  const OverlayBuilderTab({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const .all(24),
    child: Column(
      spacing: 16,
      crossAxisAlignment: .start,
      children: [
        const InfoCard(
          icon: Icons.blur_on,
          title: 'Overlay Builder Mode',
          description: 'Apply effects over profanity. Tap to reveal!',
          color: Colors.purple,
        ),
        const ExampleLabel('Blur Effect (Tap to reveal)'),
        ResultCard(
          child: CensorItWidget.overlayBuilder(
            text,
            pattern: LanguagePattern.english,
            onTap: (isRevealed) => !isRevealed,
            style: AppTextStyles.normal,
            censoredStyle: AppTextStyles.censoredRed,
            builder: (context, word, isRevealed) => TweenAnimationBuilder(
              tween: Tween(begin: 0, end: isRevealed ? 0.0 : 1.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                final blurValue = 5 * value.toDouble();
                return ClipRRect(
                  child: BackdropFilter(
                    filter: .blur(sigmaX: blurValue, sigmaY: blurValue),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.1 * value),
                        borderRadius: .circular(4),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const ExampleLabel('Dark Overlay (Tap to reveal)'),
        ResultCard(
          child: CensorItWidget.overlayBuilder(
            text,
            pattern: LanguagePattern.english,
            onTap: (isRevealed) => !isRevealed,
            style: AppTextStyles.normal,
            censoredStyle: AppTextStyles.censoredBold,
            builder: (context, word, isRevealed) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: isRevealed
                    ? Colors.transparent
                    : Colors.black.withValues(alpha: 0.85),
                borderRadius: .circular(4),
              ),
              child: isRevealed
                  ? null
                  : const Center(
                      child: Text(
                        '18+',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
            ),
          ),
        ),
        const ExampleLabel('Blocked Gradient Overlay'),
        ResultCard(
          child: CensorItWidget.overlayBuilder(
            text,
            pattern: LanguagePattern.english,
            style: AppTextStyles.normal,
            censoredStyle: AppTextStyles.censoredSpaced,
            builder: (context, word, isRevealed) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: isRevealed
                    ? null
                    : const LinearGradient(
                        colors: [Colors.purple, Colors.pink],
                      ),
                borderRadius: .circular(8),
                border: .all(
                  color: isRevealed ? Colors.transparent : Colors.white,
                  width: 2,
                ),
              ),
              child: isRevealed
                  ? null
                  : const Center(
                      child: Icon(Icons.lock, color: Colors.white, size: 14),
                    ),
            ),
          ),
        ),
      ],
    ),
  );
}
