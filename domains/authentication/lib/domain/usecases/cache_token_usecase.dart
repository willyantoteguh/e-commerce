import 'package:authentication/domain/repository/authentication_repository.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/dartz/dartz.dart';

class CacheTokenUseCase extends UseCase<bool, String> {
  final AuthenticationRepository authenticationRepository;

  CacheTokenUseCase({
    required this.authenticationRepository,
  });

  @override
  Future<Either<FailureResponse, bool>> call(String params) async => await authenticationRepository.cacheToken(token: params);
}
