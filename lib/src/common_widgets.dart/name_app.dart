import 'package:flutter/material.dart';
import 'package:rossoneri_store/src/constants/app_colors.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';

final nameApp = Padding(
  padding: const EdgeInsets.only(left: Sizes.p12),
  child: Align(
    alignment: Alignment.centerLeft,
    child: RichText(
        text: const TextSpan(children: <TextSpan>[
      TextSpan(
          text: 'Rosso',
          style: TextStyle(
              color: ColorApp.rosso,
              fontWeight: FontWeight.bold,
              fontSize: Sizes.p24)),
      TextSpan(
          text: 'neri',
          style: TextStyle(
              color: ColorApp.nero,
              fontWeight: FontWeight.bold,
              fontSize: Sizes.p24)),
      TextSpan(
          text: ' Store',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.grey,
              fontSize: Sizes.p24)),
    ])),
  ),
);
