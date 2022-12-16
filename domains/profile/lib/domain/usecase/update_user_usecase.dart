import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:profile/domain/entity/request/user_request_entity.dart';
import 'package:profile/domain/entity/response/user_entity.dart';
import 'package:profile/domain/repository/profile_repository.dart';

class UpdateUserUseCase extends UseCase<UserEntity, UserRequestEntity> {
  final ProfileRepository profileRepository;

  const UpdateUserUseCase({required this.profileRepository});

  @override
  Future<Either<FailureResponse, UserEntity>> call(UserRequestEntity params) => profileRepository.updateUserData(userRequestEntity: params);
}
