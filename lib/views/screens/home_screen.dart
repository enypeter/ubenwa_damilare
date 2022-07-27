import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ubenwa_damilare/controllers/new_born_controller.dart';
import 'package:ubenwa_damilare/core/app_colors.dart';
import 'package:ubenwa_damilare/core/consts.dart';

import '../../controllers/user_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserController userController = Get.find();
  final _storage = const FlutterSecureStorage();
  NewBornController babyController = Get.put(NewBornController());
  String token = '';
  String name = '';
  bool isEnableBackground = false;
  var newBabies;

  @override
  void initState() {
    token = userController.getToken();
    name = userController.getUser()!.firstName;
    getNewBabies();
    super.initState();
  }

  getNewBabies() async {
    var data = await babyController.setNewBorn(token);
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
                            child:  Text(
                              'You do not have any baby yet,\nenable service to create one',
                              textAlign: TextAlign.center,
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () => getNewBabies(),
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (c, i) {
                                  var item = newBabies[i];
                                  return Container(
                                    color: AppColors.GREEN.withOpacity(0.5),
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.WHITE,
                                          borderRadius:
                                              const BorderRadius.horizontal(
                                                  left: Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 15, 20, 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              item['attributes']['name'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: AppColors.TEXTCOLOR,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            tinyVerticalSpace(),
                                            Text(
                                              'Gender: ${item['attributes']['gender']}',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors.GREY),
                                            ),
                                            tinyVerticalSpace(),
                                            Text(
                                              'Date of Birth: ${DateFormat.yMMMMEEEEd().format(DateTime.parse(item['attributes']['created_at']))}',
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (c, i) =>
                                    const SizedBox(height: 15),
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
