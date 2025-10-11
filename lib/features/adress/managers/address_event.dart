import 'package:equatable/equatable.dart';

import '../../../data/models/address/adres_model.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class LoadAddress extends AddressEvent {}

class AddAddress extends AddressEvent {
  final AddressModel address;

  const AddAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class SetDefaultAddress extends AddressEvent {
  final AddressModel address;
  const SetDefaultAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class DeleteAddress extends AddressEvent {
  final int id;

  const DeleteAddress(this.id);

  @override
  List<Object?> get props => [id];
}