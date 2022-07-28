import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ubenwa_damilare/controllers/new_born_controller.dart';
import 'package:ubenwa_damilare/core/app_colors.dart';
import 'package:ubenwa_damilare/core/consts.dart';

import '../../../controllers/user_controller.dart';
import 'new_born_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserController userController = Get.find();
  final _storage = const FlutterSecureStorage();
  NewBornController babyController = Get.put(NewBornController());
  String name = '';
  bool isEnableBackground = false;
  var newBabies;

  @override
  void initState() {
    name = userController.getUser()!.firstName;
    getNewBabies();
    super.initState();
  }

  getNewBabies() async {
    var data = await babyController.setNewBorn();
    newBabies = data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(BODY_PADDING, 15, BODY_PADDING, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Hi $name',
                style: TextStyle(
                    color: AppColors.TEXTCOLOR,
                    fontSize: 23,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    '${isEnableBackground ? 'Disable' : 'Enable'} Background Service',
                    style: TextStyle(fontSize: 13, color: AppColors.GREY),
                  )),
                  Switch.adaptive(
                      activeColor: AppColors.PRIMARY,
                      value: isEnableBackground,
                      onChanged: (value) async {
                        isEnableBackground = value;
                        await _storage.write(
                            key: "enableBackground",
                            value: '$isEnableBackground');
                        final service = FlutterBackgroundService();
                        var isRunning = await service.isRunning();
                        if (isEnableBackground && !isRunning) {
                          service.startService();
                        } else {
                          service.invoke("stopService");
                        }
                        setState(() {});
                      }),
                ],
              ),
              Expanded(
                child: newBabies == null
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : newBabies.isEmpty
                        ? const Center(
                            child: Text(
                              'You do not have any baby yet,\nenable service to create one',
                              textAlign: TextAlign.center,
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () => getNewBabies(),
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (c, i) => NewBornCard(newBabies[i]),
                                separatorBuilder: (c, i) => smallVerticalSpace(),
                                itemCount: newBabies.length),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
