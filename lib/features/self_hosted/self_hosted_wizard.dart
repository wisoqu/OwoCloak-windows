import 'package:flutter/material.dart';

class SelfHostedWizard extends StatefulWidget {
  const SelfHostedWizard({super.key});

  @override
  State<SelfHostedWizard> createState() => _SelfHostedWizardState();
}

class _SelfHostedWizardState extends State<SelfHostedWizard> {
  final _addressController = TextEditingController(text: '203.0.113.42:443');
  String _protocol = 'OwONaive';

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _Header(
            title: 'Свой сервер',
            hint: 'self-hosted · контроль инфраструктуры'),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _CardTitle(title: 'Подключение к серверу'),
              const SizedBox(height: 12),
              TextField(
                controller: _addressController,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                decoration: const InputDecoration(
                    labelText: 'Адрес сервера', hintText: 'IP или домен VPS'),
              ),
              const SizedBox(height: 10),
              const TextField(
                obscureText: true,
                style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                decoration: InputDecoration(
                    labelText: 'Ключ клиента',
                    hintText: 'хранится только локально'),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                      child: FilledButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Проверить сервер'))),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.content_paste),
                      label: const Text('Импорт .conf')),
                ],
              ),
            ],
          ),
        ),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _CardTitle(title: 'Протокол'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['OwONaive', 'WireGuard', 'VLESS / Reality']
                    .map((protocol) => ChoiceChip(
                        label: Text(protocol),
                        selected: _protocol == protocol,
                        onSelected: (_) =>
                            setState(() => _protocol = protocol)))
                    .toList(),
              ),
              const SizedBox(height: 12),
              Text('Выбран: $_protocol',
                  style: const TextStyle(
                      color: Color(0xFF8A919C),
                      fontSize: 11,
                      fontFamily: 'monospace')),
            ],
          ),
        ),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _CardTitle(title: 'Безопасность ключей'),
              const SizedBox(height: 8),
              const Text(
                  'Приватный ключ не покидает устройство. Сначала проверьте публичный ключ сервера, затем создайте локальный профиль.',
                  style: TextStyle(
                      color: Color(0xFF8A919C), fontSize: 11.5, height: 1.5)),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                    child: Text('Публичный ключ сервера: a3f9…8bd2',
                        style: const TextStyle(
                            color: Color(0xFF4FD1C5),
                            fontFamily: 'monospace',
                            fontSize: 11))),
                OutlinedButton(onPressed: null, child: const Text('Показать'))
              ]),
            ],
          ),
        ),
      ],
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
