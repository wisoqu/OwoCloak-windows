import '../models/account_info.dart';
import '../models/server_option.dart';

class AppCatalog {
  static const account = AccountInfo(
    email: 'user@owocloak.app',
    subscriptionStatus: 'Активна',
    expirationDate: '30 августа 2026',
    connectedDevices: 3,
    inviteLink: 'https://owocloak.app/invite/ABCD-1234',
  );

  static const servers = <ServerOption>[
    ServerOption(
      name: 'Tokyo-01',
      region: 'Japan',
      pingMs: 24,
      recommended: true,
    ),
    ServerOption(name: 'Warsaw-03', region: 'Poland', pingMs: 31),
    ServerOption(name: 'Frankfurt-02', region: 'Germany', pingMs: 39),
  ];
}
