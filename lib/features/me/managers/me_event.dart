import 'package:equatable/equatable.dart';

abstract class MeEvent extends Equatable {
  const MeEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyInfo extends MeEvent {}

class UpdateMyInfo extends MeEvent {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String gender;
  final DateTime birthDate;

  const UpdateMyInfo({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.birthDate,
  });

  @override
  List<Object?> get props => [fullName, email, phoneNumber, gender, birthDate];
}
