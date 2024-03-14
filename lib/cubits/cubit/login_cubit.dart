import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  Future<void> login() async {
    const error = 1;

    if (error == 0) {
      await Future.delayed(const Duration(seconds: 3), () {
        emit(state.copyWith(loginStatus: LoginStatus.success));
      });
      emit(
        state.copyWith(loginStatus: LoginStatus.success),
      );
    } else {
      await Future.delayed(const Duration(seconds: 3), () {});
      throw Exception();
    }
  }

  Future<void> callLoadingPage() async {
    emit(state.copyWith(
      loginStatus: LoginStatus.loading,
    ));
  }
}
