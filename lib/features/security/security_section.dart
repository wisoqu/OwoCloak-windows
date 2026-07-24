import 'package:flutter/material.dart';

import '../../app/owocloak_app.dart';
import '../../core/models/security_option.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _Header(
            title: 'Безопасность', hint: 'приватность и защита соединения'),
        _Panel(
          child: Column(
            children: [
              _ToggleRow(
                  title: 'Автопереподключение',
                  description: 'Восстанавливать туннель после краткого обрыва',
                  value: controller.autoReconnect,
                  onChanged: (v) => controller.setSecurityOption(
                      SecurityOption.autoReconnect, v)),
              _ToggleRow(
                  title: 'Kill switch',
                  description: 'Блокировать трафик при потере туннеля',
                  value: controller.killSwitch,
                  onChanged: (v) => controller.setSecurityOption(
                      SecurityOption.killSwitch, v)),
              _ToggleRow(
                  title: 'Защита DNS',
                  description: 'Отправлять DNS-запросы через выбранный туннель',
                  value: controller.dnsProtection,
                  onChanged: (v) => controller.setSecurityOption(
                      SecurityOption.dnsProtection, v)),
            ],
          ),
        ),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _CardTitle(title: 'Данные и телеметрия'),
              const SizedBox(height: 6),
              _ToggleRow(
                  title: 'Анонимная телеметрия',
                  description:
                      'Только агрегированные метрики скорости, без аккаунта',
                  value: controller.anonymousTelemetry,
                  onChanged: (v) => controller.setSecurityOption(
                      SecurityOption.anonymousTelemetry, v)),
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                    'Логи хранятся локально и не отправляются на серверы OwOCloak.',
                    style: TextStyle(color: Color(0xFF565D68), fontSize: 11)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow(
      {required this.title,
      required this.description,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(title, style: const TextStyle(fontSize: 12.5)),
                  const SizedBox(height: 3),
                  Text(description,
                      style: const TextStyle(
                          color: Color(0xFF565D68), fontSize: 10.5))
                ])),
            Switch(value: value, onChanged: onChanged),
          ],
        ),
      );
}

class _Header extends StatelessWidget {
  final String title;
  final String hint;

  const _Header({required this.title, required this.hint});

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const Spacer(),
        Text(hint,
            style: const TextStyle(
                color: Color(0xFF565D68),
                fontSize: 11,
                fontFamily: 'monospace'))
      ]));
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
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xFF15181D),
          border: Border.all(color: const Color(0xFF262B33)),
          borderRadius: BorderRadius.circular(10)),
      child: child);
}
