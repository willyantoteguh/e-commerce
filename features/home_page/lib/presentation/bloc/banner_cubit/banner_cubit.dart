import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:home_page/presentation/bloc/banner_cubit/banner_state.dart';
import 'package:product/domain/usecase/get_banner_usecase.dart';

class BannerCubit extends Cubit<BannerState> {
  final GetBannerUseCase getBannerUseCase;

  BannerCubit({required this.getBannerUseCase}) : super(BannerState(bannerState: ViewData.initial()));

  void getBanner() async {
    emit(
      BannerState(
        bannerState: ViewData.loading(),
      ),
    );

    final result = await getBannerUseCase.call(const NoParams());

    result.fold(
      (failure) => emit(
        BannerState(
          bannerState: ViewData.error(message: failure.errorMessage, failure: failure),
        ),
      ),
      (result) => emit(
        BannerState(
          bannerState: ViewData.loaded(data: result),
        ),
      ),
    );
  }
}
