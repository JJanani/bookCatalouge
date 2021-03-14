import 'package:book_catalog/common_classes/locator.dart';
import 'package:flutter/material.dart';

import 'dashboard/ui/dashboard_view.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardView(),
    );
  }
}
