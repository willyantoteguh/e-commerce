import '../data/product_mapper.dart';
import '../model/banner_response_dto_dummy.dart';

final ProductMapper productMapper = ProductMapper();

final bannerEntityDummy = productMapper.mapBannerDataDTOToEntity(bannerResponseDTODummy?.data ?? []);
