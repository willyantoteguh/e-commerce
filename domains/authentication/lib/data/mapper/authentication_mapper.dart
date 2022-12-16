import 'package:authentication/data/model/body/auth_request_dto.dart';
import 'package:authentication/data/model/response/auth_response_dto.dart';
import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:authentication/domain/entity/response/auth_response_entity.dart';

class AuthenticationMapper {
  AuthRequestDto mapAuthRequestEntityToAuthRequestDto(AuthRequestEntity authRequestEntity) => AuthRequestDto(username: authRequestEntity.username, password: authRequestEntity.password);

  AuthResponseEntity mapAuthResponseDtoToAuthResponseEntity(AuthResponse? authResponseDto) => AuthResponseEntity(token: authResponseDto?.token ?? "");
}
