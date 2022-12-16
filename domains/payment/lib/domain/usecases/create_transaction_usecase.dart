import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:payment/domain/entity/response/create_payment_entity.dart';
import 'package:payment/domain/repository/payment_repository.dart';

class CreateTransactionUseCase extends UseCase<CreatePaymentDataEntity, String> {
  final PaymentRepository paymentRepository;

  CreateTransactionUseCase({required this.paymentRepository});

  @override
  Future<Either<FailureResponse, CreatePaymentDataEntity>> call(String params) async => await paymentRepository.createTransaction(params);
}
