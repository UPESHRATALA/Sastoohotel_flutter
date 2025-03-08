import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app.dart';
//sasto-hotel
void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
