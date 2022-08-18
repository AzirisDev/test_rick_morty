import 'dart:convert';

import 'package:test_rick_morty/models/character.dart';
import 'package:test_rick_morty/models/info.dart';

CharacterResponse characterResponseFromJson(String str) =>
    CharacterResponse.fromJson(json.decode(str));

class CharacterResponse {
  Info info;
  List<Character> characters;

  CharacterResponse({
    required this.info,
    required this.characters,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) => CharacterResponse(
    info: Info.fromJson(json["info"]),
    characters: List<Character>.from(json["results"].map((x) => Character.fromJson(x))),
  );

}