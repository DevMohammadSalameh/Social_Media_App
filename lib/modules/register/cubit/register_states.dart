
abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final Success;

  RegisterSuccessState(this.Success);
}

class RegisterErrorState extends RegisterStates {
  final Error;
  RegisterErrorState(this.Error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates {}