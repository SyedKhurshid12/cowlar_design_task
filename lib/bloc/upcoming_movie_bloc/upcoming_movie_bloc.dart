import 'package:bloc/bloc.dart';
import 'package:cowlar_design_task/api_provider/api_provider.dart';
import 'package:cowlar_design_task/bloc/upcoming_movie_bloc/upcoming_movie_event.dart';
import 'package:cowlar_design_task/bloc/upcoming_movie_bloc/upcoming_movie_state.dart';

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  UpcomingMovieBloc() : super(UpcomingMovieInitial()) {
    on<GetUpcomingMovieList>((event, emit) async {
      final ApiProvider apiProvider = ApiProvider();
      try {
        emit(UpcomingMovieLoading());
        final res = await apiProvider.fetchUpcomingMovie();

        emit(UpcomingMovieLoaded(upcomingMovieModel: res));
      } catch (e) {}
    });
  }
}
