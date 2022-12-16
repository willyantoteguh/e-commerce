import 'package:authentication/data/model/body/auth_request_dto.dart';
import 'package:authentication/data/model/response/auth_response_dto.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:core/network/models/api_response.dart';
import 'package:dependencies/dio/dio.dart';

abstract class AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSource();

  Future<AuthResponseDto> signUp({required AuthRequestDto authRequestDto});
  Future<AuthResponseDto> signIn({required AuthRequestDto authRequestDto});
}

class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  final Dio dio;

  AuthenticationRemoteDataSourceImpl({required this.dio});

  @override
  Future<AuthResponseDto> signIn({required AuthRequestDto authRequestDto}) async {
    try {
      final response = await dio.post(
        AppConstants.appApi.signIn,
        data: authRequestDto.toJson(),
      );
      return AuthResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponseDto> signUp({required AuthRequestDto authRequestDto}) async {
    try {
      final response = await dio.post(
        AppConstants.appApi.signUp,
        data: authRequestDto.toJson(),
      );
      return AuthResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
