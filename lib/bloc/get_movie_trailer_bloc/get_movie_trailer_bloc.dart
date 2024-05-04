import 'package:bloc/bloc.dart';
import 'package:cowlar_design_task/api_provider/api_provider.dart';
import 'package:cowlar_design_task/bloc/get_movie_trailer_bloc/get_movie_trailer_event.dart';
import 'package:cowlar_design_task/bloc/get_movie_trailer_bloc/get_movie_trailer_state.dart';

class GetMovieTrailerBloc extends Bloc<GetMovieTrailerEvent, GetMovieTrailerState> {
  GetMovieTrailerBloc() : super(GetMovieTrailerInitialState()) {
    on<HitGetMovieTrailer>((event, emit) async {
      final ApiProvider apiProvider = ApiProvider();
      try {
        emit(GetMovieTrailerLoading());
        final res = await apiProvider.fetchMovieTrailerById(event.movieId);

        emit(GetMovieTrailerLoaded(movieTrailerModel: res));
      } catch (e) {}
    });
  }
}
