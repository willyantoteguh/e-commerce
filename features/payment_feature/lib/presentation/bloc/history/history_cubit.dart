import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:payment/domain/entity/response/product_history_entity.dart';
import 'package:payment/domain/usecases/get_history_usecase.dart';
import 'package:payment_feature/presentation/bloc/history/history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistoryUseCase getHistoryUseCase;

  HistoryCubit({required this.getHistoryUseCase}) : super(HistoryState(historyState: ViewData.initial()));

  void getHistory() async {
    emit(state.copyWith(historyState: ViewData.loading(message: 'Loading..')));

    final result = await getHistoryUseCase.call(const NoParams());
    return result.fold((failure) => _onFailureGetHistory(failure), (data) => _onSuccessGetHistory(data));
  }

  void _onFailureGetHistory(FailureResponse failure) {
    emit(state.copyWith(historyState: ViewData.error(message: failure.errorMessage, failure: failure)));
  }

  void _onSuccessGetHistory(HistoryEntity data) {
    // if (data.data.isEmpty) {
    //   emit(state.copyWith(historyState: ViewData.noData(message: 'Empty History Transaction')));
    // } else {
    // }
    emit(state.copyWith(historyState: ViewData.loaded(data: data)));
  }
}
