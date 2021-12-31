import 'package:flutter/material.dart';
import 'package:untitled/screens/home_screen.dart';

Color getColors(BuildContext context, double percent) {
  if (percent >= 0.5) {
    return Theme.of(context).primaryColor;
  } else if (percent >= 0.25) {
    return Colors.orange;
  }
  return Colors.red;
}
