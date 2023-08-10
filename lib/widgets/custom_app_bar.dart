import 'package:flutter/material.dart';

import '../configs/palette.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? elevation;

  const CustomAppBar({Key? key, this.title, this.elevation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: elevation ?? 1,
      title: Text(
        title ?? '',
        softWrap: true,
        textScaleFactor: 0.9,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Palette.kBackgroundColor,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
