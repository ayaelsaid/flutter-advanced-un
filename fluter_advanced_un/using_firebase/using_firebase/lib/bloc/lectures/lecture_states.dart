import 'package:flutter/foundation.dart';
import 'package:using_firebase/models/lectures.dart';

@immutable
sealed class LectureState {}


final class LectureInitial extends LectureState {}

class LectureChosenState extends LectureState {
  final Lecture lecture;
  LectureChosenState(this.lecture);
}