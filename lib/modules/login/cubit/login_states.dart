

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final Success;

  LoginSuccessState(this.Success);
}

class LoginErrorState extends LoginStates {
  final Error;
  LoginErrorState(this.Error);
}

class LoginChangePasswordVisibilityState extends LoginStates {}