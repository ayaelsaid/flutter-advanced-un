import 'package:flutter/foundation.dart';
import 'package:using_firebase/models/course.dart';
import 'package:using_firebase/utilis/courses_option.dart';

@immutable
sealed class CourseEvent {}
class CourseFetchEvent extends CourseEvent {
  final Course course;

  CourseFetchEvent(this.course);
}

class CourseOptionChosenEvent extends CourseEvent {
  final CourseOptions courseOptions;

  CourseOptionChosenEvent(this.courseOptions);
}

// class CourseFetchEvent extends CourseEvent {
//   final Course course;

//   CourseFetchEvent(this.course);
// }

// class CourseOptionChosenEvent extends CourseEvent {
//   final CourseOptions courseOptions;

//   CourseOptionChosenEvent(this.courseOptions);
// }

// class LectureChosenEvent extends CourseEvent {
//   final Lecture lecture;
//   LectureChosenEvent(this.lecture);
// }