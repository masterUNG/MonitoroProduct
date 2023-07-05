import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:monitorproduct/model/type_user_model.dart';
import 'package:monitorproduct/utility/app_controller.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> readAllTypeUser() async {
    await FirebaseFirestore.instance.collection('typeuser').get().then((value) {
      for (var element in value.docs) {
        TypeUserModel typeUserModel = TypeUserModel.fromMap(element.data());
        appController.typeUserModels.add(typeUserModel);
      }
    });
  }
}
