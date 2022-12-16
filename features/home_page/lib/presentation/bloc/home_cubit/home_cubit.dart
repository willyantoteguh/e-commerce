import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:home_page/presentation/bloc/home_cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(homeState: ViewData.loaded(data: 0)));

  void changeTab({required int tabIndex}) {
    emit(
      HomeState(
        homeState: ViewData.loaded(data: tabIndex),
      ),
    );
  }
}
