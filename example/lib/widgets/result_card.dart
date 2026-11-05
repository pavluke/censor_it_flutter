import 'package:material_ui/material_ui.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const .all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: .circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}
