import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ThemeData get themeData => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;

  Color get primaryColor => themeData.primaryColor;

  void showToast(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          maxLines: 2,
        ),
        action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              ScaffoldMessenger.of(this).clearSnackBars();
            }),
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showBanner(String message, {Color color = const Color(0xff000000)}) {
    ScaffoldMessenger.of(this).hideCurrentMaterialBanner();
    ScaffoldMessenger.of(this).showMaterialBanner(MaterialBanner(
      backgroundColor: color,
      contentTextStyle: primaryTextTheme.bodyText2,
      content: Text(
        message,
        maxLines: 2,
      ),
      actions: [
        Text(
          'Dismiss',
          style: primaryTextTheme.subtitle2?.copyWith(),
        )
      ],
    ));
  }
}
