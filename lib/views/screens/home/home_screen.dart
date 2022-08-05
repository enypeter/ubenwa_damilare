import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ubenwa_damilare/controllers/new_born_controller.dart';
import 'package:ubenwa_damilare/core/app_colors.dart';
import 'package:ubenwa_damilare/core/consts.dart';

import '../../../controllers/user_controller.dart';
import 'new_born_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  UserController userController = Get.find();
  NewBornController babyController = Get.put(NewBornController());
  String name = '';
  String token = '';
  static const backgroundService = MethodChannel('com.ubenwa/damilare');

  Future toggleBackgroundService()async{
    var arguments = {'token':token};
    await backgroundService.invokeMethod('enableBackgroundService',arguments);
  }

  @override
  Widget build(BuildContext context) {
    name = userController.getUser()!.firstName;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(BODY_PADDING, 15, BODY_PADDING, 0),
          child: RefreshIndicator(
            onRefresh: () => babyController.getNewBorn(),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
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
                          '${babyController.isEnableBackground.value ? 'Disable' : 'Enable'} Background Service',
                          style: TextStyle(fontSize: 13, color: AppColors.GREY),
                        )),
                        Obx(
                          () => Switch.adaptive(
                              activeColor: AppColors.PRIMARY,
                              value: babyController.isEnableBackground.value,
                              onChanged: (value) async {
                                babyController.toggleBackgroundServices(value);
                              }),
                        )
                        // ),
                      ],
                    ),
                    Flexible(
                      child: Obx(() {
                        if (babyController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (babyController.newBornList.value.isEmpty) {
                          return const Center(
                            child: Text(
                              'You do not have any baby yet,\nenable service to create one',
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          return RefreshIndicator(
                            onRefresh: () => babyController.getNewBorn(),
                            color: AppColors.PRIMARY,
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (c, i) => NewBornCard(
                                    data: babyController.newBornList.value[i]),
                                separatorBuilder: (c, i) => smallVerticalSpace(),
                                itemCount: babyController.newBornList.value.length),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
