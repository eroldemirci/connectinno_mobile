abstract class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;
  const LoginState({required this.email, required this.password, this.isLoading = false, this.errorMessage});
}

class LoginInitial extends LoginState {
  const LoginInitial({String email = '', String password = ''}) : super(email: email, password: password);
}

class LoginLoading extends LoginState {
  const LoginLoading({required String email, required String password}) : super(email: email, password: password, isLoading: true);
}

class LoginSuccess extends LoginState {
  const LoginSuccess({required String email, required String password}) : super(email: email, password: password);
}

class LoginFailure extends LoginState {
  final String error;
  const LoginFailure({required String email, required String password, required this.error})
    : super(email: email, password: password, errorMessage: error);
}
