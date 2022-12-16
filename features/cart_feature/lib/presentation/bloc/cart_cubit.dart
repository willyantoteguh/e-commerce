import 'dart:developer';

import 'package:cart/domain/entity/request/add_to_chart_entity.dart';
import 'package:cart/domain/entity/response/chart_entity.dart';
import 'package:cart/domain/usecase/add_to_chart_usecase.dart';
import 'package:cart/domain/usecase/delete_chart_usecase.dart';
import 'package:cart/domain/usecase/get_chart_usecase.dart';
import 'package:cart_feature/presentation/bloc/cart_state.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';

class CartCubit extends Cubit<CartState> {
  final GetChartUseCase getChartUseCase;
  final AddToChartUseCase addToChartUseCase;
  final DeleteChartUseCase deleteChartUseCase;

  CartCubit({
    required this.getChartUseCase,
    required this.addToChartUseCase,
    required this.deleteChartUseCase,
  }) : super(
          CartState(
            cartListState: ViewData.initial(),
            addCartState: ViewData.initial(),
            deleteCartState: ViewData.initial(),
          ),
        );

  //Get list cart
  void getCart() async {
    emit(state.copyWith(cartListState: ViewData.loading(message: 'Loading..')));

    final result = await getChartUseCase.call(const NoParams());
    return result.fold(
      (failure) => _onFailureGetCart(failure),
      (data) => _onSuccessGetCart(data),
    );
  }

  Future<void> _onFailureGetCart(FailureResponse failure) async {
    emit(state.copyWith(cartListState: ViewData.error(message: 'Error', failure: failure)));
  }

  Future<void> _onSuccessGetCart(ChartDataEntity data) async {
    if (data.product.isEmpty) {
      emit(state.copyWith(cartListState: ViewData.noData(message: 'Empty Data')));
    } else {
      final listSelectedProduct = <bool>[];

      for (var e in data.product) {
        log("Product: ${e.product.name}");
        listSelectedProduct.add(false);
      }

      emit(state.copyWith(
        cartListState: ViewData.loaded(data: data),
        selectAll: false,
        selectProducts: listSelectedProduct,
        totalAmount: 0,
      ));
    }
  }

  //Add Item
  void addProduct({
    required String productId,
    required int amount,
    required int index,
  }) async {
    emit(state.copyWith(addCartState: ViewData.loading(message: 'Loading..')));

    final result = await addToChartUseCase.call(AddToChartEntity(productId: productId, amount: amount));
    return result.fold((failure) => _onFailureAddCart(failure), (data) => _onSuccessAddCart(data, index));
  }

  Future<void> _onFailureAddCart(FailureResponse failure) async {
    emit(state.copyWith(addCartState: ViewData.error(message: 'Error', failure: failure)));
  }

  Future<void> _onSuccessAddCart(ChartDataEntity data, int index) async {
    if (data.product.isEmpty) {
      emit(state.copyWith(addCartState: ViewData.noData(message: 'No Data'), cartListState: ViewData.noData(message: 'No Data')));
    } else {
      //// tmp
      int amount = 0;

      //// state
      final totalAmountState = state.totalAmount;
      final selectAllState = state.selectAll;
      final selectProductState = state.selectProducts;

      final selectedItemProduct = selectProductState[index];

      if (selectAllState || selectedItemProduct) {
        final priceSelected = data.product[index].product.price;
        amount = totalAmountState + priceSelected;
      } else {
        amount = totalAmountState;
      }

      if (!selectedItemProduct) {
        amount = totalAmountState;
      }

      emit(
        state.copyWith(
          addCartState: ViewData.loaded(data: data),
          cartListState: ViewData.loaded(data: data),
          totalAmount: amount,
        ),
      );
    }
  }

  //Delete Item
  void deleteProduct({
    required String productId,
    required int amount,
    required int index,
  }) async {
    emit(state.copyWith(deleteCartState: ViewData.loading(message: 'Loading..')));

    final result = await deleteChartUseCase.call(AddToChartEntity(productId: productId, amount: amount));
    return result.fold((failure) => _onFailureDeleteCart(failure), (data) => _onSuccessDeleteCart(data, index));
  }

  Future<void> _onFailureDeleteCart(FailureResponse failure) async {
    emit(state.copyWith(addCartState: ViewData.error(message: 'Error Delete', failure: failure)));
  }

  Future<void> _onSuccessDeleteCart(ChartDataEntity data, int index) async {
    if (data.product.isEmpty) {
      emit(state.copyWith(deleteCartState: ViewData.noData(message: "No Data"), cartListState: ViewData.noData(message: "No Data")));
    } else {
      //// tmp
      int amount = 0;

      //// state
      final totalAmountState = state.totalAmount;
      final selectAllState = state.selectAll;
      final selectProductState = state.selectProducts;

      final selectedItemProduct = selectProductState[index];

      if (selectAllState || selectedItemProduct) {
        final priceSelected = data.product[index].product.price;
        amount = totalAmountState - priceSelected;
      } else {
        amount = totalAmountState;
      }

      if (!selectedItemProduct) {
        amount = totalAmountState;
      }

      emit(
        state.copyWith(
          deleteCartState: ViewData.loaded(data: data),
          cartListState: ViewData.loaded(data: data),
          totalAmount: amount,
        ),
      );
    }
  }

  void selectAll(bool selected) {
    int totalAmount = 0;
    final selectProducts = state.selectProducts;
    final newSelectProducts = <bool>[];
    final data = state.cartListState.data;

    if (selected) {
      final products = data?.product ?? [];

      for (var item in products) {
        if (item.quantity < 0) {
          totalAmount += 0;
        } else {
          totalAmount += (item.product.price * item.quantity);
        }
      }

      for (var item in selectProducts) {
        log("Must be true: $item");
        newSelectProducts.add(true);
      }

      emit(
        state.copyWith(
          selectProducts: newSelectProducts,
          selectAll: selected,
          totalAmount: totalAmount,
          cartListState: ViewData.loaded(data: data),
        ),
      );
    } else {
      totalAmount = 0;

      for (var item in selectProducts) {
        log("Must be false: $item");
        newSelectProducts.add(false);
      }

      emit(
        state.copyWith(
          selectProducts: newSelectProducts,
          selectAll: selected,
          totalAmount: totalAmount,
          cartListState: ViewData.loaded(data: data),
        ),
      );
    }
  }

  // void selectItemProduct(bool selected, int index) {
  //   //// tmp
  //   int amount = 0;
  //   bool selectAll = false;
  //   final listSelectedProducts = <bool>[];

  //   /// state
  //   final productState = state.cartListState.data?.product ?? [];
  //   final listSelectProductState = state.selectProducts;
  //   final amountState = state.totalAmount;

  //   listSelectedProducts.addAll(listSelectProductState);

  //   if (selected) {
  //     if (listSelectedProducts.isEmpty) {
  //       listSelectedProducts.insert(index, true);
  //     } else {
  //       listSelectedProducts.insert(index, false);
  //     }

  //     for (var e in listSelectedProducts) {
  //       if (e == true) {
  //         selectAll = true;
  //       } else {
  //         break;
  //       }
  //     }

  //     final qtySelected = productState[index].quantity;
  //     final priceSelected = productState[index].product.price;

  //     amount = amountState + (qtySelected * priceSelected);

  //     emit(state.copyWith(
  //       selectProducts: listSelectedProducts,
  //       selectAll: selectAll,
  //       totalAmount: amount,
  //     ));
  //   } else {
  //     listSelectedProducts[index] = selected;

  //     final qtySelected = productState[index].quantity;
  //     final priceSelected = productState[index].product.price;

  //     amount = amountState - (qtySelected * priceSelected);

  //     emit(state.copyWith(
  //       selectProducts: listSelectedProducts,
  //       selectAll: selectAll,
  //       totalAmount: amount,
  //       // cartListState: ViewData.loaded(data)
  //     ));
  //   }
  // }

  void selectItemProduct(bool selected, int index) {
    final selectProducts = state.selectProducts;
    final newSelectProducts = <bool>[];
    final selectAllState = state.selectAll;
    final data = state.cartListState.data;
    var totalAmount = state.totalAmount;
    var selectAll = false;

    final products = data?.product ?? [];
    final selectedAmount = products[index].product.price;
    final quantity = products[index].quantity;

    newSelectProducts.addAll(selectProducts);
    if (selected) {
      final total = totalAmount + selectedAmount;

      //// Select per item get total from price * quantity
      if (quantity > 1) {
        log('q');
        totalAmount += (selectedAmount * quantity);
      } else {
        totalAmount = total;
      }

      newSelectProducts[index] = true;
      log('a');
    } else if (!selectAllState) {
      totalAmount = 0;
      newSelectProducts[index] = false;
      log('b');
    } else {
      final total = totalAmount - selectedAmount;

      if (quantity > 1) {
        log('q unselect');
        totalAmount -= (selectedAmount * quantity);
      } else {
        totalAmount = total;
      }

      newSelectProducts[index] = false;
      log('c');
    }

    for (var i in newSelectProducts) {
      if (i) {
        selectAll = true;
      } else {
        selectAll = false;
        break;
      }
    }

    emit(state.copyWith(
      selectAll: selectAll,
      totalAmount: totalAmount,
      selectProducts: newSelectProducts,
      cartListState: ViewData.loaded(data: data),
    ));
  }
}
