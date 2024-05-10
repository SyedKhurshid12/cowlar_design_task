
import 'package:cowlar_design_task/models/upcoming_movie_model.dart';
import 'package:equatable/equatable.dart';

abstract class UpcomingMovieEvent extends Equatable {
  const UpcomingMovieEvent();

  @override
  List<Object> get props => [];
}

class GetUpcomingMovieList extends UpcomingMovieEvent {}
class GetSearchMovie extends UpcomingMovieEvent {
  final UpcomingMovieModel upcomingMovieModel;

  final String query;
  GetSearchMovie(this.upcomingMovieModel,this.query);


}