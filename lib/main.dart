import 'package:cowlar_design_task/provider/movie_player_provider.dart';
import 'package:cowlar_design_task/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'config/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context) => MoviePlayerProvider(),

      child: MaterialApp(
        title: 'Cowlar Task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
            scaffoldBackgroundColor:primaryColor,
          textTheme: const TextTheme(
            titleSmall: TextStyle(fontFamily: "Roboto")
          ),



        ),
        home: const Splash(),
      ),
    );
  }
}
