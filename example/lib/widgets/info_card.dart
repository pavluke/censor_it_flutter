import 'package:material_ui/material_ui.dart';

import '../theme/text_styles.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const .all(16),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: .circular(12),
      border: .all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      spacing: 16,
      children: [
        Container(
          padding: const .all(12),
          decoration: BoxDecoration(color: color, borderRadius: .circular(8)),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        Expanded(
          child: Column(
            spacing: 4,
            crossAxisAlignment: .start,
            children: [
              Text(
                title,
                style: AppTextStyles.infoCardTitle.copyWith(color: color),
              ),
              Text(
                description,
                style: AppTextStyles.infoCardDescription.copyWith(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
