import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchTextChanged extends SearchEvent {
  final String query;
  const SearchTextChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearchHistory extends SearchEvent {}
