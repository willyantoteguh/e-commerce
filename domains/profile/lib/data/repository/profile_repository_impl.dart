import 'dart:io';

import 'package:common/utils/constants/app_constants.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:profile/data/datasource/remote/profile_remote_datasource.dart';
import 'package:profile/data/mapper/profile_mapper.dart';
import 'package:profile/domain/entity/request/user_request_entity.dart';
import 'package:profile/domain/entity/response/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ProfileMapper profileMapper;

  ProfileRepositoryImpl({required this.profileRemoteDataSource, required this.profileMapper});

  @override
  Future<Either<FailureResponse, UserEntity>> getUser() async {
    try {
      final response = await profileRemoteDataSource.getUser();
      return Right(profileMapper.mapUserDataDTOtoUserEntity(response.data!));
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.response?.data[AppConstants.errorKey.message]?.toString() ?? error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, UserEntity>> updateUserData({required UserRequestEntity userRequestEntity}) async {
    try {
      final response = await profileRemoteDataSource.updateProfile(userRequestDto: profileMapper.mapUserEntityToDto(userRequestEntity));
      return Right(profileMapper.mapUserDataDTOtoUserEntity(response.data!));
    } on DioError catch (e) {
      return Left(
        FailureResponse(
          errorMessage: e.response?.data[AppConstants.errorKey.message]?.toString() ?? e.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, UserEntity>> uploadPhoto({required File image}) async {
    try {
      final response = await profileRemoteDataSource.uploadPhoto(image: image);
      return Right(profileMapper.mapUserDataDTOtoUserEntity(response.data!));
    } on DioError catch (e) {
      return Left(
        FailureResponse(
          errorMessage: e.response?.data(AppConstants.errorKey.message)?.toString() ?? e.response.toString(),
        ),
      );
    }
  }
}
