import 'package:flutter/material.dart';
import 'dart:ui';

const primaryColor = const Color(0xff1e88e5);
const primaryLight = const Color(0xFFFF9F59);
const primaryDark = const Color(0xFFFF9F59);

const secondaryColor = const Color(0xff1e88e5);
const secondaryLight = const Color(0xFFFF9F59);
const secondaryDark = const Color(0xFFFF9F59);

const Color gradientStart = const Color(0xff1e88e5);
const Color gradientEnd = const Color(0xffb3e5fc);

const primaryGradient = const LinearGradient(
  colors: const [gradientStart, gradientEnd],
  stops: const [0.0, 1.0],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const primaryGradient1 = const LinearGradient(
  colors: const [gradientStart, gradientStart],
  stops: const [0.0, 1.0],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);


final Shader linearGradient = LinearGradient(
  colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

const chatBubbleGradient = const LinearGradient(
  colors: const [gradientStart, gradientEnd],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

const chatBubbleGradient2 = const LinearGradient(
  colors: const [Color(0xFFf4e3e3), Color(0xFFf4e3e3)],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);
