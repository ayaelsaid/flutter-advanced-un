import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_firebase/bloc/lectures/lecture_event.dart';
import 'package:using_firebase/bloc/lectures/lecture_states.dart';


class LectureBloc extends Bloc<LectureEvent, LectureState> {
  LectureBloc() : super(LectureInitial()) {
    on<LectureChosenEvent>(_onLectureChosen);

    on<LectureEventInitial>((event, emit) {
      emit(LectureInitial());
    });
  }
  FutureOr<void> _onLectureChosen(
      LectureChosenEvent event, Emitter<LectureState> emit) {
    emit(LectureChosenState(event.lecture));
  }
}