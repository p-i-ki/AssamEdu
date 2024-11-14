part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {
  const HomePageEvent();
}

class HomePageDotsChange extends HomePageEvent {
  final int index;
  const HomePageDotsChange({required this.index});
}
