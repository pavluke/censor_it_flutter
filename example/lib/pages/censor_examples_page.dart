import 'package:material_ui/material_ui.dart';

import '../tabs/overlay_builder_tab.dart';
import '../tabs/text_builder_tab.dart';
import '../tabs/widget_builder_tab.dart';
import '../theme/text_styles.dart';
import '../widgets/input_section.dart';

class CensorExamplesPage extends StatefulWidget {
  const CensorExamplesPage({super.key});

  @override
  State<CensorExamplesPage> createState() => _CensorExamplesPageState();
}

class _CensorExamplesPageState extends State<CensorExamplesPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final TextEditingController _textController;

  var _currentText =
      'This is a fucking example with some shit words '
      'and bitch ass profanity to test the censor';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _textController = TextEditingController(text: _currentText);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: const Text(
        'Flutter CensorIt Demo',
        style: AppTextStyles.appBarTitle,
      ),
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      elevation: 0,
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        tabs: const [
          Tab(text: 'Text Builder'),
          Tab(text: 'Widget Builder'),
          Tab(text: 'Overlay Builder'),
        ],
      ),
    ),
    body: Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              TextBuilderTab(text: _currentText),
              WidgetBuilderTab(text: _currentText),
              OverlayBuilderTab(text: _currentText),
            ],
          ),
        ),
        InputSection(
          textController: _textController,
          onSend: () => setState(() => _currentText = _textController.text),
        ),
      ],
    ),
  );
}
