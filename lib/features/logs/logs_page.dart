import 'package:flutter/material.dart';

import '../../app/owocloak_app.dart';
import '../../core/models/log_entry.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('Логи и метрики',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Spacer(),
            const Text('локально · без телеметрии',
                style: TextStyle(
                    color: Color(0xFF565D68),
                    fontSize: 11,
                    fontFamily: 'monospace')),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            _Metric(
                label: 'Пинг',
                value: controller.tunnel.pingMs == null
                    ? '—'
                    : '${controller.tunnel.pingMs} ms',
                accent: const Color(0xFF4FD1C5)),
            _Metric(
                label: 'Состояние',
                value: controller.tunnel.state.name,
                accent: const Color(0xFFE8A33D)),
            _Metric(
                label: 'События',
                value: '${controller.logs.length}',
                accent: Colors.white),
          ],
        ),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(children: [
                const _CardTitle(title: 'Консоль'),
                const Spacer(),
                TextButton(
                    onPressed: controller.clearLogs,
                    child: const Text('Очистить'))
              ]),
              const SizedBox(height: 8),
              Container(
                height: 300,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: const Color(0xFF0A0C0F),
                    border: Border.all(color: const Color(0xFF262B33)),
                    borderRadius: BorderRadius.circular(8)),
                child: controller.logs.isEmpty
                    ? const Text('Нет событий',
                        style: TextStyle(
                            color: Color(0xFF565D68),
                            fontFamily: 'monospace',
                            fontSize: 11))
                    : ListView.builder(
                        itemCount: controller.logs.length,
                        itemBuilder: (context, index) =>
                            _LogLine(entry: controller.logs[index])),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  final Color accent;

  const _Metric(
      {required this.label, required this.value, required this.accent});

  @override
  Widget build(BuildContext context) => Expanded(
      child: Container(
          margin: const EdgeInsets.only(right: 10, bottom: 14),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: const Color(0xFF15181D),
              border: Border.all(color: const Color(0xFF262B33)),
              borderRadius: BorderRadius.circular(8)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label.toUpperCase(),
                style: const TextStyle(
                    color: Color(0xFF565D68), fontSize: 10, letterSpacing: .5)),
            const SizedBox(height: 4),
            Text(value,
                style: TextStyle(
                    color: accent,
                    fontFamily: 'monospace',
                    fontSize: 17,
                    fontWeight: FontWeight.w600))
          ])));
}

class _LogLine extends StatelessWidget {
  final LogEntry entry;

  const _LogLine({required this.entry});

  @override
  Widget build(BuildContext context) {
    final level = switch (entry.level) {
      LogLevel.info => 'info',
      LogLevel.warning => 'warn',
      LogLevel.success => 'ok',
      LogLevel.error => 'error'
    };
    final color = switch (entry.level) {
      LogLevel.info => const Color(0xFF4FD1C5),
      LogLevel.warning => const Color(0xFFE8A33D),
      LogLevel.success => const Color(0xFF6FCF7B),
      LogLevel.error => const Color(0xFFE8615A)
    };
    final time =
        '${entry.timestamp.hour.toString().padLeft(2, '0')}:${entry.timestamp.minute.toString().padLeft(2, '0')}:${entry.timestamp.second.toString().padLeft(2, '0')}';
    return Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: '$time  ',
                  style: const TextStyle(color: Color(0xFF565D68))),
              TextSpan(text: '[$level] ', style: TextStyle(color: color)),
              TextSpan(
                  text: entry.message,
                  style: const TextStyle(color: Color(0xFF8A919C)))
            ]),
            style: const TextStyle(fontFamily: 'monospace', fontSize: 11)));
  }
}

class _CardTitle extends StatelessWidget {
  final String title;

  const _CardTitle({required this.title});

  @override
  Widget build(BuildContext context) => Row(children: [
        Container(width: 3, height: 12, color: const Color(0xFFE8A33D)),
        const SizedBox(width: 7),
        Text(title.toUpperCase(),
            style: const TextStyle(
                color: Color(0xFF8A919C),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: .7))
      ]);
}

class _Panel extends StatelessWidget {
  final Widget child;

  const _Panel({required this.child});

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(top: 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xFF15181D),
          border: Border.all(color: const Color(0xFF262B33)),
          borderRadius: BorderRadius.circular(10)),
      child: child);
}
