// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // late UserModel registerModel;
  void userRegister({
    required String email,
    required String name,
    required String phone,
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
      emit(RegisterSuccessState());
      userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid.toString());
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
    String image =
        "https://i.pinimg.com/564x/95/14/a2/9514a2106bdf506dc2ed2047ae4ba908.jpg",
    String cover =
        "https://i.pinimg.com/564x/48/77/10/4877107db152d077b13b2c7b21623dfb.jpg",
    String bio = "Write your bio ...",
    bool isVerified = false,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isVerified: isVerified,
      image: image,
      cover: cover,
      bio: bio,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterCreateUserErrorState(error.toString()));
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
