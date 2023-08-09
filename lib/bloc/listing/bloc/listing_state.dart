part of 'listing_bloc.dart';

enum ListingStateEnum {
  init,
  loading,
  loaded,
  error,
}

class ListingState extends Equatable {
  final ListingStateEnum state;
  final List<CategoriesRestaurants> categories;

  const ListingState({
    this.state = ListingStateEnum.init,
    this.categories = const [],
  });

  ListingState copyWith({
    ListingStateEnum? state,
    List<CategoriesRestaurants>? categories,
    List<String>? restaurantNames,
  }) {
    return ListingState(
      state: state ?? this.state,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props => [
        state,
        categories,
      ];
}
