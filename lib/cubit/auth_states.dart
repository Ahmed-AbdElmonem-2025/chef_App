abstract class AuthStates {}

class InitialState extends AuthStates {}


class SignUpImageUpdatedState extends AuthStates{}
class SignUpSuccessState extends AuthStates{
  final String  Msg;
  SignUpSuccessState(this.Msg);
}
class SignUpErrorState extends AuthStates{
  final String errorMsg;
  SignUpErrorState(this.errorMsg);
}
class SignUpLoadingState extends AuthStates{}


class LoginSuccessState extends AuthStates {}
class LoginErrorState extends AuthStates {
  final String errorMsg;
  LoginErrorState(this.errorMsg);
}
class LoginLoadingState extends AuthStates {}



class SendCodeErrorState extends AuthStates {
final String errorMsg;
  SendCodeErrorState(this.errorMsg);
}
class SendCodeSuccessState extends AuthStates {}
class SendCodeLoadingState extends AuthStates {}









class ResetPasswordSuccessState extends AuthStates {}
class ResetPasswordLoadingState extends AuthStates {}
class ResetPasswordErrorState extends AuthStates {
  final String errorMsg;
  ResetPasswordErrorState(this.errorMsg);
}