import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reels_viewer/reels_viewer.dart';
import 'package:using_firebase/bloc/courses/courses_bloc.dart';
import 'package:using_firebase/bloc/courses/courses_event.dart';
import 'package:using_firebase/bloc/courses/courses_state.dart';
import 'package:using_firebase/bloc/lectures/lecture_bloc.dart';
import 'package:using_firebase/bloc/lectures/lecture_event.dart';
import 'package:using_firebase/bloc/lectures/lecture_states.dart';
import 'package:using_firebase/models/course.dart';
import 'package:using_firebase/utilis/courses_option.dart';
import 'package:using_firebase/widgets/lecture_chips.dart';

class CourseDetailsPage extends StatefulWidget {
  static const String id = 'course_details';
  final Course course;
  const CourseDetailsPage({required this.course, super.key});

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CourseBloc>().add(CourseFetchEvent(widget.course));
    context.read<LectureBloc>().add(FetchLecturesEvent(widget.course.id ?? ''));
  }

  var reelsList = <ReelModel>[
    ReelModel('assets/videos/proj.mp4', 'Darshan Patil',
        likeCount: 2000, isLiked: true, reelDescription: "First coding.")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<LectureBloc, LectureState>(
            builder: (context, lectureState) {
              if (lectureState is LectureChosenState &&
                  lectureState.lecture.lecture_url != null) {
                return ReelsViewer(
                  reelsList: reelsList,
                  appbarTitle: 'Instagram Reels',
                  onShare: (url) {
                    developer.log('Shared reel url ==> $url',
                        name: 'ReelsViewer');
                  },
                  onLike: (url) {
                    developer.log('Liked reel url ==> $url',
                        name: 'ReelsViewer');
                  },
                  onComment: (comment) {
                    developer.log('Comment on reel ==> $comment',
                        name: 'ReelsViewer');
                  },
                  onClickMoreBtn: () {
                    developer.log('======> Clicked on more option <======',
                        name: 'ReelsViewer');
                  },
                  onClickBackArrow: () {
                    developer.log('======> Clicked on back arrow <======',
                        name: 'ReelsViewer');
                  },
                  onIndexChanged: (index) {
                    developer.log(
                        '======> Current Index ======> $index <========',
                        name: 'ReelsViewer');
                  },
                  showProgressIndicator: true,
                  showVerifiedTick: true,
                  showAppbar: true,
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocBuilder<CourseBloc, CourseState>(
              buildWhen: (previous, current) =>
                  current is CourseOptionStateChanges,
              builder: (context, state) {
                if (state is CourseOptionStateChanges) {
                  final courseOption = state.courseOption;
                  return AnimatedContainer(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    duration: const Duration(seconds: 3),
                    alignment: Alignment.bottomCenter,
                    height: MediaQuery.sizeOf(context).height - 220,
                    curve: Curves.easeInOut,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              widget.course.title ?? 'No Name',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.course.instructor?.name ??
                                  'No Instructor Name',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: BlocBuilder<LectureBloc, LectureState>(
                                builder: (context, lectureState) {
                                  if (lectureState is LectureListState) {
                                    return Column(
                                      children: [
                                        LectureChipsWidget(
                                          selectedOption: courseOption,
                                          onChanged: (courseOption) {
                                            context.read<CourseBloc>().add(
                                                CourseOptionChosenEvent(
                                                    courseOption));
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        Expanded(
                                          child: courseOption ==
                                                  CourseOptions.Lecture
                                              ? lectureState.lectures.isEmpty
                                                  ? const Center(
                                                      child: Text(
                                                          'No lectures available'))
                                                  : GridView.count(
                                                      mainAxisSpacing: 15,
                                                      crossAxisSpacing: 15,
                                                      shrinkWrap: true,
                                                      crossAxisCount: 2,
                                                      children: List.generate(
                                                          lectureState.lectures
                                                              .length, (index) {
                                                        final lecture =
                                                            lectureState
                                                                    .lectures[
                                                                index];
                                                        return InkWell(
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    LectureBloc>()
                                                                .add(LectureChosenEvent(
                                                                    lecture));
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xffE0E0E0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40),
                                                            ),
                                                            child: Center(
                                                              child: Text(lecture
                                                                      .title ??
                                                                  'No Name'),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    )
                                              : const SizedBox.shrink(),
                                        ),
                                      ],
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
