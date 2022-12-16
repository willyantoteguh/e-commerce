import 'package:dependencies/dartz/dartz.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product/data/datasource/local/product_local_datasource.dart';
import 'package:product/data/datasource/remote/product_remote_datasource.dart';
import 'package:product/data/mapper/product_mapper.dart';
import 'package:product/data/repository/product_repository_impl.dart';
import 'package:product/domain/entity/response/banner_data_entity.dart';
import 'package:product/domain/repository/product_repository.dart';

import '../../helper/model/banner_response_dto_dummy.dart';

void main() => testProductRepositoryTest();

class MockProductRemoteDataSource extends Mock implements ProductRemoteDataSource {}

class MockProductLocalDataSource extends Mock implements ProductLocalDataSource {}

void testProductRepositoryTest() {
  late final ProductRemoteDataSource _mockProductRemoteDataSource;
  late final ProductLocalDataSource _mockProductLocalDataSource;
  late final ProductMapper _mockProductMapper;
  late final ProductRepository _productRepository;

  setUpAll(() {
    _mockProductRemoteDataSource = MockProductRemoteDataSource();
    _mockProductLocalDataSource = MockProductLocalDataSource();
    _mockProductMapper = ProductMapper();
    _productRepository = ProductRepositoryImpl(productRemoteDataSource: _mockProductRemoteDataSource, productLocalDataSource: _mockProductLocalDataSource, mapper: _mockProductMapper);
  });

  group('Product Repository Impl', () {
    test('''Success \t
    GIVEN Right<BannerResponseDTO> from RemoteDataSource
    WHEN getBanner method executed
    THEN return Right<List<BannerDataEntity>>
    ''', () async {
      /// GIVEN
      when(() => _mockProductRemoteDataSource.getBanner()).thenAnswer(
        (_) async => Future.value(bannerResponseDTODummy),
      );

      /// WHEN
      final result = await _productRepository.getBanner();

      /// THEN
      expect(result, isA<Right>());
      expect(result.getOrElse(() => []).first, isA<BannerDataEntity>());
      expect(result.getOrElse(() => []).first.name, bannerResponseDTODummy?.data?[0].name ?? "");
    });

    test('''Fail \t
    GIVEN Right<BannerResponseDTO> from RemoteDataSource
    WHEN getBanner method executed
    THEN return Left<Failure>
    ''', () async {
      /// GIVEN
      when(() => _mockProductRemoteDataSource.getBanner()).thenThrow(DioError(requestOptions: RequestOptions(path: "")));

      /// WHEN
      final result = await _productRepository.getBanner();

      /// THEN
      expect(result, isA<Left>());
    });
  });
}
