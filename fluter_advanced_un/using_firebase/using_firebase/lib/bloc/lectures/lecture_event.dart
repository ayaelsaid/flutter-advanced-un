import 'package:flutter/foundation.dart';
import 'package:using_firebase/models/lectures.dart';

@immutable
sealed class LectureEvent {}


class LectureEventInitial extends LectureEvent {}

class LectureChosenEvent extends LectureEvent {
  final Lecture lecture;
  LectureChosenEvent(this.lecture);
}