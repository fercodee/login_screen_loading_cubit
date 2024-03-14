part of 'login_cubit.dart';

enum LoginStatus {
  loading,
  error,
  success,
  initial,
}

class LoginState extends Equatable {
  final LoginStatus? loginStatus;

  const LoginState({
    this.loginStatus,
  });

  factory LoginState.initial() {
    return const LoginState(loginStatus: LoginStatus.initial);
  }

  @override
  List<Object> get props => [loginStatus!];

  @override
  bool get stringify => true;

  LoginState copyWith({
    LoginStatus? loginStatus,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }
}
