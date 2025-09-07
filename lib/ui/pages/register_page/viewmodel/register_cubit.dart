import 'package:connectinno_case/core/managers/auth_manager/auth_manager.dart';
import 'package:connectinno_case/core/models/auth_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial(authModel: AuthModel(email: '', password: '', confirmPassword: '')));

  void emailChanged(String value) {
    emit(RegisterInitial(authModel: state.authModel.copyWith(email: value)));
  }

  void passwordChanged(String value) {
    emit(RegisterInitial(authModel: state.authModel.copyWith(password: value)));
  }

  void confirmPasswordChanged(String value) {
    emit(RegisterInitial(authModel: state.authModel.copyWith(confirmPassword: value)));
  }

  Future<void> registerUser() async {
    emit(RegisterLoading(authModel: state.authModel));
    try {
      if (state.authModel.password != state.authModel.confirmPassword) {
        emit(RegisterFailure(authModel: state.authModel, error: 'Passwords do not match'));
        return;
      }
      final result = await AuthManager.instance.register(email: state.authModel.email, password: state.authModel.password);
      if (result) {
        emit(RegisterSuccess(authModel: state.authModel));
      } else {
        emit(RegisterFailure(authModel: state.authModel, error: 'Registration failed'));
      }
    } catch (e) {
      emit(RegisterFailure(authModel: state.authModel, error: e.toString()));
    }
  }
}
