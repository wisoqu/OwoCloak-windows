import 'package:flutter/material.dart';

class SelfHostedWizard extends StatelessWidget {
  const SelfHostedWizard({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Self-hosted setup',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              'Start server setup from here. This is UI-only for now, but the flow is ready for the core service later.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start setup'),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.description_outlined),
                  label: const Text('Paste config'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _ProtocolChip(label: 'AmneziaWG'),
                _ProtocolChip(label: 'XRay / VLESS'),
                _ProtocolChip(label: 'WireGuard'),
                _ProtocolChip(label: 'Hysteria2'),
                _ProtocolChip(label: 'Custom'),
              ],
            ),
            const SizedBox(height: 18),
            _FlowCard(
              number: '1',
              title: 'Connect to server',
              subtitle: 'Enter IP, SSH user, and password or key.',
              accent: scheme.primary,
            ),
            _FlowCard(
              number: '2',
              title: 'Choose install mode',
              subtitle: 'Automatic for quick start or manual for a single protocol.',
              accent: scheme.secondary,
            ),
            _FlowCard(
              number: '3',
              title: 'Install protocol and generate profile',
              subtitle: 'Create the connection and show it in the main screen.',
              accent: scheme.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}

class _FlowCard extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final Color accent;

  const _FlowCard({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: accent.withValues(alpha: 0.28)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 13,
                backgroundColor: accent.withValues(alpha: 0.18),
                child: Text(number),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProtocolChip extends StatelessWidget {
  final String label;

  const _ProtocolChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label));
  }
}
