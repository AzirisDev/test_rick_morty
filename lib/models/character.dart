import 'dart:convert';

import 'package:test_rick_morty/models/episode.dart';

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
        status: statusValues[json["status"]] ?? Status.UNKNOWN,
        gender: genderValues[json["gender"]] ?? Gender.UNKNOWN,
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
      );
}

enum Gender { MALE, FEMALE, UNKNOWN }

final genderValues = {
  "Female": Gender.FEMALE,
  "Male": Gender.MALE,
  "unknown": Gender.UNKNOWN,
};

enum Status { ALIVE, UNKNOWN, DEAD }

final statusValues = {
  "Alive": Status.ALIVE,
  "Dead": Status.DEAD,
  "unknown": Status.UNKNOWN,
};
