import 'package:meta/meta.dart';

@immutable
abstract class GetMovieTrailerEvent {}

class HitGetMovieTrailer extends GetMovieTrailerEvent {
  final String movieId;
  HitGetMovieTrailer({
    required this.movieId,
  });
}
