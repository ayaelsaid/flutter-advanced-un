class CourseOptions {
  static const Lecture = CourseOptions._('Lecture');
  static const Download = CourseOptions._('Download');
  static const Certificate = CourseOptions._('Certificate');
  static const More = CourseOptions._('More');

  final String name;
  const CourseOptions._(this.name);

  @override
  String toString() => name;
}
