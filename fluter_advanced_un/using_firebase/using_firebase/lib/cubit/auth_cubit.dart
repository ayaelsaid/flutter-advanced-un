import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_firebase/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      var credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credentials.user != null) {
        emit(LoginSuccess());
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginFailed(_getAuthErrorMessage(e)));
    } catch (e) {
      emit(LoginFailed('Something went wrong: $e'));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());
    try {
      var credentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credentials.user != null) {
        await credentials.user!.updateDisplayName(name);
        emit(SignupSuccess());
      }
    } on FirebaseAuthException catch (e) {
      emit(SignupFailed(_getAuthErrorMessage(e)));
    } catch (e) {
      emit(SignupFailed('Sign up Exception: $e'));
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(PasswordResetLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(PasswordResetSuccess());
    } on FirebaseAuthException catch (e) {
      emit(PasswordResetFailed(_getAuthErrorMessage(e)));
    } catch (e) {
      emit(PasswordResetFailed('Password reset Exception: $e'));
    }
  }

  String _getAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'user-disabled':
        return 'User Disabled';
      case 'invalid-credential':
        return 'Invalid Credential';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      default:
        return 'Something went wrong';

    }
  }
}
