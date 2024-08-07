import 'package:flutter/foundation.dart';

@immutable
sealed class PersonEvent {}

class LoadPerson extends PersonEvent {}
