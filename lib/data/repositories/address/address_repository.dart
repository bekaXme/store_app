import 'package:store_app/core/services/client.dart';
import 'package:store_app/data/models/address/adres_model.dart';
import '../../../core/result/result.dart';

class AddressRepo {
  final ApiClient _client;

  AddressRepo({required ApiClient client}) : _client = client;

  Future<Result<List<AddressModel>>> getAddresses() async {
    final result = await _client.get('/addresses/list');

    return result.fold(
      onError: (error) {
        print('API Error: $error');
        return Result.error(error);
      },
      onSuccess: (data) {
        try {
          print('Raw JSON: $data');
          final List<AddressModel> addresses = (data as List)
              .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return Result.success(addresses);
        } catch (e) {
          print('Parsing Error: $e');
          return Result.error(Exception(e));
        }
      },
    );
  }

  Future<Result<AddressModel>> postAddress(AddressModel address) async {
    final result = await _client.post(
      '/addresses/create',
      data: address.toJson(),
    );

    return result.fold(
      onError: (error) {
        print('API Error while posting address: $error');
        return Result.error(error);
      },
      onSuccess: (data) {
        try {
          print('Response JSON: $data');
          return Result.success(AddressModel.fromJson(data));
        } catch (e) {
          print('Parsing Error: $e');
          return Result.error(Exception(e));
        }
      },
    );
  }
}
