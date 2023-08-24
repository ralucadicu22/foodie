part of 'favorites_bloc.dart';

enum FavoritesScreenState { empty, loading, loaded, error }

class FavoritesState extends Equatable {
  final FavoritesScreenState state;
  final List<Restaurant> favorites;

  const FavoritesState({
    this.state = FavoritesScreenState.empty,
    this.favorites = const [],
  });
  FavoritesState copyWith(
          {FavoritesScreenState? state, List<Restaurant>? favorites}) =>
      FavoritesState(
        state: state ?? this.state,
        favorites: favorites ?? this.favorites,
      );

  @override
  List<Object> get props => [state, favorites];
}
