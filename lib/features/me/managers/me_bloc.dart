import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/data/models/me/me_model.dart';
import '../../../data/repositories/me/me_repository.dart';
import 'me_event.dart';
import 'me_state.dart';

class MeBloc extends Bloc<MeEvent, MeState> {
  final MyInfoRepository repository;

  MeBloc({required this.repository}) : super(MeInitial()) {
    on<LoadMyInfo>(_onLoadMyInfo);
    on<UpdateMyInfo>(_onUpdateMyInfo);
  }

  Future<void> _onLoadMyInfo(LoadMyInfo event, Emitter<MeState> emit) async {
    emit(MeLoading());
    final result = await repository.getMyInfo();
    result.fold(
      onSuccess: (me) => emit(MeLoaded(me)),
      onError: (err) => emit(MeError(err.toString())),
    );
  }


  Future<void> _onUpdateMyInfo(UpdateMyInfo event, Emitter<MeState> emit) async {
    final me = MeModel(
      id: 1,
      fullName: event.fullName,
      email: event.email,
      phoneNumber: int.tryParse(event.phoneNumber) ?? 0,
      gender: event.gender,
      birthDate: event.birthDate,
    );
    emit(MeLoaded(me));
  }
}
