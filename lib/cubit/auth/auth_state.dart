import 'package:equatable/equatable.dart';
import 'package:sales/models/auth/login_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitialState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

//
class AuthErrorState extends AuthState {
  final String errorMessage;

  const AuthErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// login success state
class LoginSuccessState extends AuthState {
  final LoginModel loginModel;

  const LoginSuccessState(this.loginModel);

  @override
  List<Object?> get props => [loginModel];
}
