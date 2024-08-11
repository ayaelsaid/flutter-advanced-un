import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'person_event.dart';
import 'person_state.dart';
import '../repositories/person_repository.dart';


class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonRepository repository;

  PersonBloc(this.repository) : super(PersonLoading()) {
    on<LoadPerson>(loadPerson);
  }

  Future<void> loadPerson(LoadPerson event, Emitter<PersonState> emit) async {
    emit(PersonLoading());
    try {
      final persons = await repository.getPersons();
      print('Loaded persons: $persons'); // Debugging line

      if (persons != null && persons.isNotEmpty) {
        emit(PersonLoaded(persons));
      } else {
        emit(PersonError('No data available'));
      }
    } catch (error) {
      emit(PersonError(error.toString()));
    }
  }
}
