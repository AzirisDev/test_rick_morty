import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_rick_morty/models/character.dart';
import 'package:http/http.dart' as http;
import 'package:test_rick_morty/models/character_response.dart';

part 'character_event.dart';

part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharacterInitial()) {
    on<GetCharacters>((event, emit) => getCharacters(event, emit));
  }

  Future<void> getCharacters(GetCharacters event, Emitter emit) async {
    emit(CharacterLoading());

    final response = await http.Client()
        .get(Uri.parse('https://rickandmortyapi.com/api/character/?page=${event.pageNumber}'));
    CharacterResponse characterResponse = CharacterResponse.fromJson(json.decode(response.body));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      emit(CharactersGot(characters: characterResponse.characters));
    } else {
      emit(CharacterError(errorMessage: 'Character does not fetched'));
    }
  }
}
