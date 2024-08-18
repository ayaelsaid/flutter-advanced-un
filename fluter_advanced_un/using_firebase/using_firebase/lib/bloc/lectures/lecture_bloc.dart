import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_firebase/bloc/lectures/lecture_event.dart';
import 'package:using_firebase/bloc/lectures/lecture_states.dart';
import 'package:using_firebase/models/lectures.dart';

class LectureBloc extends Bloc<LectureEvent, LectureState> {
  LectureBloc() : super(LectureInitial()) {
    on<FetchLecturesEvent>(_onFetchLecturesEvent);
    on<LectureChosenEvent>(_onLectureChosenEvent);
  }

  Future<void> _onFetchLecturesEvent(
      FetchLecturesEvent event, Emitter<LectureState> emit) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('courses')
          .doc(event.courseId)
          .collection('lectures')
          .get();

      final lectures = snapshot.docs
          .map((doc) => Lecture.fromJson({'id': doc.id, ...doc.data()}))
          .toList();

      emit(LectureListState(lectures));
    } catch (_) {
      emit(LectureListState(const [])); // Or handle errors appropriately
    }
  }

  void _onLectureChosenEvent(
      LectureChosenEvent event, Emitter<LectureState> emit) {
    emit(LectureChosenState(event.lecture));
  }
}
