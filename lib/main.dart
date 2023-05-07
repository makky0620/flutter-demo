import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_template/view/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: HomePage())));
}
