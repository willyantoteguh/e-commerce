import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:payment/data/datasource/remote/payment_remote_datasource.dart';
import 'package:payment/data/mapper/payment_mapper.dart';
import 'package:payment/domain/entity/response/create_payment_entity.dart';
import 'package:payment/domain/entity/response/payment_entity.dart';
import 'package:payment/domain/entity/response/product_history_entity.dart';
import 'package:payment/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;
  final PaymentMapper mapper;

  PaymentRepositoryImpl({required this.remoteDataSource, required this.mapper});

  @override
  Future<Either<FailureResponse, CreatePaymentDataEntity>> createTransaction(String paymentCode) async {
    try {
      final response = await remoteDataSource.createTransaction(paymentCode);

      final transaction = mapper.mapListCreateTransactionDataDtoToEntity(response.data);

      bool success = false;
      String errorMessage = '';
      CreatePaymentDataEntity paymentDataEntity = const CreatePaymentDataEntity();

      for (var e in transaction) {
        final createPayment = await remoteDataSource.createPayment(e.transactionId);
        final statusCode = createPayment.code ?? 0;
        if (statusCode == 200) {
          success = true;
          final result = mapper.mapCreatePaymentDataDtoToEntity(createPayment.data);
          paymentDataEntity = result;
        } else {
          success = false;
          paymentDataEntity = const CreatePaymentDataEntity();
          errorMessage = createPayment.message ?? '';
          break;
        }
      }

      if (success) {
        return Right(paymentDataEntity);
      } else {
        return Left(FailureResponse(errorMessage: errorMessage));
      }
    } on DioError catch (error) {
      return Left(FailureResponse(errorMessage: error.response?.data[AppConstants.errorKey.message]?.toString() ?? error.response.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, List<PaymentDataEntity>>> getAllPaymentMethod() async {
    try {
      final response = await remoteDataSource.getAllPaymentMethod();

      return Right(mapper.mapListPaymentDataDtoToEntity(response.data));
    } on DioError catch (error) {
      return Left(FailureResponse(errorMessage: error.response?.data[AppConstants.errorKey.message]?.toString() ?? error.response.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, HistoryEntity>> getHistory() async {
    try {
      final response = await remoteDataSource.getHistory();
      return Right(
        mapper.mapHistoryEntity(response.data),
      );
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.response?.data[AppConstants.errorKey.message]?.toString() ?? error.response.toString(),
        ),
      );
    }
  }
}
