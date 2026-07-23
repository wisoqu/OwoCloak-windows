import 'package:flutter/material.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Logs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text('Connection events and diagnostics will appear here.'),
            SizedBox(height: 10),
            _LogLine(level: 'INFO', text: 'App started'),
            _LogLine(level: 'INFO', text: 'Mock data loaded'),
            _LogLine(level: 'WARN', text: 'Backend not connected yet'),
          ],
        ),
      ),
    );
  }
}

class _LogLine extends StatelessWidget {
  final String level;
  final String text;

  const _LogLine({
    required this.level,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 56,
            child: Text(
              level,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
