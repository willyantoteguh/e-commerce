import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/equatable/equatable.dart';
import 'package:product/domain/entity/response/product_category_entity.dart';
import 'package:product/domain/entity/response/product_entity.dart';

class CategoryState extends Equatable {
  final ViewData<List<ProductCategoryEntity>> categoryState;

  const CategoryState({required this.categoryState});

  CategoryState copyWith({ViewData<List<ProductCategoryEntity>>? categoryState}) {
    return CategoryState(categoryState: categoryState ?? this.categoryState);
  }

  @override
  List<Object?> get props => [categoryState];
}
