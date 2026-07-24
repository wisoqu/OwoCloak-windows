import 'dart:async';

import '../models/connection_strategy.dart';
import '../models/server_option.dart';
import '../models/tunnel_status.dart';

/// Boundary between the Flutter UI and the real Windows tunnel backend.
abstract interface class ConnectionEngine {
  Stream<TunnelSnapshot> get snapshots;

  Future<void> connect({
    required ServerOption server,
    required ConnectionStrategy strategy,
  });

  Future<void> disconnect();

  Future<void> dispose();
}

/// Temporary engine for the UI shell. It deliberately reports itself through
/// the app log; it must be replaced by a native Windows implementation before
/// shipping a VPN build.
class DemoConnectionEngine implements ConnectionEngine {
  final StreamController<TunnelSnapshot> _snapshots =
      StreamController<TunnelSnapshot>.broadcast();
  Timer? _timer;
  TunnelSnapshot _current = const TunnelSnapshot.disconnected();

  @override
  Stream<TunnelSnapshot> get snapshots => _snapshots.stream;

  @override
  Future<void> connect({
    required ServerOption server,
    required ConnectionStrategy strategy,
  }) async {
    if (_current.isBusy || _current.state == TunnelState.connected) return;

    _emit(TunnelSnapshot(state: TunnelState.connecting, server: server));
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 850), () {
      _emit(TunnelSnapshot(
        state: TunnelState.connected,
        server: server,
        pingMs: server.pingMs,
      ));
    });
  }

  @override
  Future<void> disconnect() async {
    if (_current.isBusy || _current.state == TunnelState.disconnected) return;

    final server = _current.server;
    _emit(TunnelSnapshot(state: TunnelState.disconnecting, server: server));
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 250), () {
      _emit(const TunnelSnapshot.disconnected());
    });
  }

  void _emit(TunnelSnapshot snapshot) {
    _current = snapshot;
    if (!_snapshots.isClosed) _snapshots.add(snapshot);
  }

  @override
  Future<void> dispose() async {
    _timer?.cancel();
    await _snapshots.close();
  }
}
