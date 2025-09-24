import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/search_items/managers/search_events.dart';
import 'search_state.dart';
import 'package:store_app/data/repositories/search/search_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository repository;

  SearchBloc({required this.repository}) : super(const SearchState()) {
    on<SearchTextChanged>(_onSearchTextChanged);
    on<ClearSearchHistory>(_onClearSearchHistory);
  }

  Future<void> _onSearchTextChanged(
      SearchTextChanged event, Emitter<SearchState> emit) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(state.copyWith(status: SearchStatus.initial));
      return;
    }

    emit(state.copyWith(status: SearchStatus.loading));

    final result = await repository.getSearchItems();
    result.fold(
      onSuccess: (data) {
        if (data.isEmpty) {
          emit(state.copyWith(status: SearchStatus.empty));
        } else {
          final updatedHistory = [...state.recentSearches, query];
          emit(state.copyWith(
            status: SearchStatus.success,
            results: data,
            recentSearches: updatedHistory,
          ));
        }
      },
      onError: (err) => emit(state.copyWith(
        status: SearchStatus.failure,
        error: err.toString(),
      )),
    );
  }

  void _onClearSearchHistory(
      ClearSearchHistory event, Emitter<SearchState> emit) {
    emit(state.copyWith(recentSearches: []));
  }
}
