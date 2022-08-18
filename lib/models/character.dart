class Character {
  String name;
  Status status;
  Gender gender;
  String image;
  List<String> episode;

  Character({
    required this.name,
    required this.status,
    required this.gender,
    required this.image,
    required this.episode,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        name: json["name"],
        status: statusValues[json["status"]] ?? Status.unknown,
        gender: genderValues[json["gender"]] ?? Gender.unknown,
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
      );
}

enum Gender { male, female, unknown }

final genderValues = {
  "Female": Gender.female,
  "Male": Gender.male,
  "unknown": Gender.unknown,
};

enum Status { alive, unknown, dead }

final statusValues = {
  "Alive": Status.alive,
  "Dead": Status.dead,
  "unknown": Status.unknown,
};
