import 'package:flutter/material.dart';

textScale(context, child) {
  return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: child);
}
