import 'package:flutter/material.dart';

import '../../app/owocloak_app.dart';
import '../../core/catalog/app_catalog.dart';
import '../../core/models/connection_strategy.dart';
import '../../core/models/tunnel_status.dart';

class SimpleModePage extends StatelessWidget {
  const SimpleModePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    final tunnel = controller.tunnel;
    final connected = tunnel.state == TunnelState.connected;
    final connecting = tunnel.state == TunnelState.connecting;
    final label = switch (tunnel.state) {
      TunnelState.connected => 'Подключено',
      TunnelState.connecting => 'Подключение…',
      TunnelState.disconnecting => 'Отключение…',
      TunnelState.error => 'Ошибка',
      TunnelState.disconnected => 'Отключено',
    };

    return LayoutBuilder(
      builder: (context, constraints) => Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 520,
              minHeight: constraints.maxHeight - 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ConnectRing(
                  connected: connected,
                  connecting: connecting,
                  label: label,
                  onTap: controller.isBusy ? null : controller.toggleConnection,
                ),
                const SizedBox(height: 22),
                Text(
                  tunnel.server?.name ?? controller.selectedServer.name,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  '${tunnel.server?.region ?? controller.selectedServer.region} · '
                  '${tunnel.pingMs ?? controller.selectedServer.pingMs} ms · '
                  '${controller.strategy.label}',
                  style: const TextStyle(
                    color: Color(0xFF565D68),
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 24),
                _ServerPicker(),
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 6,
                  runSpacing: 6,
                  children: ConnectionStrategy.values
                      .map(
                        (value) => ChoiceChip(
                          label: Text(value.label),
                          selected: controller.strategy == value,
                          onSelected: (_) => controller.setStrategy(value),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Текущий экран использует demo backend. Реальный туннель подключается через ConnectionEngine.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF565D68), fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConnectRing extends StatelessWidget {
  final bool connected;
  final bool connecting;
  final String label;
  final VoidCallback? onTap;

  const _ConnectRing({
    required this.connected,
    required this.connecting,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent =
        connecting ? const Color(0xFFE8A33D) : const Color(0xFF4FD1C5);
    return SizedBox(
      width: 176,
      height: 176,
      child: CustomPaint(
        painter: _RingPainter(active: connected, color: accent),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Material(
            color: const Color(0xFF101318),
            shape: const CircleBorder(
              side: BorderSide(color: Color(0xFF262B33)),
            ),
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    connected ? Icons.power : Icons.power_settings_new,
                    size: 30,
                    color: connected || connecting
                        ? accent
                        : const Color(0xFF565D68),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    label,
                    style: TextStyle(
                      color: connected ? Colors.white : accent,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final bool active;
  final Color color;

  const _RingPainter({required this.active, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 2;
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = const Color(0xFF262B33);
    canvas.drawCircle(center, radius, track);
    if (active) {
      final fill = Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 3
        ..color = color;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -1.5708,
        6.2832,
        false,
        fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.active != active || oldDelegate.color != color;
}

class _ServerPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF15181D),
        border: Border.all(color: const Color(0xFF262B33)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 3,
          children: AppCatalog.servers.map((server) {
            final selected = server.name == controller.selectedServer.name;
            return TextButton(
              onPressed: controller.isBusy || controller.isConnected
                  ? null
                  : () => controller.selectServer(server),
              style: TextButton.styleFrom(
                backgroundColor: selected ? const Color(0xFF1B1F26) : null,
                foregroundColor:
                    selected ? Colors.white : const Color(0xFF8A919C),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Text('${server.name}  ${server.pingMs}ms'),
            );
          }).toList(),
        ),
      ),
    );
  }
}
