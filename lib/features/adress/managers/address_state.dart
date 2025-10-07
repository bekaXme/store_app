import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:store_app/data/models/address/adres_model.dart';
part 'address_state.freezed.dart';


@freezed
class AddressState with _$AddressState {
  const factory AddressState.initial() = _Initial;
  const factory AddressState.loading() = _Loading;
  const factory AddressState.success(List<AddressModel> addresses) = _Success;
  const factory AddressState.error(String message) = _Error;
}

