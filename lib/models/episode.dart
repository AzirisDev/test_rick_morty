class Episode {
  String name;
  String episode;
  String airDate;

  Episode({
    required this.name,
    required this.episode,
    required this.airDate,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
    name: json["name"],
    episode: json["episode"],
    airDate: json["air_date"]
  );
}