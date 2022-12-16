import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/dartz/dartz.dart';

import '../entity/response/chart_entity.dart';
import '../repository/chart_repository.dart';

class GetChartUseCase extends UseCase<ChartDataEntity, NoParams> {
  final ChartRepository chartRepository;

  GetChartUseCase({
    required this.chartRepository,
  });

  @override
  Future<Either<FailureResponse, ChartDataEntity>> call(NoParams params) async => await chartRepository.getCharts();
}
