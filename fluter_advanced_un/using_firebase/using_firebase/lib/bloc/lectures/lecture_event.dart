import 'package:flutter/foundation.dart';
import 'package:using_firebase/models/lectures.dart';

@immutable
sealed class LectureEvent {}

class FetchLecturesEvent extends LectureEvent {
  final String courseId;

  FetchLecturesEvent(this.courseId);
}

class LectureChosenEvent extends LectureEvent {
  final Lecture lecture;

  LectureChosenEvent(this.lecture);
}

