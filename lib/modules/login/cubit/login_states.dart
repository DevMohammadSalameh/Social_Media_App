

import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final User? user;

  LoginSuccessState(this.user);
}

class LoginErrorState extends LoginStates {
  final Error;
  LoginErrorState(this.Error);
}

class LoginChangePasswordVisibilityState extends LoginStates {}