import 'package:store_app/core/services/client.dart';
import 'package:store_app/core/result/result.dart';

import '../../models/address/adres_model.dart';

class AddressRepo {
  final ApiClient _client;

  AddressRepo({required ApiClient client}) : _client = client;

  Future<Result<List<AddressModel>>> getAddresses() async {
    final result = await _client.get<List<dynamic>>('/addresses');

    return result.fold(
      onError: (error) {
        print('API Error (getAddresses): $error');
        return Result.error(error);
      },
      onSuccess: (data) {
        try {
          print('Raw JSON (getAddresses): $data');
          final List<AddressModel> addresses = (data as List)
              .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return Result.success(addresses);
        } catch (e, st) {
          print('Parsing Error (getAddresses): $e\n$st');
          return Result.error(Exception('Failed to parse addresses: $e'));
        }
      },
    );
  }

  Future<Result<AddressModel>> postAddress(AddressModel address) async {
    final result = await _client.post<Map<String, dynamic>>(
      '/addresses',
      data: address.toJson(),
    );

    return result.fold(
      onError: (error) {
        print('API Error (postAddress): $error');
        return Result.error(error);
      },
      onSuccess: (data) {
        try {
          print('Response JSON (postAddress): $data');
          return Result.success(AddressModel.fromJson(data));
        } catch (e, st) {
          print('Parsing Error (postAddress): $e\n$st');
          return Result.error(Exception('Failed to parse posted address: $e'));
        }
      },
    );
  }

  Future<Result<AddressModel>> updateAddress(AddressModel address) async {
    if (address.id == null) {
      return Result.error(Exception('Address id is null'));
    }

    final result = await _client.patch<Map<String, dynamic>>(
      '/addresses/${address.id}',
      data: address.toJson(),
    );

    return result.fold(
      onError: (error) {
        print('API Error (updateAddress): $error');
        return Result.error(error);
      },
      onSuccess: (data) {
        try {
          print('Response JSON (updateAddress): $data');
          return Result.success(AddressModel.fromJson(data));
        } catch (e, st) {
          print('Parsing Error (updateAddress): $e\n$st');
          return Result.error(Exception('Failed to parse updated address: $e'));
        }
      },
    );
  }

  Future<Result<void>> deleteAddress(int id) async {
    final result = await _client.delete<void>('/addresses/$id');

    return result.fold(
      onError: (error) {
        print('API Error (deleteAddress): $error');
        return Result.error(error);
      },
      onSuccess: (_) => Result.success(null),
    );
  }
}
