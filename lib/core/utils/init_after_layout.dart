import 'package:flutter/material.dart';

void initAfterFirstLayout(Future<void> Function() execute) {
  WidgetsBinding.instance.endOfFrame.then((value) async => execute.call());
}
