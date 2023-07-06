import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitorproduct/utility/app_controller.dart';
import 'package:monitorproduct/utility/app_service.dart';
import 'package:monitorproduct/widget/widget_signout.dart';
import 'package:monitorproduct/widget/widget_text.dart';

class MainHomeUser extends StatefulWidget {
  const MainHomeUser({super.key});

  @override
  State<MainHomeUser> createState() => _MainHomeUserState();
}

class _MainHomeUserState extends State<MainHomeUser> {
  @override
  void initState() {
    super.initState();
    AppService().processFindPosition(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(data: 'User'),
      ),
      floatingActionButton: WidgetSignOut(),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('## positions ---> ${appController.positions.length}');
            return appController.positions.isEmpty
                ? const SizedBox()
                : WidgetText(data: 'data');
          }),
    );
  }
}
