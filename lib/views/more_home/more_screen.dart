import 'package:cowlar_design_task/config/colors.dart';
import 'package:cowlar_design_task/config/helper_function.dart';
import 'package:cowlar_design_task/views/widgets/custom_app_bar.dart';
import 'package:cowlar_design_task/views/widgets/widget_function.dart';
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/no_movie.png",
                height: 100,
              ),
              addVerticalSpace(10),
              Text(
                "This is No Movie yet!",
                style: createCustomTextStyle(fontSize: 18),
              ),
              addVerticalSpace(10),
              Text(
                "Find your movie by Type title, categories, years, etc ",
                style: createCustomTextStyle(fontSize: 16, color: lightPrimary),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
