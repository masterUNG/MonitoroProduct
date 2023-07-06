import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:monitorproduct/utility/app_controller.dart';
import 'package:monitorproduct/utility/app_dialog.dart';
import 'package:monitorproduct/utility/app_service.dart';
import 'package:monitorproduct/widget/widget_button.dart';
import 'package:monitorproduct/widget/widget_signout.dart';
import 'package:monitorproduct/widget/widget_text.dart';
import 'package:monitorproduct/widget/widget_text_button.dart';

class MainHomeRider extends StatefulWidget {
  const MainHomeRider({super.key});

  @override
  State<MainHomeRider> createState() => _MainHomeRiderState();
}

class _MainHomeRiderState extends State<MainHomeRider> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().processFindPosition(context: context).then((value) {
      AppService().processStreamPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'Rider'),
        actions: [WidgetSignOut()],
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return SizedBox(
          width: boxConstraints.maxWidth,
          height: boxConstraints.maxHeight,
          child: Obx(() {
            return appController.positions.isEmpty
                ? const SizedBox()
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(appController.positions.last.latitude,
                          appController.positions.last.longitude),
                      zoom: 14,
                    ),
                    onMapCreated: (controller) {},
                    myLocationEnabled: true,
                  );
          }),
        );
      }),
    );
  }
}
