import 'package:equatable/equatable.dart';
import 'package:store_app/data/models/address/adres_model.dart';

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
