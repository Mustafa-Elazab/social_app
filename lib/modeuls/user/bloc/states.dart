

abstract class UserStates {}

class UserLoginIntinalState extends UserStates {}

class UserLoginLoadingState extends UserStates {}

class UserLoginSucessState extends UserStates {

}

class UserLoginErrorState extends UserStates {
  final String error;

  UserLoginErrorState(this.error);
}
class UserShowPasswordState extends UserStates {}
class UserRegisterLoadingState extends UserStates {}

class UserRegisterSucessState extends UserStates {

}

class UserRegisterErrorState extends UserStates {
final String error;

  UserRegisterErrorState(this.error);
}
class UserOtpRegisterSucessState extends UserStates {

}

class UserOtpRegisterErrorState extends UserStates {
  final String error;


  UserOtpRegisterErrorState(this.error);
}

class CreateUserSucessState extends UserStates {

}

class CreateUserErrorState extends UserStates {
  final String error;

  CreateUserErrorState(this.error);
}

class GetUserLoadingState extends UserStates {}

class GetUserSucessState extends UserStates {

}

class GetUserErrorState extends UserStates {
  final String error;

  GetUserErrorState(this.error);
}





