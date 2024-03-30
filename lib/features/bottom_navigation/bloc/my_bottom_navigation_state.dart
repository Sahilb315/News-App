part of 'my_bottom_navigation_bloc.dart';

@immutable
sealed class MyBottomNavigationState {
  final int index;

  const MyBottomNavigationState({required this.index});
}

final class MyBottomNavigationInitialState extends MyBottomNavigationState {
  const MyBottomNavigationInitialState({required super.index});
}
