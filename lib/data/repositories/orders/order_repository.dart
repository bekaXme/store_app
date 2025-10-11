import 'package:dio/dio.dart';
import 'package:store_app/core/result/result.dart';
import 'package:store_app/core/services/client.dart';

class OrderRepository {
  final ApiClient _client;

  OrderRepository({required ApiClient client}) : _client = client;

  Future<Result<void>> createOrder({
    required int addressId,
    required String paymentMethod,
    int? cardId,
  }) async {
    final payload = {
      'addressId': addressId,
      'paymentMethod': paymentMethod,
      if (cardId != null) 'cardId': cardId,
    };
    print('Sending POST /orders/create with payload: $payload');
    final result = await _client.post('/orders/create', data: payload);
    return result.fold(
      onError: (error) {
        print(
          'API Error in createOrder: $error, Response: ${error is DioException ? error.response?.data : null}',
        );
        return Result.error(error);
      },
      onSuccess: (_) {
        print('createOrder success');
        return Result.success(null);
      },
    );
  }
}
