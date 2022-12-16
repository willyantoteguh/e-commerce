import 'package:common/utils/constants/app_constants.dart';
import 'package:core/network/models/api_response.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:product/data/model/response/banner_response_dto.dart';
import 'package:product/data/model/response/product_category_response_dto.dart';
import 'package:product/data/model/response/product_detail_response_dto.dart';
import 'package:product/data/model/response/product_response_dto.dart';
import 'package:product/data/model/response/seller_response_dto.dart';

abstract class ProductRemoteDataSource {
  const ProductRemoteDataSource();

  Future<ProductCategoryResponseDto> getProductCategory();

  Future<ProductResponseDto> getProduct();

  Future<BannerResponseDTO> getBanner();

  Future<ProductDetailResponseDto> getProductDetail(String productId);

  Future<SellerResponseDto> getSeller(String sellerId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  const ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<BannerResponseDTO> getBanner() async {
    try {
      final response = await dio.get(
        AppConstants.appApi.banner,
      );
      return BannerResponseDTO.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductResponseDto> getProduct() async {
    try {
      final response = await dio.get(
        AppConstants.appApi.product,
      );
      return ProductResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductCategoryResponseDto> getProductCategory() async {
    try {
      final response = await dio.get(
        AppConstants.appApi.category,
      );
      return ProductCategoryResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductDetailResponseDto> getProductDetail(String productId) async {
    try {
      final response = await dio.get(
        AppConstants.appApi.detailProduct,
        queryParameters: {'product_id': productId},
      );
      return ProductDetailResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SellerResponseDto> getSeller(String sellerId) async {
    try {
      final response = await dio.get(
        "${AppConstants.appApi.seller}$sellerId",
      );
      return SellerResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
