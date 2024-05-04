import 'package:cowlar_design_task/models/get_movie_trailer_model.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GetMovieTrailerState {}

class GetMovieTrailerInitialState extends GetMovieTrailerState {}

class GetMovieTrailerError extends GetMovieTrailerState {
  final String errorMessage;

  GetMovieTrailerError({
    required this.errorMessage,
  });
}

class GetMovieTrailerLoading extends GetMovieTrailerState {}

class GetMovieTrailerLoaded extends GetMovieTrailerState {
  final MovieTrailerModel movieTrailerModel;

  GetMovieTrailerLoaded({required this.movieTrailerModel});
}
