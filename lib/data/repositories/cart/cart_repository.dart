import 'package:store_app/core/result/result.dart';
import 'package:store_app/core/services/client.dart';
import 'package:store_app/data/models/cart/cart_item_model.dart';
import 'package:store_app/data/models/cart/cart_item_model.dart';

class CartRepository {
  final ApiClient _client;

  CartRepository({required ApiClient client}) : _client = client;

  Future<Result<CartResponse>> getCartItem() async {
    final result = await _client.get('/my-cart/my-cart-items');
    return result.fold(
      onError: (error) {
        print('API Error: $error');
        return Result.error(error);
      },
      onSuccess: (data) {
        try {
          print('Raw JSON: $data');
          return Result.success(CartResponse.fromJson(data));
        } catch (e) {
          print('Parsing Error: $e');
          return Result.error(Exception(e));
        }
      },
    );
  }

  Future<Result<void>> addCartItem(int productId, int sizeId) async {
    final result = await _client.post(
      '/my-cart/add-item',
      data: {
        "productId": productId,
        "sizeId": sizeId, // 👈 always int, default 1
      },
    );

    return result.fold(
      onError: (error) {
        print('API Error in addCartItem: $error');
        return Result.error(error);
      },
      onSuccess: (_) {
        print('addCartItem success');
        return Result.success(null);
      },
    );
  }

  Future<Result<void>> deleteCartItem(int id) async {
    final result = await _client.delete('/my-cart/delete/$id');
    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (_) =>  Result.success(null),
    );
  }
}
