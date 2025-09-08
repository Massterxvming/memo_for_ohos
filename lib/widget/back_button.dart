import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Get.back();
      },
      child: Icon(
        CupertinoIcons.back,
        color: Theme.of(context).appBarTheme.iconTheme?.color,
      ),
    );
  }
}
