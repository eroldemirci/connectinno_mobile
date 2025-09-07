import 'package:connectinno_case/core/managers/auth_manager/auth_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  void emailChanged(String value) {
    emit(LoginInitial(email: value.trim(), password: state.password));
  }

  void passwordChanged(String value) {
    emit(LoginInitial(email: state.email, password: value));
  }

  Future<void> loginUser() async {
    emit(LoginLoading(email: state.email, password: state.password));
    try {
      final result = await AuthManager.instance.login(email: state.email, password: state.password);
      if (result) {
        emit(LoginSuccess(email: state.email, password: state.password));
      } else {
        emit(LoginFailure(email: state.email, password: state.password, error: 'Login failed'));
      }
    } catch (e) {
      emit(LoginFailure(email: state.email, password: state.password, error: e.toString()));
    }
  }
}
