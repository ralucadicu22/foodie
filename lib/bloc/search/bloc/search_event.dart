part of 'search_bloc.dart';

class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchText extends SearchEvent {
  final String searchList;
  SearchText(this.searchList);
  List<Object> get props => [searchList];
}
