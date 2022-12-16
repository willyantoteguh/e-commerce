import 'package:core/network/models/api_response.dart';

class ProductCategoryResponseDto extends BaseResponse {
  ProductCategoryResponseDto({
    this.data,
  });

  List<ProductCategoryDataDTO>? data;

  factory ProductCategoryResponseDto.fromJson(Map<String, dynamic> json) {
    return ProductCategoryResponseDto()..data = List<ProductCategoryDataDTO>.from(json["data"].map((x) => ProductCategoryDataDTO.fromJson(x)));
  }
}

class ProductCategoryDataDTO {
  ProductCategoryDataDTO({
    this.id,
    this.name,
    this.imageCover,
    this.imageIcon,
  });

  final String? id;
  final String? name;
  final String? imageCover;
  final String? imageIcon;

  factory ProductCategoryDataDTO.fromJson(Map<String, dynamic> json) => ProductCategoryDataDTO(
        id: json["id"],
        name: json["name"],
        imageCover: json["image_cover"],
        imageIcon: json["image_icon"],
      );
}
