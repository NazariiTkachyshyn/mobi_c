part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState(
      {this.status = FormzSubmissionStatus.initial,
      this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.isValid = false,
      this.errorMassage = ''});

  final FormzSubmissionStatus status;
  final Username username;
  final Password password;
  final bool isValid;
  final String errorMassage;

  LoginState copyWith(
      {FormzSubmissionStatus? status,
      Username? username,
      Password? password,
      bool? isValid,
      String? errorMassage}) {
    return LoginState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
        errorMassage: errorMassage ?? this.errorMassage);
  }

  @override
  List<Object> get props => [status, username, password, errorMassage];
}
