import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:authentication/domain/entity/response/auth_response_entity.dart';
import 'package:authentication/domain/repository/authentication_repository.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class SignInUseCase extends UseCase<AuthResponseEntity, AuthRequestEntity> {
  final AuthenticationRepository authenticationRepository;

  SignInUseCase({required this.authenticationRepository});

  @override
  Future<Either<FailureResponse, AuthResponseEntity>> call(AuthRequestEntity params) async => await authenticationRepository.signIn(authRequestEntity: params);
}
