// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:using_firebase/bloc/courses/courses_bloc.dart';
// import 'package:using_firebase/bloc/courses/courses_event.dart';
// import 'package:using_firebase/bloc/courses/courses_state.dart';
// import 'package:using_firebase/bloc/lectures/lecture_bloc.dart';
// import 'package:using_firebase/bloc/lectures/lecture_event.dart';
// import 'package:using_firebase/bloc/lectures/lecture_states.dart';
// import 'package:using_firebase/models/course.dart';
// import 'package:using_firebase/utilis/color_utilis.dart';
// import 'package:using_firebase/widgets/courses_option.dart';
// import 'package:using_firebase/widgets/lecture_chips.dart';
// import 'package:using_firebase/widgets/video_controller.dart';

// class CourseDetailsPage extends StatefulWidget {
//   static const String id = 'course_details';
//   final Course course;

//   const CourseDetailsPage({required this.course, super.key});

//   @override
//   State<CourseDetailsPage> createState() => _CourseDetailsPageState();
// }

// class _CourseDetailsPageState extends State<CourseDetailsPage> {
//   bool appelselyChanges = false;

//   @override
//     void initState() {
//     super.initState();

//     // Dispatch the event with the course (course is required, no need for null check)
//     context.read<CourseBloc>().add(CourseFetchEvent(widget.course));

//     context.read<LectureBloc>().add(LectureEventInitial());
//   }

//   void initAnimation() async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     if (!mounted) return;
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       setState(() {
//       });
//     });
//   }

//   @override
//   void didChangeDependencies() {
//     initAnimation();
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var applyChanges;
//     return Scaffold(
//       body: Stack(
//         children: [
//           BlocBuilder<LectureBloc, LectureState>(
//             builder: (ctx, state) {
//               var stateEx = state is LectureChosenState ? state : null;
//               if (stateEx == null) {
//                 return const SizedBox.shrink();
//               }

//               return Container(
//                 height: 250,
//                 child: stateEx.lecture.lecture_url == null ||
//                         stateEx.lecture.lecture_url == ''
//                     ? const Center(
//                         child: Text(
//                         'Invalid Url',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                       ))
//                     : VideoBoxWidget(
//                         url: stateEx.lecture.lecture_url ?? '',
//                       ),
//               );
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: AnimatedContainer(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25)),
//               ),
//               duration: const Duration(seconds: 3),
//               height: applyChanges
//                   ? MediaQuery.sizeOf(context).height - 220
//                   : null,
//               curve: Curves.easeInOut,
//               child: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const SizedBox(height: 30),
//                       Text(
//                         widget.course.title!.isNotEmpty
//                             ? widget.course.title! : 'no title',

//                         style: const TextStyle(
//                             fontWeight: FontWeight.w700, fontSize: 20),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         widget.course.instructor?.name ?? 'No Instructor Name',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w400, fontSize: 17),
//                       ),
//                       const SizedBox(height: 10),
//                       _BodyWidget(),

//                     ],
//                   ),
//                 ),
//               ),
//             )),
//         Positioned(
//           top: 20,
//           child: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios_new,
//               color: ColorUtility.main,
//             ),
//           ),
//         ),
//       ],
//     ));
//   }
// }

// class _BodyWidget extends StatefulWidget {
//   const _BodyWidget({super.key});

//   @override
//   State<_BodyWidget> createState() => __BodyWidgetState();
// }

// class __BodyWidgetState extends State<_BodyWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: BlocBuilder<CourseBloc, CourseState>(builder: (ctx, state) {
//         return Column(
//           children: [
//             LectureChipsWidget(
//               selectedOption: (state is CourseOptionStateChanges)
//                   ? state.courseOption
//                   : null,
//               onChanged: (courseOption) {
//                 context
//                     .read<CourseBloc>()
//                     .add(CourseOptionChosenEvent(courseOption));
//               },
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Expanded(
//                 child: (state is CourseOptionStateChanges)
//                     ? CourseOptionsWidgets(
//                         course: context.read<CourseBloc>().course!,
//                         courseOption: state.courseOption,
//                         onLectureChosen: (lecture) async {
//                           try {
//                             FirebaseFirestore.instance
//                                 .collection('course_user_progress')
//                                 .doc(FirebaseAuth.instance.currentUser!.uid)
//                                 .update({
//                               context.read<CourseBloc>().course!.id!:
//                                   FieldValue.increment(1)
//                             });
//                           } catch (e) {
//                             FirebaseFirestore.instance
//                                 .collection('course_user_progress')
//                                 .doc(FirebaseAuth.instance.currentUser!.uid)
//                                 .set({
//                               context.read<CourseBloc>().course!.id!: 1
//                             });
//                           }
//                           context
//                               .read<LectureBloc>()
//                               .add(LectureChosenEvent(lecture));
//                         },
//                       )
//                     : const SizedBox.shrink())
//           ],
//         );
//       }),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_firebase/bloc/courses/courses_bloc.dart';
import 'package:using_firebase/bloc/courses/courses_event.dart';
import 'package:using_firebase/bloc/courses/courses_state.dart';
import 'package:using_firebase/bloc/lectures/lecture_bloc.dart';
import 'package:using_firebase/bloc/lectures/lecture_event.dart';
import 'package:using_firebase/bloc/lectures/lecture_states.dart';
import 'package:using_firebase/models/course.dart';
import 'package:using_firebase/utilis/color_utilis.dart';
import 'package:using_firebase/widgets/courses_option.dart';
import 'package:using_firebase/widgets/lecture_chips.dart';
import 'package:using_firebase/widgets/video_controller.dart';

class CourseDetailsPage extends StatefulWidget {
  static const String id = 'course_details';
  final Course course;

  const CourseDetailsPage({required this.course, super.key});

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  bool applyChanges = false;

  @override
  void initState() {
    super.initState();
    if (widget.course.id != null && widget.course.id!.isNotEmpty) {
      context.read<CourseBloc>().add(CourseFetchEvent(widget.course));
    } else {
      print('Invalid course ID: ${widget.course.id}');
    }

    context.read<LectureBloc>().add(LectureEventInitial());
  }

  void initAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        applyChanges = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    initAnimation();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<LectureBloc, LectureState>(
            builder: (ctx, state) {
              if (state is LectureChosenState) {
                final lecture = state.lecture;
                if (lecture.lecture_url != null &&
                    lecture.lecture_url!.isNotEmpty) {
                  return Container(
                    height: 200,
                    width: double.infinity, // Ensure full width
                    child: VideoBoxWidget(
                      url: lecture.lecture_url!,
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Invalid Url',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              duration: const Duration(seconds: 3),
              height: applyChanges
                  ? MediaQuery.of(context).size.height - 220
                  : null,
              curve: Curves.easeInOut,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        widget.course.title?.isNotEmpty == true
                            ? widget.course.title!
                            : 'No Title',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.course.instructor?.name ?? 'No Instructor Name',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 17),
                      ),
                      const SizedBox(height: 10),
                      const _BodyWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: ColorUtility.main,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget();

  @override
  State<_BodyWidget> createState() => __BodyWidgetState();
}

class __BodyWidgetState extends State<_BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CourseBloc, CourseState>(builder: (ctx, state) {
        if (state is CourseOptionStateChanges) {
          return Column(
            children: [
              LectureChipsWidget(
                selectedOption: state.courseOption,
                onChanged: (courseOption) {
                  context
                      .read<CourseBloc>()
                      .add(CourseOptionChosenEvent(courseOption));
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: CourseOptionsWidgets(
                  course: context.read<CourseBloc>().course!,
                  courseOption: state.courseOption,
                  onLectureChosen: (lecture) async {
                    try {
                      await FirebaseFirestore.instance
                          .collection('course_user_progress')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        context.read<CourseBloc>().course!.id!:
                            FieldValue.increment(1)
                      }, SetOptions(merge: true));
                    } catch (e) {
                      print("Error updating course progress: $e");
                    }
                    context
                        .read<LectureBloc>()
                        .add(LectureChosenEvent(lecture));
                  },
                ),
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      }),
    );
  }
}
