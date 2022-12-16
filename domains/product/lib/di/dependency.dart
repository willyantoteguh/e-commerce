import 'package:dependencies/get_it/get_it.dart';
import 'package:product/data/datasource/local/product_local_datasource.dart';
import 'package:product/data/datasource/remote/product_remote_datasource.dart';
import 'package:product/data/mapper/product_mapper.dart';
import 'package:product/data/repository/product_repository_impl.dart';
import 'package:product/domain/repository/product_repository.dart';
import 'package:product/domain/usecase/delete_product_usecase.dart';
import 'package:product/domain/usecase/get_banner_usecase.dart';
import 'package:product/domain/usecase/get_favorite_product_usecase.dart';
import 'package:product/domain/usecase/get_product_category_usecase.dart';
import 'package:product/domain/usecase/get_product_usecase.dart';
import 'package:product/domain/usecase/get_seller_usecase.dart';
import 'package:product/domain/usecase/save_product_usecase.dart';

import '../domain/usecase/get_product_detail_usecase.dart';

class ProductDependency {
  ProductDependency() {
    _registerDataSource();
    _registerMapper();
    _registerRepository();
    _registerUseCase();
  }

  _registerDataSource() {
    sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(
        dio: sl(),
      ),
    );

    sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(
        database: sl(),
      ),
    );
  }

  _registerMapper() => sl.registerLazySingleton<ProductMapper>(
        () => ProductMapper(),
      );

  _registerRepository() => sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(
          productRemoteDataSource: sl(),
          productLocalDataSource: sl(),
          mapper: sl(),
        ),
      );

  _registerUseCase() {
    sl.registerLazySingleton<GetBannerUseCase>(
      () => GetBannerUseCase(
        productRepository: sl(),
      ),
    );

    sl.registerLazySingleton<GetProductCategoryUseCase>(
      () => GetProductCategoryUseCase(
        productRepository: sl(),
      ),
    );

    sl.registerLazySingleton<GetProductUseCase>(
      () => GetProductUseCase(
        productRepository: sl(),
      ),
    );

    sl.registerLazySingleton<GetProductDetailUseCase>(
      () => GetProductDetailUseCase(
        productRepository: sl(),
      ),
    );

    sl.registerLazySingleton<GetSellerUseCase>(
      () => GetSellerUseCase(
        productRepository: sl(),
      ),
    );

    sl.registerLazySingleton<SaveProductUseCase>(
      () => SaveProductUseCase(
        productRepository: sl(),
      ),
    );

    sl.registerLazySingleton<DeleteProductUseCase>(
      () => DeleteProductUseCase(
        productRepository: sl(),
      ),
    );

    sl.registerLazySingleton<GetFavoriteProductByUrlUseCase>(
      () => GetFavoriteProductByUrlUseCase(
        productRepository: sl(),
      ),
    );
  }
}
