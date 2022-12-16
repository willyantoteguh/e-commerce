import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:home_page/presentation/bloc/category_cubit/category_state.dart';
import 'package:home_page/presentation/bloc/product_cubit/product_state.dart';
import 'package:product/domain/usecase/get_product_category_usecase.dart';
import 'package:product/domain/usecase/get_product_usecase.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetProductCategoryUseCase getProductCategoryUseCase;

  CategoryCubit({required this.getProductCategoryUseCase}) : super(CategoryState(categoryState: ViewData.initial()));

  void getCategory() async {
    emit(
      CategoryState(
        categoryState: ViewData.loading(),
      ),
    );

    final result = await getProductCategoryUseCase.call(const NoParams());

    result.fold(
      (failure) => emit(
        CategoryState(
          categoryState: ViewData.error(message: failure.errorMessage, failure: failure),
        ),
      ),
      (result) => emit(
        CategoryState(
          categoryState: ViewData.loaded(data: result),
        ),
      ),
    );
  }
}
