// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // late UserModel registerModel;
  void userRegister({
    required String email,
    required String name,
    required dynamic phone,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(RegisterSuccessState(value.user));
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  IconData passwordIcon = Icons.remove_red_eye;
  bool isPassword = true;

  void changePasswordState() {
    isPassword = !isPassword;
    passwordIcon = isPassword ? Icons.remove_red_eye : Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }
}
