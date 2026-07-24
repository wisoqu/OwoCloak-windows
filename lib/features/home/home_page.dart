import 'package:flutter/material.dart';
import '../account/account_section.dart';
import '../advanced/advanced_mode_page.dart';
import '../simple/simple_mode_page.dart';

enum AppMode { simple, advanced }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppMode _mode = AppMode.simple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopBar(
                mode: _mode,
                onModeChanged: (mode) => setState(() => _mode = mode),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: _mode == AppMode.simple
                      ? const SimpleModePage(key: ValueKey('simple'))
                      : const AdvancedModePage(key: ValueKey('advanced')),
                ),
              ),
              const SizedBox(height: 16),
              const AccountSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final AppMode mode;
  final ValueChanged<AppMode> onModeChanged;

  const _TopBar({
    required this.mode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'OwOCloak',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        SegmentedButton<AppMode>(
          segments: const [
            ButtonSegment(
              value: AppMode.simple,
              label: Text('Простой'),
            ),
            ButtonSegment(
              value: AppMode.advanced,
              label: Text('Продвинутый'),
            ),
          ],
          selected: {mode},
          onSelectionChanged: (values) => onModeChanged(values.first),
        ),
      ],
    );
  }
}
