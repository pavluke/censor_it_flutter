import 'package:material_ui/material_ui.dart';

import '../theme/text_styles.dart';

class ExampleLabel extends StatelessWidget {
  const ExampleLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const .only(bottom: 8, left: 4),
    child: Text(
      text,
      style: AppTextStyles.exampleLabel.copyWith(color: Colors.grey[700]),
    ),
  );
}
