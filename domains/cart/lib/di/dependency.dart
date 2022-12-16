import 'package:cart/data/datasource/remote/chart_remote_datasource.dart';
import 'package:cart/data/mapper/chart_mapper.dart';
import 'package:cart/data/repository/chart_repository_impl.dart';
import 'package:cart/domain/repository/chart_repository.dart';
import 'package:cart/domain/usecase/add_to_chart_usecase.dart';
import 'package:cart/domain/usecase/delete_chart_usecase.dart';
import 'package:cart/domain/usecase/get_chart_usecase.dart';
import 'package:dependencies/get_it/get_it.dart';

class ChartDependency {
  ChartDependency() {
    _registerDataSource();
    _registerMapper();
    _registerRepository();
    _registerUseCase();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<ChartRemoteDataSource>(
      () => ChartRemoteDataSourceImpl(
        dio: sl(),
      ),
    );
  }

  void _registerMapper() => sl.registerLazySingleton<ChartMapper>(
        () => ChartMapper(),
      );

  void _registerRepository() => sl.registerLazySingleton<ChartRepository>(
        () => ChartRepositoryImpl(
          chartRemoteDataSource: sl(),
          mapper: sl(),
        ),
      );

  void _registerUseCase() {
    sl.registerLazySingleton<AddToChartUseCase>(
      () => AddToChartUseCase(
        chartRepository: sl(),
      ),
    );

    sl.registerLazySingleton<GetChartUseCase>(
      () => GetChartUseCase(
        chartRepository: sl(),
      ),
    );

    sl.registerLazySingleton<DeleteChartUseCase>(
      () => DeleteChartUseCase(
        chartRepository: sl(),
      ),
    );
  }
}
