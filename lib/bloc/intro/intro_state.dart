part of 'intro_bloc.dart';

class IntroState extends Equatable {
  final int currentIndex;

  IntroState(this.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}
