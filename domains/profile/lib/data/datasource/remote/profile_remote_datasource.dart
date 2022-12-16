import 'dart:io';

import 'package:common/utils/constants/app_constants.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:profile/data/model/request/user_request_dto.dart';
import 'package:profile/data/model/response/user_response_dto.dart';

abstract class ProfileRemoteDataSource {
  const ProfileRemoteDataSource();

  Future<UserResponseDto> getUser();
  Future<UserResponseDto> updateProfile({required UserRequestDto userRequestDto});
  Future<UserResponseDto> uploadPhoto({required File image});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  const ProfileRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserResponseDto> getUser() async {
    try {
      final response = await dio.get(AppConstants.appApi.user);

      return UserResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserResponseDto> updateProfile({required UserRequestDto userRequestDto}) async {
    try {
      final response = await dio.put(
        AppConstants.appApi.user,
        data: userRequestDto.toJson(),
      );

      return UserResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserResponseDto> uploadPhoto({required File image}) async {
    try {
      String filename = image.path.split('/').last;
      final FormData formData = FormData.fromMap(
        {
          'image': await MultipartFile.fromFile(
            image.path,
            filename: filename,
            contentType: MediaType('image', 'png'),
          ),
        },
      );

      final response = await dio.put(AppConstants.appApi.updateUserImage,
          data: formData,
          options: Options(headers: {
            'Content-Type': 'multipart/form-data',
          }));

      return UserResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
