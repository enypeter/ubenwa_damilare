import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ubenwa_damilare/services/new_born_services.dart';

import '../model/new_born_model.dart';

class NewBornController extends GetxController {
  final _storage = const FlutterSecureStorage();
  final service = FlutterBackgroundService();
  var isLoading = true.obs;
  var isEnableBackground = false.obs;
  NewBornModel? newBornData;
  Rx<List<Datum>> newBornList = Rx<List<Datum>>([]);

  @override
  void onInit() {
    getNewBorn();
    getBackgroundState();
    super.onInit();
  }

  getBackgroundState() async {
    var backgroundState = await _storage.read(key: "enableBackground");
    isEnableBackground.value = backgroundState == 'true';
  }

  toggleBackgroundServices(value) async {
   isEnableBackground.value = value;
    await _storage.write(
        key: "enableBackground", value: '${isEnableBackground.value}');
    var isRunning = await service.isRunning();
    if (isEnableBackground.value && !isRunning) {
      service.startService();
    } else {
      service.invoke("stopService");
    }
    update();
  }

  getNewBorn() async {
    try {
      isLoading(true);
      var response = await NewBornServices.getNewBorn();
      newBornData = NewBornModel.fromJson(response);
      if (newBornData != null) {
        newBornList.value = newBornData!.data;
      }
    } finally {
      isLoading(false);
    }
  }

}
