import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showAction;
  final bool isSearch;
  final bool showLeadingIcon;

  CustomAppBar({required this.title, this.showAction = false,this.isSearch= false,this.showLeadingIcon = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
      ),
      elevation: 0,
      leading: showLeadingIcon? IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ):null,
      actions: showAction
          ? [
        isSearch ?    IconButton(
          icon: const Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
          onPressed: () {
          },
        ):
        IconButton(
          icon: const Icon(
            Icons.bookmark,
            color: Colors.white,
          ),
          onPressed: () {
          },
        ),
      ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
