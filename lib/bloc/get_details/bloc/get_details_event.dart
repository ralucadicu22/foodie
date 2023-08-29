part of 'get_details_bloc.dart';

class GetDetailsEvent extends Equatable {
  const GetDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchDetails extends GetDetailsEvent {
  final String id;
  FetchDetails({required this.id});
  List<Object> get props => [id];
}

class ReadMoreReviews extends GetDetailsEvent {
  final Review review;
  ReadMoreReviews({required this.review});
  @override
  List<Object> get props => [review];
}
