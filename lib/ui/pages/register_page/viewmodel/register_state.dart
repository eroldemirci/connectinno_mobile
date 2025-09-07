import 'package:connectinno_case/core/models/auth_model.dart';
abstract class RegisterState {
  final AuthModel authModel;
  final bool isLoading;
  final String? errorMessage;
  const RegisterState({required this.authModel, this.isLoading = false, this.errorMessage});
}

class RegisterInitial extends RegisterState {
  const RegisterInitial({required AuthModel authModel}) : super(authModel: authModel);
}

class RegisterLoading extends RegisterState {
  const RegisterLoading({required AuthModel authModel}) : super(authModel: authModel, isLoading: true);
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess({required AuthModel authModel}) : super(authModel: authModel);
}

class RegisterFailure extends RegisterState {
  final String error;
  const RegisterFailure({required AuthModel authModel, required this.error}) : super(authModel: authModel, errorMessage: error);
}
