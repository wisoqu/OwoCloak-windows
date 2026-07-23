import 'package:flutter/material.dart';
import '../logs/logs_page.dart';
import '../security/security_section.dart';
import '../self_hosted/self_hosted_wizard.dart';

class AdvancedModePage extends StatelessWidget {
  const AdvancedModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _ChoiceCards(),
          SizedBox(height: 16),
          SelfHostedWizard(),
          SizedBox(height: 16),
          SecuritySection(),
          SizedBox(height: 16),
          LogsPage(),
        ],
      ),
    );
  }
}

class _ChoiceCards extends StatelessWidget {
  const _ChoiceCards();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _ModeCard(
            title: 'Self-hosted',
            subtitle: 'Short setup wizard for your own server',
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _ModeCard(
            title: 'Our infrastructure',
            subtitle: 'Pick a team server and tune it manually',
          ),
        ),
      ],
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ModeCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(subtitle),
            const SizedBox(height: 14),
            const FilledButton(
              onPressed: null,
              child: Text('Open'),
            ),
          ],
        ),
      ),
    );
  }
}
