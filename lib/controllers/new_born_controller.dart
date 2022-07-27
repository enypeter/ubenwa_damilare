import 'package:get/get.dart';
import 'package:ubenwa_damilare/services/new_born_services.dart';

import '../model/new_born_model.dart';

class NewBornController extends GetxController {
  // List<NewBornModel>? newBornList;
 var newBornList;

  getNewBorn(token) {
    if (newBornList == null || newBornList!.isEmpty) {
      return setNewBorn(token);
    } else {
      return newBornList;
    }
  }

  setNewBorn(token) async {
    var response = await NewBornServices.getNewBorn(token);
    print(response);
    if (response is String) {
      return newBornList = null;
    } else {
      newBornList =response['data'];

      return newBornList;
    }
  }
}
