// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          emit(LoginSuccessState(value.user));
    })
        .catchError((error) {
          emit(LoginErrorState(error.toString()));
    });
  }

  IconData passwordIcon = Icons.remove_red_eye;
  bool isPassword = true;

  void changePasswordState() {
    isPassword = !isPassword;
    passwordIcon = isPassword ? Icons.remove_red_eye : Icons.visibility_off;
    emit(LoginChangePasswordVisibilityState());
  }
}
