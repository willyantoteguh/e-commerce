import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/dartz/dartz.dart';

import '../entity/request/add_to_chart_entity.dart';
import '../entity/response/chart_entity.dart';
import '../repository/chart_repository.dart';

class AddToChartUseCase extends UseCase<ChartDataEntity, AddToChartEntity> {
  final ChartRepository chartRepository;

  AddToChartUseCase({
    required this.chartRepository,
  });

  @override
  Future<Either<FailureResponse, ChartDataEntity>> call(AddToChartEntity params) async => await chartRepository.addToChart(params);
}
