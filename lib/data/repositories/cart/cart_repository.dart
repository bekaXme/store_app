import 'package:dio/dio.dart';
import 'package:store_app/core/result/result.dart';
import 'package:store_app/core/services/client.dart';
import 'package:store_app/data/models/cart/cart_item_model.dart';

class CartRepository {
  final ApiClient _client;

  CartRepository({required ApiClient client}) : _client = client;

  Future<Result<CartResponse>> getCartItem() async {
    final result = await _client.get('/cart-items');
    return result.fold(
      onError: (error) {
        print(
          'API Error in getCartItem: $error, Response: ${error is DioException ? error.response?.data : null}',
        );
        return Result.error(error);
      },
      onSuccess: (data) {
        try {
          print('Raw JSON: $data');
          return Result.success(CartResponse.fromJson(data));
        } catch (e) {
          print('Parsing Error in getCartItem: $e');
          return Result.error(Exception('Failed to parse cart: $e'));
        }
      },
    );
  }

  Future<Result<void>> addCartItem(int productId, int sizeId) async {
    final result = await _client.post(
      '/cart-items',
      data: {"productId": productId, "sizeId": sizeId},
    );
    return result.fold(
      onError: (error) {
        print(
          'API Error in addCartItem: $error, Response: ${error is DioException ? error.response?.data : null}',
        );
        return Result.error(error);
      },
      onSuccess: (_) {
        print('addCartItem success');
        return Result.success(null);
      },
    );
  }

  Future<Result<void>> deleteCartItem(int id) async {
    print('Sending DELETE /cart-items/$id');
    final result = await _client.delete('/cart-items/$id');
    return result.fold(
      onError: (error) {
        print(
          'API Error in deleteCartItem: $error, Response: ${error is DioException ? error.response?.data : null}',
        );
        return Result.error(error);
      },
      onSuccess: (_) {
        print('deleteCartItem success');
        return Result.success(null);
      },
    );
  }

  Future<Result<void>> clearCart() async {
    print('Sending DELETE /cart-items');
    final result = await _client.delete('/cart-items');
    return result.fold(
      onError: (error) {
        print(
          'API Error in clearCart: $error, Response: ${error is DioException ? error.response?.data : null}',
        );
        return Result.error(error);
      },
      onSuccess: (_) {
        print('clearCart success');
        return Result.success(null);
      },
    );
  }
}
