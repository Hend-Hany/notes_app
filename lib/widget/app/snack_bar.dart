import 'package:flutter/material.dart';
import 'package:note_app/core/route_utils/route_utils.dart';

void showSnackBar(
  String message, {
  bool showSnackBar = false,
  bool error = false,
}) {
  ScaffoldMessenger.of(RouteUtils.context).hideCurrentSnackBar();
}
