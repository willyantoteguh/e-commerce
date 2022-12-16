import 'dart:io';

import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/dartz/dartz.dart';

import '../entity/request/user_request_entity.dart';
import '../entity/response/user_entity.dart';
import '../repository/profile_repository.dart';

class UploadPhotoUseCase extends UseCase<UserEntity, File> {
  final ProfileRepository profileRepository;

  const UploadPhotoUseCase({required this.profileRepository});

  @override
  Future<Either<FailureResponse, UserEntity>> call(File params) => profileRepository.uploadPhoto(image: params);
}
