import 'dart:convert';

import 'package:core/network/models/api_response.dart';
import 'package:product/data/model/response/banner_response_dto.dart';

import '../json_reader.dart';

final resultBannerDummyJson = json.decode(
  TestHelper.readJson(
    'helper/json/banner.json',
  ),
);

final BannerResponseDTO? bannerResponseDTODummy = BannerResponseDTO.fromJson(resultBannerDummyJson);
