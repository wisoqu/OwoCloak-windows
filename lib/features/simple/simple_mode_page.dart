import 'package:flutter/material.dart';
import '../../core/mock/mock_data.dart';
import '../../core/models/connection_strategy.dart';

class SimpleModePage extends StatefulWidget {
  const SimpleModePage({super.key});

  @override
  State<SimpleModePage> createState() => _SimpleModePageState();
}

class _SimpleModePageState extends State<SimpleModePage> {
  bool _connected = false;
  ConnectionStrategy _strategy = ConnectionStrategy.auto;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Simple mode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'One button for casual users. No protocol jargon.',
            ),
            const Spacer(),
            Center(
              child: FilledButton.tonalIcon(
                onPressed: () => setState(() => _connected = !_connected),
                icon: Icon(_connected ? Icons.link_off : Icons.lock_open),
                label: Text(_connected ? 'Отключиться' : 'Подключиться'),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: MockData.strategies
                  .map(
                    (strategy) => ChoiceChip(
                      label: Text(strategy.label),
                      selected: _strategy == strategy,
                      onSelected: (_) {
                        setState(() => _strategy = strategy);
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                _strategy.description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
