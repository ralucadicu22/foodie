part of 'favorites_bloc.dart';

class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class AddToFavorites extends FavoritesEvent {
  final Restaurant restaurant;

  const AddToFavorites(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}

class RemoveFromFavorites extends FavoritesEvent {
  final Restaurant restaurant;

  const RemoveFromFavorites(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}
