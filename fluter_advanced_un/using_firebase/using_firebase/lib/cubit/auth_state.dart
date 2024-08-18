import 'package:flutter/foundation.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// Signup States
final class SignupState extends AuthState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {}

final class SignupFailed extends SignupState {
  final String error;
  SignupFailed(this.error);
}

// Login States
final class LoginState extends AuthState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailed extends LoginState {
  final String error;
  LoginFailed(this.error);
}
final class PasswordResetState extends AuthState {}

final class PasswordResetLoading extends PasswordResetState {}

final class PasswordResetSuccess extends PasswordResetState {}

final class PasswordResetFailed extends PasswordResetState {
  final String error;
  PasswordResetFailed(this.error);
}
