
abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final Error;
  RegisterErrorState(this.Error);
}

class RegisterCreateUserSuccessState extends RegisterStates {}

class RegisterCreateUserErrorState extends RegisterStates {
  final Error;
  RegisterCreateUserErrorState(this.Error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates {}