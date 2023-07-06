import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  var markers = <Marker>[];
  AppController controller = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().processFindPosition(context: context).then((value) {
      Marker userMarker = Marker(
          markerId: const MarkerId('user'),
          position: LatLng(controller.positions.last.latitude,
              controller.positions.last.longitude), infoWindow: const InfoWindow(title: 'คุณอยู่ที่นี่'),);
      markers.add(userMarker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(data: 'User'),
        actions: [WidgetSignOut()],
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GetX(
            init: AppController(),
            builder: (AppController appController) {
              print('## positions ---> ${appController.positions.length}');
              return appController.positions.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      width: boxConstraints.maxWidth,
                      height: boxConstraints.maxHeight,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(appController.positions.last.latitude,
                              appController.positions.last.longitude),
                          zoom: 16,
                        ),
                        onMapCreated: (controller) {},
                        markers: markers.toSet(),
                      ),
                    );
            });
      }),
    );
  }
}
