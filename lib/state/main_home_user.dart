import 'package:flutter/material.dart';
import 'package:monitorproduct/widget/widget_signout.dart';
import 'package:monitorproduct/widget/widget_text.dart';

class MainHomeUser extends StatelessWidget {
  const MainHomeUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(data: 'User'),
      ),
      floatingActionButton: WidgetSignOut(),
    );
  }
}
