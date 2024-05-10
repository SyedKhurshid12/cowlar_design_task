import 'package:cowlar_design_task/views/widgets/centered_text.dart';
import 'package:cowlar_design_task/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Watch list",
        showLeadingIcon: false,
      ),
      body: const CenteredContent(
        imageAsset: "assets/no_movie.png",
        title: "This is No Movie yet!",
        subtitle: "Find your movie by Type title, categories, years, etc",
      ),
    );
  }
}

