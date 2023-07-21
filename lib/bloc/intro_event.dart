part of 'intro_bloc.dart';

abstract class IntroEvent extends Equatable {
  const IntroEvent();
}

class PageChangedEvent extends IntroEvent {
  final int newIndex;

  PageChangedEvent(this.newIndex);

  @override
  List<Object?> get props => [newIndex];
}
