import 'package:cart/data/datasource/remote/chart_remote_datasource.dart';
import 'package:cart/data/mapper/chart_mapper.dart';
import 'package:cart/domain/entity/response/chart_entity.dart';
import 'package:cart/domain/entity/request/add_to_chart_entity.dart';
import 'package:cart/domain/repository/chart_repository.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:dartz/dartz.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dio/dio.dart';

class ChartRepositoryImpl implements ChartRepository {
  final ChartRemoteDataSource chartRemoteDataSource;
  final ChartMapper mapper;

  ChartRepositoryImpl({required this.chartRemoteDataSource, required this.mapper});

  @override
  Future<Either<FailureResponse, ChartDataEntity>> addToChart(AddToChartEntity body) async {
    try {
      final response = await chartRemoteDataSource.addToChart(mapper.mapAddToChartEntityToDto(body));

      return Right(mapper.mapChartDataDtoToEntity(response.data!));
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.response?.data[AppConstants.errorKey.message]?.toString() ?? error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, ChartDataEntity>> deleteChart(AddToChartEntity body) async {
    try {
      final response = await chartRemoteDataSource.deleteChart(mapper.mapAddToChartEntityToDto(body));

      return Right(mapper.mapChartDataDtoToEntity(response.data!));
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.response?.data[AppConstants.errorKey.message]?.toString() ?? error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, ChartDataEntity>> getCharts() async {
    try {
      final response = await chartRemoteDataSource.getCharts();

      return Right(mapper.mapChartDataDtoToEntity(response.data!));
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.response?.data[AppConstants.errorKey.message]?.toString() ?? error.response.toString(),
        ),
      );
    }
  }
}
