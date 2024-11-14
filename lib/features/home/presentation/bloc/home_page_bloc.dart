import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(const HomePageInitial()) {
    on<HomePageDotsChange>(_changeHomePageDots);
  }

  void _changeHomePageDots(
      HomePageDotsChange event, Emitter<HomePageState> emit) {
    emit(HomePageInitial(index: event.index));
  }
}
