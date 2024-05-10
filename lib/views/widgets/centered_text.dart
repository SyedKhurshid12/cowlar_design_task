import 'package:cowlar_design_task/config/colors.dart';
import 'package:cowlar_design_task/config/helper_function.dart';
import 'package:cowlar_design_task/views/widgets/widget_function.dart';
import 'package:flutter/material.dart';

class CenteredContent extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;

  const CenteredContent({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imageAsset,
              height: 100,
            ),
            addVerticalSpace(10),
            Text(
              title,
              style: createCustomTextStyle(fontSize: 18),
            ),
            addVerticalSpace(10),
            Text(
              subtitle,
              style: createCustomTextStyle(fontSize: 16, color: lightPrimary),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
