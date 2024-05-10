import 'package:bloc/bloc.dart';
import 'package:cowlar_design_task/api_provider/api_provider.dart';
import 'package:cowlar_design_task/bloc/upcoming_movie_bloc/upcoming_movie_event.dart';
import 'package:cowlar_design_task/bloc/upcoming_movie_bloc/upcoming_movie_state.dart';
import 'package:cowlar_design_task/models/upcoming_movie_model.dart';

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

    on<GetSearchMovie>((event, emit) async {
      try {
        // Filter the upcoming movie model based on the search query
        final filteredResults = event.upcomingMovieModel.results?.where((movie) =>
        movie?.originalTitle?.toLowerCase().contains(event.query!.toLowerCase()) ?? false
        ).toList();

        // Emit the filtered results by updating the state
        if (state is UpcomingMovieLoaded) {
          emit(state.copyWith(newsearchMovies: filteredResults ));
        }
      } catch (e) {
        // Handle errors if needed
      }
    });



  }
}
