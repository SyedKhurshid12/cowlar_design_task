import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePlayerScreen extends StatefulWidget {
  final String videoId;

  const MoviePlayerScreen({required this.videoId});

  @override
  _MoviePlayerScreenState createState() => _MoviePlayerScreenState();
}

class _MoviePlayerScreenState extends State<MoviePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,

      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )..addListener(_videoListener);
  }

  void _videoListener() {
    if (_controller.value.playerState == PlayerState.ended) {
      // The video has ended, close the player and return to the detail page
      _onOrientationChange(DeviceOrientation.portraitUp);

      Navigator.pop(context);
    }
  }
  void _onOrientationChange(DeviceOrientation orientation) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: _controller,

          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
