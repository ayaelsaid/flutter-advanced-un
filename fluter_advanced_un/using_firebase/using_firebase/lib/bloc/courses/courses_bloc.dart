import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_firebase/utilis/courses_option.dart';

import '../../models/course.dart';
import 'courses_event.dart';
import 'courses_state.dart';


class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseInitial()) {
    on<CourseFetchEvent>(_onGetCourse);
    on<CourseOptionChosenEvent>(_onCourseOptionChosen);
  }
  
  Course? course;

  FutureOr<void> _onGetCourse(
      CourseFetchEvent event, Emitter<CourseState> emit) {
    course = event.course;
    emit(CourseOptionStateChanges(CourseOptions.Lecture));
  }

  FutureOr<void> _onCourseOptionChosen(
      CourseOptionChosenEvent event, Emitter<CourseState> emit) {
    emit(CourseOptionStateChanges(event.courseOptions));
  }
}
