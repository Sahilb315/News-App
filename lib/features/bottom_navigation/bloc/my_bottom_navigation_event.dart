part of 'my_bottom_navigation_bloc.dart';

@immutable
sealed class MyBottomNavigationEvent {}

class NavigationTabChangeEvent extends MyBottomNavigationEvent {
  final int index;

  NavigationTabChangeEvent({required this.index});
}
