enum AppMode { simple, advanced }

enum AdvancedSection {
  infrastructure,
  selfHosted,
  splitTunneling,
  logs,
  security,
  account,
}

extension AdvancedSectionLabel on AdvancedSection {
  String get label => switch (this) {
        AdvancedSection.infrastructure => 'Серверы',
        AdvancedSection.selfHosted => 'Свой сервер',
        AdvancedSection.splitTunneling => 'Split tunneling',
        AdvancedSection.logs => 'Логи и метрики',
        AdvancedSection.security => 'Безопасность',
        AdvancedSection.account => 'Аккаунт',
      };

  String get description => switch (this) {
        AdvancedSection.infrastructure => 'Наши серверы и протоколы',
        AdvancedSection.selfHosted => 'Собственная инфраструктура',
        AdvancedSection.splitTunneling => 'Маршрутизация по правилам',
        AdvancedSection.logs => 'Локальная диагностика',
        AdvancedSection.security => 'Приватность и защита',
        AdvancedSection.account => 'Подписка и устройства',
      };
}
