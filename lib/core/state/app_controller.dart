import 'dart:async';

import 'package:flutter/foundation.dart';

import '../catalog/app_catalog.dart';
import '../models/app_mode.dart';
import '../models/connection_strategy.dart';
import '../models/log_entry.dart';
import '../models/server_option.dart';
import '../models/security_option.dart';
import '../models/tunnel_status.dart';
import '../services/connection_engine.dart';

class AppController extends ChangeNotifier {
  final ConnectionEngine engine;
  StreamSubscription<TunnelSnapshot>? _subscription;

  AppMode mode = AppMode.simple;
  AdvancedSection advancedSection = AdvancedSection.infrastructure;
  ConnectionStrategy strategy = ConnectionStrategy.auto;
  ServerOption selectedServer = AppCatalog.servers.first;

  bool autoReconnect = true;
  bool killSwitch = true;
  bool dnsProtection = true;
  bool anonymousTelemetry = false;

  TunnelSnapshot tunnel = const TunnelSnapshot.disconnected();
  final List<LogEntry> logs = <LogEntry>[];

  AppController({ConnectionEngine? engine})
      : engine = engine ?? DemoConnectionEngine() {
    _subscription = this.engine.snapshots.listen(_onSnapshot);
    _addLog(LogLevel.info, 'Клиент запущен; backend туннеля не подключён');
  }

  bool get isConnected => tunnel.state == TunnelState.connected;
  bool get isBusy => tunnel.isBusy;

  void setMode(AppMode value) {
    if (mode == value) return;
    mode = value;
    notifyListeners();
  }

  void setAdvancedSection(AdvancedSection value) {
    advancedSection = value;
    notifyListeners();
  }

  void setStrategy(ConnectionStrategy value) {
    strategy = value;
    _addLog(LogLevel.info, 'Стратегия: ${value.label}');
    notifyListeners();
  }

  void selectServer(ServerOption value) {
    if (selectedServer.name == value.name) return;
    if (isConnected) return;
    selectedServer = value;
    _addLog(LogLevel.info, 'Выбран сервер ${value.name}');
    notifyListeners();
  }

  Future<void> toggleConnection() async {
    if (isBusy) return;
    if (isConnected) {
      _addLog(
          LogLevel.info, 'Отключение от ${tunnel.server?.name ?? 'сервера'}');
      await engine.disconnect();
      return;
    }

    _addLog(LogLevel.info, 'Подключение к ${selectedServer.name}');
    await engine.connect(server: selectedServer, strategy: strategy);
  }

  void setSecurityOption(SecurityOption option, bool value) {
    switch (option) {
      case SecurityOption.autoReconnect:
        autoReconnect = value;
      case SecurityOption.killSwitch:
        killSwitch = value;
      case SecurityOption.dnsProtection:
        dnsProtection = value;
      case SecurityOption.anonymousTelemetry:
        anonymousTelemetry = value;
    }
    notifyListeners();
  }

  void clearLogs() {
    logs.clear();
    notifyListeners();
  }

  void _onSnapshot(TunnelSnapshot next) {
    tunnel = next;
    switch (next.state) {
      case TunnelState.connecting:
        _addLog(LogLevel.info, 'Установка защищённого соединения…');
      case TunnelState.connected:
        _addLog(LogLevel.success,
            'Соединение установлено, RTT ${next.pingMs ?? '—'} ms');
      case TunnelState.disconnecting:
        _addLog(LogLevel.info, 'Завершение туннеля');
      case TunnelState.disconnected:
        _addLog(LogLevel.info, 'Туннель отключён');
      case TunnelState.error:
        _addLog(LogLevel.error, next.errorMessage ?? 'Ошибка туннеля');
    }
    notifyListeners();
  }

  void _addLog(LogLevel level, String message) {
    logs.insert(
        0, LogEntry(timestamp: DateTime.now(), level: level, message: message));
    if (logs.length > 100) logs.removeLast();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    engine.dispose();
    super.dispose();
  }
}
