part of 'login_cubit.dart';

sealed class LoginState {}

class LoginInitial extends LoginState {}

class FacebookLoginInProgress extends LoginState {}

class FacebookLoginSuccess extends LoginState {}

class FacebookLoginFailure extends LoginState {
  final String message;

  FacebookLoginFailure(this.message);
}

class GoogleLoginInProgress extends LoginState {}

class GoogleLoginSuccess extends LoginState {}

class GoogleLoginFailure extends LoginState {
  final String message;

  GoogleLoginFailure(this.message);
}
