import 'package:flutter/foundation.dart';
import 'package:using_firebase/utilis/courses_option.dart';

@immutable
sealed class CourseState {}
final class CourseInitial extends CourseState {}

class CourseOptionStateChanges extends CourseState {
  final CourseOptions courseOption;

  CourseOptionStateChanges(this.courseOption);
}

// final class CourseInitial extends CourseState {}

// class CourseOptionStateChanges extends CourseState {
//   final CourseOptions courseOption;

//   CourseOptionStateChanges(this.courseOption);
// }

// for lectures
// class LectureState extends CourseState {}

// class LectureChosenState extends LectureState {
//   final Lecture lecture;
//   LectureChosenState(this.lecture);
// }