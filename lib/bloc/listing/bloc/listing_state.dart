part of 'listing_bloc.dart';

enum ListingScreenState { init, loading, loaded, error }

class ListingState extends Equatable {
  final String type;
  final int page;
  final List<Restaurant> result;
  final bool hasReachedMax;
  final ListingScreenState state;

  @override
  const ListingState({
    required this.type,
    this.page = 0,
    this.result = const [],
    this.hasReachedMax = false,
    this.state = ListingScreenState.init,
  });
  ListingState copyWith({
    int? page,
    List<Restaurant>? result,
    bool? hasReachedMax,
    ListingScreenState? state,
  }) {
    return ListingState(
      type: type,
      page: page ?? this.page,
      result: result ?? this.result,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      state: state ?? this.state,
    );
  }

  List<Object> get props => [page, result, hasReachedMax, state];
}
