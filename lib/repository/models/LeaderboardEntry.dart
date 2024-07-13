class LeaderboardEntry {
  final String name;
  final String studentNumber;
  final String gender;
  final String branch;
  final String residency;
  final int score;

  LeaderboardEntry({
    required this.name,
    required this.studentNumber,
    required this.gender,
    required this.branch,
    required this.residency,
    required this.score,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      name: json['name'],
      studentNumber: json['studentNumber'],
      gender: json['gender'],
      branch: json['branch'],
      residency: json['residency'],
      score: json['score'],
    );
  }
}