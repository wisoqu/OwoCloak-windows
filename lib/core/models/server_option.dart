class ServerOption {
  final String name;
  final String region;
  final int pingMs;
  final bool recommended;

  const ServerOption({
    required this.name,
    required this.region,
    required this.pingMs,
    this.recommended = false,
  });
}
