import 'package:flutter/material.dart';

class SelfHostedWizard extends StatelessWidget {
  const SelfHostedWizard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Self-hosted wizard',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text('Wizard placeholder for provisioning flow.'),
            SizedBox(height: 12),
            _StepRow(number: '1', text: 'Choose deployment type'),
            _StepRow(number: '2', text: 'Confirm server parameters'),
            _StepRow(number: '3', text: 'Generate connection profile'),
          ],
        ),
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final String number;
  final String text;

  const _StepRow({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CircleAvatar(radius: 11, child: Text(number)),
          SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
