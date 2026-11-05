import 'package:material_ui/material_ui.dart';

class InputSection extends StatelessWidget {
  const InputSection({
    required this.textController,
    required this.onSend,
    super.key,
  });

  final TextEditingController textController;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 10,
          offset: const Offset(0, -2),
        ),
      ],
    ),
    child: SafeArea(
      child: Padding(
        padding: const .all(16),
        child: Row(
          spacing: 12,
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Enter text to check...',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: .circular(12),
                    borderSide: .none,
                  ),
                  contentPadding: const .symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.deepPurple,
              borderRadius: .circular(12),
              child: InkWell(
                onTap: onSend,
                borderRadius: .circular(12),
                child: const Padding(
                  padding: .all(14),
                  child: Icon(Icons.send, color: Colors.white, size: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
