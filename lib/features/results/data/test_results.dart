class TestResults {
  final Stats stats;
  final List<Result> results;

  TestResults({
    required this.stats,
    required this.results,
  });

  factory TestResults.fromMap(Map<String, dynamic> json) => TestResults(
        stats: Stats.fromMap(json["stats"]),
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "stats": stats.toMap(),
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Result {
  final int id;
  final String name;
  final List<Candidate> candidates;

  Result({
    required this.id,
    required this.name,
    required this.candidates,
  });

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        candidates: List<Candidate>.from(
            json["candidates"].map((x) => Candidate.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "candidates": List<dynamic>.from(candidates.map((x) => x.toMap())),
      };
}

class Candidate {
  final int id;
  final User user;
  final List<Vote> votes;

  Candidate({
    required this.id,
    required this.user,
    required this.votes,
  });

  factory Candidate.fromMap(Map<String, dynamic> json) => Candidate(
        id: json["id"],
        user: User.fromMap(json["user"]),
        votes: List<Vote>.from(json["votes"].map((x) => Vote.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user": user.toMap(),
        "votes": List<dynamic>.from(votes.map((x) => x.toMap())),
      };
}

class User {
  final int id;
  final String fullName;

  User({
    required this.id,
    required this.fullName,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["fullName"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "fullName": fullName,
      };
}

class Vote {
  final int id;

  Vote({
    required this.id,
  });

  factory Vote.fromMap(Map<String, dynamic> json) => Vote(
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}

class Stats {
  final int totalVerified;
  final int totalVotes;

  Stats({
    required this.totalVerified,
    required this.totalVotes,
  });

  factory Stats.fromMap(Map<String, dynamic> json) => Stats(
        totalVerified: json["totalVerified"],
        totalVotes: json["totalVotes"],
      );

  Map<String, dynamic> toMap() => {
        "totalVerified": totalVerified,
        "totalVotes": totalVotes,
      };
}
