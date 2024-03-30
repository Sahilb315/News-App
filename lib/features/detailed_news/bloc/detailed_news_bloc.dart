import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detailed_news_event.dart';
part 'detailed_news_state.dart';

class DetailedNewsBloc extends Bloc<DetailedNewsEvent, DetailedNewsState> {
  DetailedNewsBloc() : super(DetailedNewsInitial()) {
    on<DetailedNewsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
