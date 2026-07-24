import 'package:flutter/material.dart';

import '../../app/owocloak_app.dart';
import '../../core/models/app_mode.dart';
import '../../core/models/connection_strategy.dart';
import '../../core/models/tunnel_status.dart';
import '../advanced/advanced_mode_page.dart';
import '../simple/simple_mode_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    final connected = controller.tunnel.state == TunnelState.connected;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TitleBar(connected: connected),
            _ModeRow(mode: controller.mode),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: controller.mode == AppMode.simple
                    ? const SimpleModePage(key: ValueKey('simple'))
                    : const AdvancedModePage(key: ValueKey('advanced')),
              ),
            ),
            const _StatusBar(),
          ],
        ),
      ),
    );
  }
}

class _TitleBar extends StatelessWidget {
  final bool connected;

  const _TitleBar({required this.connected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF262B33))),
      ),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              gradient: LinearGradient(
                colors: [Color(0xFF4FD1C5), Color(0xFF2E5C57)],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'OwOCloak',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: const Color(0xFF8A919C),
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Spacer(),
          _StatusPill(connected: connected),
        ],
      ),
    );
  }
}

class _ModeRow extends StatelessWidget {
  final AppMode mode;

  const _ModeRow({required this.mode});

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF262B33))),
      ),
      child: Row(
        children: [
          SegmentedButton<AppMode>(
            showSelectedIcon: false,
            style: ButtonStyle(
              textStyle: WidgetStatePropertyAll(
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              ),
            ),
            segments: const [
              ButtonSegment(value: AppMode.simple, label: Text('Простой')),
              ButtonSegment(
                  value: AppMode.advanced, label: Text('Продвинутый')),
            ],
            selected: {mode},
            onSelectionChanged: (selection) =>
                controller.setMode(selection.first),
          ),
          const Spacer(),
          Text(
            mode == AppMode.simple
                ? 'одна кнопка — один туннель'
                : 'расширенная конфигурация',
            style: const TextStyle(
              color: Color(0xFF565D68),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final bool connected;

  const _StatusPill({required this.connected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                connected ? const Color(0xFF4FD1C5) : const Color(0xFF565D68),
            boxShadow: connected
                ? const [BoxShadow(color: Color(0xFF4FD1C5), blurRadius: 6)]
                : null,
          ),
        ),
        const SizedBox(width: 7),
        Text(
          connected ? 'ПОДКЛЮЧЕНО' : 'ОТКЛЮЧЕНО',
          style: const TextStyle(
            color: Color(0xFF8A919C),
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    final server = controller.tunnel.server ?? controller.selectedServer;
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF262B33))),
      ),
      child: Row(
        children: [
          const Text('v0.1.0-dev', style: _MonoMuted()),
          const SizedBox(width: 14),
          Text('протокол: ${controller.strategy.label}',
              style: const _MonoMuted()),
          const Spacer(),
          Text('сервер: ${server.name}', style: const _MonoMuted()),
          const SizedBox(width: 14),
          Text(
            controller.tunnel.pingMs == null
                ? 'сборка проверена ✓'
                : 'RTT ${controller.tunnel.pingMs} ms',
            style: const _MonoMuted(),
          ),
        ],
      ),
    );
  }
}

class _MonoMuted extends TextStyle {
  const _MonoMuted()
      : super(
          color: const Color(0xFF565D68),
          fontSize: 10.5,
          fontFamily: 'monospace',
        );
}
