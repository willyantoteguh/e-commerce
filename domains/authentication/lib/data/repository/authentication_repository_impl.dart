import 'package:authentication/data/datasource/local/authentication_local_datasource.dart';
import 'package:authentication/data/datasource/remote/authentication_remote_datasource.dart';
import 'package:authentication/data/mapper/authentication_mapper.dart';
import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:authentication/domain/entity/response/auth_response_entity.dart';
import 'package:authentication/domain/repository/authentication_repository.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:dartz/dartz.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dio/dio.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationLocalDataSource authenticationLocalDataSource;
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  final AuthenticationMapper mapper;

  AuthenticationRepositoryImpl({required this.authenticationLocalDataSource, required this.mapper, required this.authenticationRemoteDataSource});

  @override
  Future<Either<FailureResponse, bool>> cacheOnBoarding() async {
    try {
      await authenticationLocalDataSource.cacheOnBoarding();
      return const Right(true);
    } on Exception catch (error) {
      return Left(FailureResponse(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, bool>> getOnBoardingStatus() async {
    try {
      final response = await authenticationLocalDataSource.getOnBoardingStatus();
      return Right(response);
    } on Exception catch (error) {
      return Left(FailureResponse(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, AuthResponseEntity>> signIn({required AuthRequestEntity authRequestEntity}) async {
    try {
      final response = await authenticationRemoteDataSource.signIn(
        authRequestDto: mapper.mapAuthRequestEntityToAuthRequestDto(authRequestEntity),
      );
      return Right(
        mapper.mapAuthResponseDtoToAuthResponseEntity(response.data),
      );
    } on DioError catch (e) {
      return Left(
        FailureResponse(
          errorMessage: e.response?.data[AppConstants.errorKey.message]?.toString() ?? e.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, AuthResponseEntity>> signUp({required AuthRequestEntity authRequestEntity}) async {
    try {
      final response = await authenticationRemoteDataSource.signUp(
        authRequestDto: mapper.mapAuthRequestEntityToAuthRequestDto(authRequestEntity),
      );
      return Right(
        mapper.mapAuthResponseDtoToAuthResponseEntity(response.data),
      );
    } on DioError catch (e) {
      return Left(
        FailureResponse(
          errorMessage: e.response?.data[AppConstants.errorKey.message]?.toString() ?? e.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, bool>> cacheToken({required String token}) async {
    try {
      await authenticationLocalDataSource.cacheToken(token: token);
      return const Right(true);
    } on Exception catch (error) {
      return Left(FailureResponse(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, String>> getToken() async {
    try {
      final response = await authenticationLocalDataSource.getToken();
      return Right(response);
    } on Exception catch (error) {
      return Left(FailureResponse(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, bool>> removeUserData() async {
    try {
      final response = await authenticationLocalDataSource.removeUserData();
      return Right(response);
    } on Exception catch (error) {
      return Left(FailureResponse(errorMessage: error.toString()));
    }
  }
}
