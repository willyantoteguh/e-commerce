// class ApiResponse<T> {
//   bool? status;
//   int? code;
//   String? message;
//   T? data;
//   // late dynamic Function(T) onSerialized;
//   // late T Function(dynamic) onDeSerialized;

//   ApiResponse({
//     this.status,
//     this.code,
//     this.message,
//     this.data,
//     // required this.onSerialized,
//     // required this.onDeSerialized,
//   });

//   ApiResponse.fromJson(
//     var json,
//     // required dynamic Function(T) onDataSerialized,
//     // required T Function(dynamic) onDataDeserialized,
//   ) {
//     // onSerialized = onDataSerialized;
//     // onDeSerialized = onDataDeserialized;
//     status = json['status'];
//     code = json['code'];
//     message = json['message'];
//     data = json['data'] != null ? json['data'] : null;
//   }

//   Map<String, dynamic> toJson() => {
//         'status': status,
//         'code': code,
//         'message': message,
//         'data': data != null ? data as T : null,
//       };
// }

class BaseResponse {
  late bool? status;
  late int? code;
  late String? message;

  BaseResponse();

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse()
    ..status = json['status']
    ..code = json['code']
    ..message = json['message'] as String;
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) => <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };
