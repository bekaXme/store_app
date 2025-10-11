import 'package:bloc/bloc.dart';
import 'package:store_app/data/repositories/address/address_repository.dart';
import '../../../data/models/address/adres_model.dart';
import 'address_event.dart';
import 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepo repository;

  AddressBloc({required this.repository}) : super(const AddressState.initial()) {
    on<LoadAddress>(_onLoadAddress);
    on<AddAddress>(_onAddAddress);
    on<SetDefaultAddress>(_onSetDefaultAddress);
    on<DeleteAddress>(_onDeleteAddress);
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

  Future<void> _onAddAddress(
      AddAddress event,
      Emitter<AddressState> emit,
      ) async {
    final currentState = state;
    emit(const AddressState.loading());

    final result = await repository.postAddress(event.address);
    result.fold(
      onError: (error) => emit(AddressState.error(error.toString())),
      onSuccess: (newAddress) {
        final updatedList = currentState.maybeWhen(
          success: (addresses) => List<AddressModel>.from(addresses),
          orElse: () => <AddressModel>[],
        );

        updatedList.add(newAddress);
        emit(AddressState.success(updatedList));
      },
    );
  }

  Future<void> _onSetDefaultAddress(
      SetDefaultAddress event,
      Emitter<AddressState> emit,
      ) async {
    final currentState = state;
    emit(const AddressState.loading());

    final updatedAddress = event.address.copyWith(isDefault: true);
    final result = await repository.updateAddress(updatedAddress);

    result.fold(
      onError: (error) => emit(AddressState.error(error.toString())),
      onSuccess: (updated) {
        currentState.maybeWhen(
          success: (addresses) {
            final updatedList = addresses.map((address) {
              return address.copyWith(
                isDefault: address.id == updated.id,
              );
            }).toList();
            emit(AddressState.success(updatedList));
          },
          orElse: () => emit(const AddressState.initial()),
        );
      },
    );
  }

  Future<void> _onDeleteAddress(
      DeleteAddress event,
      Emitter<AddressState> emit,
      ) async {
    final currentState = state;
    emit(const AddressState.loading());

    final result = await repository.deleteAddress(event.id);
    result.fold(
      onError: (error) => emit(AddressState.error(error.toString())),
      onSuccess: (_) {
        currentState.maybeWhen(
          success: (addresses) {
            final updatedList =
            addresses.where((address) => address.id != event.id).toList();
            emit(AddressState.success(updatedList));
          },
          orElse: () => emit(const AddressState.initial()),
        );
      },
    );
  }
}