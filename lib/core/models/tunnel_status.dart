import 'server_option.dart';

enum TunnelState { disconnected, connecting, connected, disconnecting, error }

class TunnelSnapshot {
  final TunnelState state;
  final ServerOption? server;
  final int? pingMs;
  final String? errorMessage;

  const TunnelSnapshot({
    required this.state,
    this.server,
    this.pingMs,
    this.errorMessage,
  });

  const TunnelSnapshot.disconnected()
      : state = TunnelState.disconnected,
        server = null,
        pingMs = null,
        errorMessage = null;

  bool get isBusy =>
      state == TunnelState.connecting || state == TunnelState.disconnecting;
}
