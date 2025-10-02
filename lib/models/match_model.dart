class Match {
  final String team1Name;
  final String team1Logo;
  final String team2Name;
  final String team2Logo;
  final int team1Score;
  final int team2Score;
  final String matchTime;
  final String league;
  final String odds1;
  final String oddsX;
  final String odds2;
  final String matchImage;
  final bool isLive;

  Match({
    required this.team1Name,
    required this.team1Logo,
    required this.team2Name,
    required this.team2Logo,
    required this.team1Score,
    required this.team2Score,
    required this.matchTime,
    required this.league,
    required this.odds1,
    required this.oddsX,
    required this.odds2,
    required this.matchImage,
    this.isLive = false,
  });
}