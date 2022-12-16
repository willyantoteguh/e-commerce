import 'package:core/local/database/database_module.dart';
import 'package:dependencies/drift/drift.dart';
import 'package:product/data/model/response/banner_response_dto.dart';
import 'package:product/data/model/response/product_category_response_dto.dart';
import 'package:product/data/model/response/product_detail_response_dto.dart';
import 'package:product/data/model/response/product_response_dto.dart';
import 'package:product/data/model/response/seller_response_dto.dart';
import 'package:product/domain/entity/response/banner_data_entity.dart';
import 'package:product/domain/entity/response/product_category_entity.dart';
import 'package:product/domain/entity/response/product_detail_entity.dart';
import 'package:product/domain/entity/response/product_entity.dart';
import 'package:product/domain/entity/response/seller_data_entity.dart';

class ProductMapper {
  List<ProductCategoryEntity> mapProductCategoryDTOtoEntity(List<ProductCategoryDataDTO> data) {
    List<ProductCategoryEntity> entity = <ProductCategoryEntity>[];

    for (ProductCategoryDataDTO element in data) {
      entity.add(
        mapProductCategoryDataDTOtoProductCategoryEntity(element),
      );
    }

    return entity;
  }

  ProductCategoryEntity mapProductCategoryDataDTOtoProductCategoryEntity(ProductCategoryDataDTO data) => ProductCategoryEntity(
        id: data.id ?? '',
        name: data.name ?? '',
        imageCover: data.imageCover ?? '',
        imageIcon: data.imageIcon ?? '',
      );

  ProductDataEntity mapProductDataDTOtoProductDataEntity(ProductDataDTO data) => ProductDataEntity(
        count: data.count ?? 0,
        countPerPage: data.countPerPage ?? 0,
        currentPage: data.currentPage ?? 0,
        data: mapProductDTOtoProductEntity(data.data ?? []),
      );

  List<ProductEntity> mapProductDTOtoProductEntity(List<ProductDTO> data) {
    List<ProductEntity> entity = <ProductEntity>[];

    for (ProductDTO element in data) {
      entity.add(
        mapProductDTOToProductEntity(element),
      );
    }

    return entity;
  }

  ProductEntity mapProductDTOToProductEntity(ProductDTO productDTO) => ProductEntity(
        id: productDTO.id ?? "",
        soldCount: productDTO.soldCount ?? 0,
        stock: productDTO.stock ?? 0,
        category: mapProductCategoryDataDTOtoProductCategoryEntity(
          productDTO.category ?? ProductCategoryDataDTO(),
        ),
        imageUrl: productDTO.imageUrl ?? "",
        price: productDTO.price ?? 0,
        popularity: productDTO.popularity ?? 0.0,
        description: productDTO.description ?? "",
        name: productDTO.name ?? "",
        seller: mapSellerDTOToSellerEntity(
          productDTO.seller ?? SellerDTO(),
        ),
      );

  SellerEntity mapSellerDTOToSellerEntity(SellerDTO sellerDTO) => SellerEntity(
        city: sellerDTO.city ?? "",
        id: sellerDTO.id ?? "",
        name: sellerDTO.name ?? "",
      );

  List<BannerDataEntity> mapBannerDataDTOToEntity(List<BannerDataDTO> data) {
    List<BannerDataEntity> entity = <BannerDataEntity>[];

    for (BannerDataDTO element in data) {
      entity.add(
        mapBannerDataDTOToBannerDataEntity(
          element,
        ),
      );
    }

    return entity;
  }

  BannerDataEntity mapBannerDataDTOToBannerDataEntity(BannerDataDTO bannerDataDTO) => BannerDataEntity(
        headline: bannerDataDTO.headline ?? "",
        caption: bannerDataDTO.caption ?? "",
        sellerId: bannerDataDTO.sellerId ?? "",
        name: bannerDataDTO.name ?? "",
        id: bannerDataDTO.id ?? "",
        productId: bannerDataDTO.productId ?? "",
        imageUrl: bannerDataDTO.imageUrl ?? "",
      );

  ProductDetailDataEntity mapProductDetailDataDTOToEntity(ProductDetailDataDto dto) {
    return ProductDetailDataEntity(
      id: dto.id ?? "",
      name: dto.name ?? "",
      seller: mapSellerDetailDTOToEntity(dto.seller),
      stock: dto.stock ?? 0,
      category: mapCategoryProductDetailDTOToEntity(dto.category),
      price: dto.price ?? 0,
      imageUrl: dto.imageUrl ?? "",
      description: dto.description ?? "",
      soldCount: dto.soldCount ?? 0,
      popularity: dto.popularity ?? 0.0,
    );
  }

  CategoryProductDetailEntity mapCategoryProductDetailDTOToEntity(CategoryProductDetailDto dto) {
    return CategoryProductDetailEntity(
      id: dto.id ?? "",
      name: dto.name ?? "",
      imageCover: dto.imageCover ?? "",
      imageIcon: dto.imageIcon ?? "",
    );
  }

  SellerDetailEntity mapSellerDetailDTOToEntity(SellerDetailDto dto) {
    return SellerDetailEntity(
      id: dto.id ?? "",
      name: dto.name ?? "",
      city: dto.city ?? "",
    );
  }

  SellerDataEntity mapSellerDataResponseDTOToEntity(SellerDataDto dto) {
    return SellerDataEntity(
      id: dto.id ?? "",
      username: dto.username ?? "",
      fullName: dto.fullName ?? "",
      role: dto.role ?? "",
      imageUrl: dto.imageUrl ?? "",
      city: dto.city ?? "",
      simpleAddress: dto.simpleAddress ?? "",
    );
  }

  ProductDetailDataEntity mapProductDetailTableToEntity(ProductDetailTableData table) {
    return ProductDetailDataEntity(
      name: table.name,
      stock: table.stock,
      price: table.price,
      imageUrl: table.imgUrl,
      description: table.description,
      soldCount: table.soldCount,
      popularity: table.popularity,
    );
  }

  ProductDetailTableCompanion mapProductDetailDataEntityToTable(ProductDetailDataEntity entity) {
    return ProductDetailTableCompanion(
      name: Value(entity.name),
      stock: Value(entity.stock),
      price: Value(entity.price),
      imgUrl: Value(entity.imageUrl),
      description: Value(entity.description),
      soldCount: Value(entity.soldCount),
      popularity: Value(entity.popularity),
    );
  }
}
