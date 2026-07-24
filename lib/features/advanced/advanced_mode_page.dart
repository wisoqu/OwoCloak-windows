import 'package:flutter/material.dart';

import '../../app/owocloak_app.dart';
import '../../core/catalog/app_catalog.dart';
import '../../core/models/app_mode.dart';
import '../../core/models/server_option.dart';
import '../../core/models/tunnel_status.dart';
import '../account/account_section.dart';
import '../logs/logs_page.dart';
import '../security/security_section.dart';
import '../self_hosted/self_hosted_wizard.dart';

class AdvancedModePage extends StatelessWidget {
  const AdvancedModePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _AdvancedRail(section: controller.advancedSection),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(26, 22, 26, 40),
            child: _sectionContent(context, controller.advancedSection),
          ),
        ),
      ],
    );
  }

  Widget _sectionContent(BuildContext context, AdvancedSection section) {
    return switch (section) {
      AdvancedSection.infrastructure => const _InfrastructureSection(),
      AdvancedSection.selfHosted => const SelfHostedWizard(),
      AdvancedSection.splitTunneling => const _SplitTunnelingSection(),
      AdvancedSection.logs => const LogsPage(),
      AdvancedSection.security => const SecuritySection(),
      AdvancedSection.account => const AccountSection(),
    };
  }
}

class _AdvancedRail extends StatelessWidget {
  final AdvancedSection section;

  const _AdvancedRail({required this.section});

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    return Container(
      width: 190,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Color(0xFF262B33))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 10, 6),
            child: Text(
              'РАЗДЕЛЫ',
              style: TextStyle(
                color: Color(0xFF565D68),
                fontSize: 10,
                letterSpacing: 1.1,
              ),
            ),
          ),
          ...AdvancedSection.values.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: _RailButton(
                section: item,
                selected: item == section,
                onTap: () => controller.setAdvancedSection(item),
              ),
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Расширенный режим\nдля ручной настройки',
              style: TextStyle(
                  color: Color(0xFF565D68), fontSize: 10.5, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _RailButton extends StatelessWidget {
  final AdvancedSection section;
  final bool selected;
  final VoidCallback onTap;

  const _RailButton({
    required this.section,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icon = switch (section) {
      AdvancedSection.infrastructure => Icons.dns_outlined,
      AdvancedSection.selfHosted => Icons.settings_remote_outlined,
      AdvancedSection.splitTunneling => Icons.call_split_outlined,
      AdvancedSection.logs => Icons.terminal_outlined,
      AdvancedSection.security => Icons.shield_outlined,
      AdvancedSection.account => Icons.person_outline,
    };
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        foregroundColor:
            selected ? const Color(0xFFE8A33D) : const Color(0xFF8A919C),
        backgroundColor: selected ? const Color(0xFF5C4620) : null,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 15),
          const SizedBox(width: 9),
          Expanded(child: Text(section.label, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}

class _InfrastructureSection extends StatelessWidget {
  const _InfrastructureSection();

  @override
  Widget build(BuildContext context) {
    final controller = AppControllerScope.of(context);
    final connected = controller.tunnel.state == TunnelState.connected;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionHeader(
          title: 'Наши серверы',
          hint: 'выберите точку выхода и протокол',
        ),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _CardTitle(title: 'Инфраструктура'),
              const SizedBox(height: 2),
              const Text(
                'Серверы OwOCloak с автоматическим подбором маршрута.',
                style: TextStyle(color: Color(0xFF8A919C), fontSize: 12),
              ),
              const SizedBox(height: 12),
              ...AppCatalog.servers.map(
                (server) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _ServerTile(
                    server: server,
                    selected: server.name == controller.selectedServer.name,
                    disabled: connected || controller.isBusy,
                    onSelect: () => controller.selectServer(server),
                  ),
                ),
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
                children: const [
                  _ProtocolCard(
                      name: 'OwONaive',
                      description: 'HTTP/2 CONNECT',
                      selected: true),
                  _ProtocolCard(
                      name: 'WireGuard', description: 'быстрый UDP-туннель'),
                  _ProtocolCard(name: 'VLESS', description: 'Reality / TCP'),
                ],
              ),
              const SizedBox(height: 14),
              FilledButton.icon(
                onPressed:
                    controller.isBusy ? null : controller.toggleConnection,
                icon: Icon(connected ? Icons.link_off : Icons.link),
                label: Text(connected ? 'Отключиться' : 'Подключиться'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ServerTile extends StatelessWidget {
  final ServerOption server;
  final bool selected;
  final bool disabled;
  final VoidCallback onSelect;

  const _ServerTile({
    required this.server,
    required this.selected,
    required this.disabled,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onSelect,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1E2A2A) : const Color(0xFF1B1F26),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? const Color(0xFF4FD1C5) : const Color(0xFF262B33),
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              size: 18,
              color:
                  selected ? const Color(0xFF4FD1C5) : const Color(0xFF565D68),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(server.name,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      if (server.recommended) ...[
                        const SizedBox(width: 8),
                        const _Badge(label: 'рекомендуется'),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${server.region} · ${server.pingMs} ms',
                    style:
                        const TextStyle(color: Color(0xFF565D68), fontSize: 11),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.chevron_right,
                  color: Color(0xFF4FD1C5), size: 18),
          ],
        ),
      ),
    );
  }
}

class _SplitTunnelingSection extends StatelessWidget {
  const _SplitTunnelingSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionHeader(
            title: 'Split tunneling',
            hint: 'маршрутизация по приложению и домену'),
        _Panel(
          child: Column(
            children: [
              _SettingRow(
                title: 'Российские сайты',
                description: 'Готовый набор доменов для прямого подключения',
                value: true,
              ),
              _SettingRow(
                title: 'Банки и госуслуги',
                description: 'Прямое подключение без прокси',
                value: true,
              ),
            ],
          ),
        ),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _CardTitle(title: 'Правила по умолчанию'),
              SizedBox(height: 8),
              _RuleRow(
                  app: 'Steam / игры',
                  action: 'В обход',
                  accent: Color(0xFF4FD1C5)),
              _RuleRow(
                  app: 'Браузер',
                  action: 'Через VPN',
                  accent: Color(0xFFE8A33D)),
              _RuleRow(
                  app: 'Telegram',
                  action: 'Через VPN',
                  accent: Color(0xFFE8A33D)),
              SizedBox(height: 8),
              OutlinedButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.add),
                  label: Text('Добавить правило')),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String title;
  final String description;
  final bool value;

  const _SettingRow(
      {required this.title, required this.description, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                        color: Color(0xFF565D68), fontSize: 10.5)),
              ],
            ),
          ),
          Switch(value: value, onChanged: null),
        ],
      ),
    );
  }
}

class _RuleRow extends StatelessWidget {
  final String app;
  final String action;
  final Color accent;

  const _RuleRow(
      {required this.app, required this.action, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFF1E222A)))),
      child: Row(
        children: [
          Expanded(child: Text(app, style: const TextStyle(fontSize: 12))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
                color: accent.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(10)),
            child: Text(action,
                style: TextStyle(
                    color: accent, fontSize: 10, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String hint;

  const _SectionHeader({required this.title, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
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
}

class _Panel extends StatelessWidget {
  final Widget child;

  const _Panel({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
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
}

class _CardTitle extends StatelessWidget {
  final String title;

  const _CardTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 3,
            height: 12,
            decoration: BoxDecoration(
                color: const Color(0xFFE8A33D),
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 7),
        Text(title.toUpperCase(),
            style: const TextStyle(
                color: Color(0xFF8A919C),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: .7)),
      ],
    );
  }
}

class _ProtocolCard extends StatelessWidget {
  final String name;
  final String description;
  final bool selected;

  const _ProtocolCard(
      {required this.name, required this.description, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: selected ? const Color(0x19E8A33D) : const Color(0xFF1B1F26),
        border: Border.all(
            color:
                selected ? const Color(0xFFE8A33D) : const Color(0xFF262B33)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: TextStyle(
                  color: selected ? const Color(0xFFE8A33D) : Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          Text(description,
              style: const TextStyle(color: Color(0xFF565D68), fontSize: 10.5)),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;

  const _Badge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: const Color(0xFF5C4620),
          borderRadius: BorderRadius.circular(4)),
      child: Text(label,
          style: const TextStyle(color: Color(0xFFE8A33D), fontSize: 9)),
    );
  }
}
