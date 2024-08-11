import 'package:bloc_filejson_un/models/person.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class PersonState {}

class PersonInitial extends PersonState {
  PersonInitial();
}

class PersonLoading extends PersonState {
  PersonLoading();
}

class PersonLoaded extends PersonState {
  final List<Person> persons;

  PersonLoaded(this.persons);
}

class PersonError extends PersonState {
  final String message;

  PersonError(this.message);
}
