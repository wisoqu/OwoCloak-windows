import '../models/account_info.dart';
import '../models/connection_strategy.dart';
import '../models/server_option.dart';

class MockData {
  static const account = AccountInfo(
    email: 'user@owocloak.app',
    subscriptionStatus: 'Active',
    expirationDate: '2026-08-30',
    connectedDevices: 3,
    inviteLink: 'https://owocloak.app/invite/ABCD-1234',
  );

  static const strategies = <ConnectionStrategy>[
    ConnectionStrategy.auto,
    ConnectionStrategy.games,
    ConnectionStrategy.video,
    ConnectionStrategy.stream,
  ];

  static const servers = <ServerOption>[
    ServerOption(
      name: 'Tokyo-01',
      region: 'Japan',
      pingMs: 24,
      recommended: true,
    ),
    ServerOption(
      name: 'Warsaw-03',
      region: 'Poland',
      pingMs: 31,
    ),
    ServerOption(
      name: 'Frankfurt-02',
      region: 'Germany',
      pingMs: 39,
    ),
  ];
}
