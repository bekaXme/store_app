import 'package:bloc/bloc.dart';
import 'package:store_app/data/models/address/adres_model.dart';
import 'package:store_app/data/repositories/address/address_repository.dart';
import 'address_event.dart';
import 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepo repository;

  AddressBloc({required this.repository}) : super(const AddressState.initial()) {
    on<LoadAddress>(_onLoadAddress);
    on<AddAddress>(_onAddAddress);
  }

  Future<void> _onLoadAddress(
      LoadAddress event,
      Emitter<AddressState> emit,
      ) async {
    emit(const AddressState.loading());
    final result = await repository.getAddresses();
    result.fold(
      onError: (error) => emit(AddressState.error(error.toString())),
      onSuccess: (addresses) => emit(AddressState.success(addresses)),
    );
  }

  // 🔹 Add a new address
  Future<void> _onAddAddress(
      AddAddress event,
      Emitter<AddressState> emit,
      ) async {
    emit(const AddressState.loading());
    final result = await repository.postAddress(event.address);
    result.fold(
      onError: (error) => emit(AddressState.error(error.toString())),
      onSuccess: (newAddress) => emit(AddressState.success(newAddress as List<AddressModel>)),
    );
  }
}
