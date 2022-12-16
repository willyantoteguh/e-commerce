import 'package:core/network/models/api_response.dart';

class AllPaymentResponseDto extends BaseResponse {
  AllPaymentResponseDto({
    this.data,
  });

  List<PaymentDataDto>? data;

  factory AllPaymentResponseDto.fromJson(Map<String, dynamic> json) {
    return AllPaymentResponseDto()..data = List<PaymentDataDto>.from(json["data"].map((x) => PaymentDataDto.fromJson(x)));
  }
}

class PaymentDataDto {
  PaymentDataDto({
    required this.name,
    required this.code,
    required this.paymentType,
    required this.isActivated,
  });

  final String? name;
  final String? code;
  final String? paymentType;
  final bool? isActivated;

  factory PaymentDataDto.fromJson(Map<String, dynamic> json) => PaymentDataDto(
        name: json["name"],
        code: json["code"],
        paymentType: json["payment_type"],
        isActivated: json["is_activated"],
      );
}
