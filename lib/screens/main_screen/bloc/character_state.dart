part of 'character_bloc.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharactersGot extends CharacterState {
  CharactersGot({required this.characters});
  final List<Character> characters;
}

class CharacterError extends CharacterState {
  CharacterError({required this.errorMessage});
  final String errorMessage;
}