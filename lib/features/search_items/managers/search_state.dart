import 'package:equatable/equatable.dart';
import 'package:store_app/data/models/search/search_model.dart';

enum SearchStatus { initial, loading, success, empty, failure }

class SearchState extends Equatable {
  final SearchStatus status;
  final List<SearchModel> results;
  final List<String> recentSearches;
  final String error;

  const SearchState({
    this.status = SearchStatus.initial,
    this.results = const [],
    this.recentSearches = const [],
    this.error = '',
  });

  SearchState copyWith({
    SearchStatus? status,
    List<SearchModel>? results,
    List<String>? recentSearches,
    String? error,
  }) {
    return SearchState(
      status: status ?? this.status,
      results: results ?? this.results,
      recentSearches: recentSearches ?? this.recentSearches,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, results, recentSearches, error];
}
