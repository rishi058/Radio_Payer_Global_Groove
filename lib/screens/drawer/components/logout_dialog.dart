import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:global_groove/sizer/sizer.dart';
import '../../../color_scheme/color_scheme.dart';
import '../../../services/local_storage/get_storage_helper.dart';


Future<bool> showLogoutBox(BuildContext ctx) {
  Completer<bool> completer = Completer<bool>();

  showDialog(
    context: ctx,
    builder: (ctx) => AlertDialog(
      backgroundColor: LocalStorage().isDarkMode() ? const Color(0xFF1A1919) : CustomLightThemeColor.backgroundColor,
      title: const Text('Are you sure?'),
      content: const Text('Do you want to log out of this device ?'),
      actions: <Widget>[
        TextButton(
            onPressed: (){
              Navigator.of(ctx).pop(false);
            },
            child: const Text('No')),
        // SizedBox(width: .w),
        TextButton(
            onPressed: (){
              Navigator.of(ctx).pop(true);
            },
            child: const Text('Yes')),
      ],
    ),
  ).then((value) => completer.complete(value));

  return completer.future;
}