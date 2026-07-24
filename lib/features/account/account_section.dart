import 'package:flutter/material.dart';

import '../../core/catalog/app_catalog.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final account = AppCatalog.account;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _Header(title: 'Аккаунт', hint: 'локальные данные профиля'),
        _Panel(
          child: Column(
            children: [
              _Row(label: 'Email', value: account.email),
              _Row(
                  label: 'Статус',
                  value: account.subscriptionStatus,
                  accent: const Color(0xFF4FD1C5)),
              _Row(label: 'Подписка до', value: account.expirationDate),
              _Row(
                  label: 'Устройства',
                  value: '${account.connectedDevices} подключено'),
              _Row(label: 'Инвайт', value: account.inviteLink),
            ],
          ),
        ),
        _Panel(
          child: Row(
            children: [
              const Icon(Icons.info_outline,
                  color: Color(0xFF8A919C), size: 18),
              const SizedBox(width: 10),
              const Expanded(
                  child: Text(
                      'Синхронизация аккаунта появится после подключения API.',
                      style:
                          TextStyle(color: Color(0xFF8A919C), fontSize: 12))),
              OutlinedButton(onPressed: null, child: const Text('Войти')),
            ],
          ),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final Color? accent;

  const _Row({required this.label, required this.value, this.accent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          SizedBox(
              width: 110,
              child: Text(label,
                  style:
                      const TextStyle(color: Color(0xFF8A919C), fontSize: 12))),
          Expanded(
              child: Text(value,
                  style: TextStyle(
                      color: accent,
                      fontSize: 12,
                      fontFamily: accent == null ? null : 'monospace'))),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String hint;

  const _Header({required this.title, required this.hint});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Row(
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Spacer(),
            Text(hint,
                style: const TextStyle(
                    color: Color(0xFF565D68),
                    fontSize: 11,
                    fontFamily: 'monospace')),
          ],
        ),
      );
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
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      );
}
