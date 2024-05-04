import 'package:bloc/bloc.dart';
import 'package:cowlar_design_task/api_provider/api_provider.dart';
import 'package:cowlar_design_task/bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:cowlar_design_task/bloc/movie_detail_bloc/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitialState()) {
    on<HitMovieDetail>((event, emit) async {
      final ApiProvider apiProvider = ApiProvider();
      try {
        emit(MovieDetailLoading());
        final res = await apiProvider.fetchMovieDetailById(event.movieId);

        emit(MovieDetailLoaded(movieDetailModel: res));
      } catch (e) {}
    });
  }
}
