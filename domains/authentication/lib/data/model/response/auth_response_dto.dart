import 'package:core/network/models/api_response.dart';

class AuthResponseDto extends BaseResponse {
  AuthResponseDto({
    this.data,
  });

  AuthResponse? data;

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthResponseDto()..data = AuthResponse.fromJson(json["data"]);
  }
}

class AuthResponse {
  AuthResponse({
    this.token,
  });

  final String? token;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        token: json["token"],
      );
}
