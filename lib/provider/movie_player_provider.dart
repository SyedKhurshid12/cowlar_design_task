import 'package:cowlar_design_task/views/movie_home/movie_player_screen.dart';
import 'package:flutter/material.dart';

class MoviePlayerProvider with ChangeNotifier {
  void playMovieTrailer(BuildContext context, String videoId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoviePlayerScreen(videoId: videoId),
      ),
    );
  }
}