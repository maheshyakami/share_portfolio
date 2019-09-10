import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../portfolio_colors.dart';

Future portfolioFlushBar({
  @required BuildContext context,
  @required String message,
  IconData icon,
  Duration duration = const Duration(seconds: 3),
}) {
  return Flushbar(
    margin: EdgeInsets.only(
      bottom: 80.0,
      left: 20.0,
      right: 20.0,
    ),
    borderRadius: 30.0,
    messageText: Text(
      message,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontSize: 18.0,
      ),
      textAlign: TextAlign.center,
    ),
    icon: icon == null
        ? null
        : Icon(
            icon,
            color: Colors.white,
          ),
    duration: duration,
    backgroundGradient: LinearGradient(
      colors: [
        PortfolioColors.pink,
        PortfolioColors.pink[100],
      ],
    ),
  ).show(context);
}
