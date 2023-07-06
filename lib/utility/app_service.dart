import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:monitorproduct/model/type_user_model.dart';
import 'package:monitorproduct/utility/app_controller.dart';
import 'package:monitorproduct/utility/app_dialog.dart';
import 'package:monitorproduct/widget/widget_text_button.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> processFindPosition({required BuildContext context}) async {
    bool locationService = await Geolocator.isLocationServiceEnabled();
    LocationPermission locationPermission;

    if (locationService) {
      // Enable Service

      locationPermission = await Geolocator.checkPermission();

      print('## locationPermission ---> $locationPermission');

      if (locationPermission == LocationPermission.deniedForever) {
        //ไม่อนุญาติ
        dialogOpenPermission(context: context);
      } else {

        print('## locationPermission2 ---> $locationPermission');

        if (locationPermission == LocationPermission.denied) {
          //ไม่รู้

          print('## locationPermission3 ---> $locationPermission');

          locationPermission = await Geolocator.requestPermission();


          if ((locationPermission != LocationPermission.always) &&
              (locationPermission != LocationPermission.whileInUse)) {
            dialogOpenPermission(context: context);
          } else {
            //Away, TimeInUse
            Position position = await Geolocator.getCurrentPosition();
            appController.positions.add(position);
          }
        } else {
          //Away, TimeInUse
          Position position = await Geolocator.getCurrentPosition();
          appController.positions.add(position);
        }
      }
    } else {
      //Off Service
      AppDialog(context: context).normalDialog(
          title: 'Location Service Disable',
          showCancel: false,
          firstAction: WidgetTextButton(
            label: 'Open Service',
            pressFunc: () {
              Geolocator.openLocationSettings();
              exit(0);
            },
          ));
    }
  }

  void dialogOpenPermission({required BuildContext context}) {
    AppDialog(context: context).normalDialog(
        title: 'Please Open Permission',
        showCancel: false,
        firstAction: WidgetTextButton(
          label: 'Open Permission',
          pressFunc: () {
            Geolocator.openAppSettings();
            exit(0);
          },
        ));
  }

  Future<void> readAllTypeUser() async {
    await FirebaseFirestore.instance.collection('typeuser').get().then((value) {
      for (var element in value.docs) {
        TypeUserModel typeUserModel = TypeUserModel.fromMap(element.data());
        appController.typeUserModels.add(typeUserModel);
      }
    });
  }
}