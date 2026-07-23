import 'package:flutter/material.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text('Placeholder controls for protocol and safety options.'),
            SizedBox(height: 12),
            _SwitchLine(label: 'Auto reconnect', value: true),
            _SwitchLine(label: 'Kill switch', value: true),
            _SwitchLine(label: 'DNS leak protection', value: true),
          ],
        ),
      ),
    );
  }
}

class _SwitchLine extends StatelessWidget {
  final String label;
  final bool value;

  const _SwitchLine({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Switch(value: value, onChanged: null),
        ],
      ),
    );
  }
}
