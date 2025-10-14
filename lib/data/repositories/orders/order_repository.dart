import 'package:dio/dio.dart';
import 'package:store_app/core/result/result.dart';
import 'package:store_app/core/services/client.dart';
import '../../models/orders/order_model.dart';

class OrderRepository {
  final ApiClient _client;

  const OrderRepository({required ApiClient client}) : _client = client;

  Future<Result<void>> createOrder({
    required int addressId,
    required String paymentMethod,
    int? cardId,
  }) async {
    try {
      final payload = {
        'addressId': addressId,
        'paymentMethod': paymentMethod,
        if (cardId != null) 'cardId': cardId,
      };

      print('➡ Sending POST /orders/create with payload: $payload');
      final result = await _client.post('/orders/create', data: payload);

      return result.fold(
        onError: (error) {
          print('❌ API Error in createOrder: $error');
          if (error is DioException && error.response?.data != null) {
            print('Response: ${error.response?.data}');
          }
          return Result.error(error);
        },
        onSuccess: (_) {
          print('✅ createOrder success');
          return Result.success(null);
        },
      );
    } catch (e) {
      print('⚠ Exception in createOrder: $e');
      return Result.error(Exception('Failed to create order: $e'));
    }
  }

  Future<Result<List<OrderModel>>> getOrders() async {
    try {
      print('➡ Fetching orders from /orders/list');
      final result = await _client.get('/orders/list');

      return result.fold(
        onError: (error) {
          print('❌ API Error in getOrders: $error');
          if (error is DioException && error.response?.data != null) {
            print('Response: ${error.response?.data}');
          }
          return Result.error(error);
        },
        onSuccess: (data) {
          try {
            final List<dynamic> jsonList =
            data is List ? data : (data['data'] ?? data);
            final orders = OrderListResponse.fromJson(jsonList).orders;
            return Result.success(orders);
          } catch (e) {
            print('⚠ JSON parsing error: $e');
            return Result.error(Exception('Failed to parse orders: $e'));
          }
        },
      );
    } catch (e) {
      print('⚠ Exception in getOrders: $e');
      return Result.error(Exception('Failed to load orders: $e'));
    }
  }
}
