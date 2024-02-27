part of 'home_layout_cubit.dart';

sealed class HomeLayoutState extends Equatable {
  const HomeLayoutState();

  @override
  List<Object> get props => [];
}

final class HomeLayoutInitial extends HomeLayoutState {}

class ChangeLayoutScreenIndexInitialLayoutState extends HomeLayoutState {}

class ChangeLayoutScreenIndexLayoutState extends HomeLayoutState {}
