part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

class GetCharacters extends CharacterEvent {
  GetCharacters({
    required this.pageNumber,
  });
  final int pageNumber;
}
