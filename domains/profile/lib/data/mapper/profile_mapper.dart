import 'package:profile/data/model/request/user_request_dto.dart';
import 'package:profile/data/model/response/user_response_dto.dart';
import 'package:profile/domain/entity/request/user_request_entity.dart';
import 'package:profile/domain/entity/response/user_entity.dart';

class ProfileMapper {
  UserEntity mapUserDataDTOtoUserEntity(UserDataDTO? userDataDTO) => UserEntity(
      id: userDataDTO?.id ?? '',
      username: userDataDTO?.username ?? '',
      role: userDataDTO?.role ?? '',
      imageUrl: userDataDTO?.imageUrl ?? '',
      fullName: userDataDTO?.fullName ?? '',
      city: userDataDTO?.city ?? '',
      simpleAddress: userDataDTO?.simpleAddress ?? '');

  UserRequestDto mapUserEntityToDto(UserRequestEntity userRequestEntity) =>
      UserRequestDto(fullName: userRequestEntity.fullName, simpleAddress: userRequestEntity.simpleAddress, fcmToken: userRequestEntity.fcmToken, fcmServerKey: userRequestEntity.fcmServerKey);
}
