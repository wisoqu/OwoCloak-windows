enum ConnectionStrategy { auto, games, video, stream }

extension ConnectionStrategyLabel on ConnectionStrategy {
  String get label => switch (this) {
        ConnectionStrategy.auto => 'Auto',
        ConnectionStrategy.games => 'Games',
        ConnectionStrategy.video => 'Video',
        ConnectionStrategy.stream => 'Stream',
      };

  String get description => switch (this) {
        ConnectionStrategy.auto => 'Traffic-based routing',
        ConnectionStrategy.games => 'Lowest ping',
        ConnectionStrategy.video => 'Least-loaded server',
        ConnectionStrategy.stream => 'Balanced streaming path',
      };
}
