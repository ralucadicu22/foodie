part of 'listing_bloc.dart';

abstract class ListingState extends Equatable {
  const ListingState();

  @override
  List<Object> get props => [];
}

class ListingInitialState extends ListingState {}

class ListingLoadingState extends ListingState {}

class ListingLoadedState extends ListingState {
  final List<CategoriesRestaurants> categories;

  const ListingLoadedState({
    required this.categories,
  });

  @override
  List<Object> get props => [categories];
}

class ListingErrorState extends ListingState {
  final String errorMessage;

  const ListingErrorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
