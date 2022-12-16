import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:payment/domain/entity/response/payment_entity.dart';
import 'package:payment/domain/repository/payment_repository.dart';

class GetAllPaymentMethodUseCase extends UseCase<List<PaymentDataEntity>, NoParams> {
  final PaymentRepository paymentRepository;

  GetAllPaymentMethodUseCase({required this.paymentRepository});

  @override
  Future<Either<FailureResponse, List<PaymentDataEntity>>> call(NoParams params) async => await paymentRepository.getAllPaymentMethod();
}
