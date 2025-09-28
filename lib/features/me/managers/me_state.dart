import 'package:equatable/equatable.dart';
import 'package:store_app/data/models/me/me_model.dart';

abstract class MeState extends Equatable {
  const MeState();

  @override
  List<Object?> get props => [];
}

class MeInitial extends MeState {}

class MeLoading extends MeState {}

class MeLoaded extends MeState {
  final MeModel me;

  const MeLoaded(this.me);

  @override
  List<Object?> get props => [me];
}

class MeError extends MeState {
  final String message;

  const MeError(this.message);

  @override
  List<Object?> get props => [message];
}
