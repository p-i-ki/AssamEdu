part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {
  const HomePageState();
}

final class HomePageInitial extends HomePageState {
  final int index;

  const HomePageInitial({
    this.index = 0,
  });

  HomePageInitial copyWith({
    int? index,
  }) {
    return HomePageInitial(
      index: index ?? this.index,
    );
  }
}
