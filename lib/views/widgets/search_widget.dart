import 'package:cowlar_design_task/config/colors.dart';
import 'package:flutter/material.dart';


class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Function()? onTap;
  final void Function(String?)? onChanged;

  CustomSearchBar({
    this.controller,
    required this.hintText,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      height: 40,
      child: TextField(
        keyboardType: TextInputType.text,
        readOnly: controller != null ? false : true,
        onTap: onTap,
        controller: controller,
        onChanged: onChanged,
        strutStyle: const StrutStyle(
          forceStrutHeight: true,
        ),
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontSize: 16.0, color: Colors.black87),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          suffixIcon: Icon(
            Icons.search,
            color: primaryColor,
          ),
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: primaryColor, fontSize: 14, fontWeight: FontWeight.w500),
          filled: true,
          fillColor: lightPrimary,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
      ),
    );
  }
}
