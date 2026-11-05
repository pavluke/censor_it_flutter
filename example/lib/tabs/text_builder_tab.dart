import 'package:censor_it_flutter/censor_it_flutter.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/text_styles.dart';
import '../widgets/info_card.dart';
import '../widgets/result_card.dart';

class TextBuilderTab extends StatelessWidget {
  const TextBuilderTab({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const .all(24),
    child: Column(
      spacing: 16,
      crossAxisAlignment: .start,
      children: [
        const InfoCard(
          icon: Icons.text_fields,
          title: 'Text Builder Mode',
          description: 'Replace profanity with custom text',
          color: Colors.blue,
        ),
        ResultCard(
          child: CensorItWidget.textBuilder(
            text,
            builder: (context, word) => '[censored]',
            pattern: LanguagePattern.english,
            style: AppTextStyles.normal,
            censoredStyle: AppTextStyles.censoredRed,
          ),
        ),
        ResultCard(
          child: CensorItWidget.textBuilder(
            text,
            builder: (context, word) => '*' * word.length,
            pattern: LanguagePattern.english,
            style: AppTextStyles.normal,
            censoredStyle: AppTextStyles.censoredOrange,
          ),
        ),
      ],
    ),
  );
}
