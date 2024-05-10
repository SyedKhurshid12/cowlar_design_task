import 'package:cowlar_design_task/models/upcoming_movie_model.dart';

abstract class UpcomingMovieState {
  const UpcomingMovieState();

  UpcomingMovieState copyWith({
    UpcomingMovieModel? newupcomingMovieModel,
    List<UpcomingMovieModelResults?>? newsearchMovies,
  }) {
    return this; // Default implementation, returns the same instance
  }
}
class UpcomingMovieInitial extends UpcomingMovieState {}

class UpcomingMovieLoading extends UpcomingMovieState {}

class UpcomingMovieLoaded extends UpcomingMovieState {
  final UpcomingMovieModel? upcomingMovieModel;
  final List<UpcomingMovieModelResults?>? searchMovies;

  UpcomingMovieLoaded({this.upcomingMovieModel, this.searchMovies}) : super();

  @override
  UpcomingMovieLoaded copyWith({
    UpcomingMovieModel? newupcomingMovieModel,
    List<UpcomingMovieModelResults?>? newsearchMovies,
  }) {
    return UpcomingMovieLoaded(
      upcomingMovieModel: newupcomingMovieModel ?? upcomingMovieModel,
      searchMovies: newsearchMovies ?? searchMovies,
    );
  }

  @override
  List<Object?> get props => [upcomingMovieModel];
}
