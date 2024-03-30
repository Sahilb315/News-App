import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_bottom_navigation_event.dart';
part 'my_bottom_navigation_state.dart';

class MyBottomNavigationBloc
    extends Bloc<MyBottomNavigationEvent, MyBottomNavigationState> {
  MyBottomNavigationBloc()
      : super(const MyBottomNavigationInitialState(index: 0)) {
    on<MyBottomNavigationEvent>((event, emit) {
      if (event is NavigationTabChangeEvent) {
        emit(MyBottomNavigationInitialState(index: event.index));
      }
    });
  }
}
