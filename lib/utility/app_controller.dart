import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:monitorproduct/model/type_user_model.dart';

class AppController extends GetxController{

  RxList<TypeUserModel> typeUserModels = <TypeUserModel>[].obs;
  RxList<String?> chooseTypeUsers = <String?>[null].obs;

  RxList<Position> positions = <Position>[].obs;
  
}