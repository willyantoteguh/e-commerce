import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:dependencies/equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class UserNameChange extends SignInEvent {
  final String username;

  const UserNameChange({required this.username});

  @override
  List<Object?> get props => [username];
}

class PasswordChange extends SignInEvent {
  final String password;

  const PasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class SignIn extends SignInEvent {
  final AuthRequestEntity authRequestEntity;

  const SignIn({required this.authRequestEntity});

  @override
  List<Object?> get props => [authRequestEntity];
}
