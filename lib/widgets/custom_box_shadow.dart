import 'package:flutter/material.dart';

BoxShadow customBoxShadow(double x, double y, double blur) {
  return BoxShadow(
    offset: Offset(x, y),
    color: const Color(0xdd000000).withOpacity(0.5),
    blurRadius: blur,
  );
}
