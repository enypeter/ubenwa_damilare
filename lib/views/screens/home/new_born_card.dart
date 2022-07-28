import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/app_colors.dart';
import '../../../core/consts.dart';
import '../../../model/new_born_model.dart';

class NewBornCard extends StatelessWidget {
  const NewBornCard({required this.data, Key? key}) : super(key: key);
  final Datum? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 3),
      decoration: BoxDecoration(
          color: AppColors.PRIMARY.withOpacity(0.5),
          border: Border.all(
              color: AppColors.SHADOWCOLOR.withOpacity(0.1), width: 0.3)),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.WHITE,
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(data!.attributes.name,
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.TEXTCOLOR,
                      fontWeight: FontWeight.w700)),
              tinyVerticalSpace(),
              Text('Gender: ${data!.attributes.gender}',
                  style: TextStyle(fontSize: 13, color: AppColors.GREY)),
              tinyVerticalSpace(),
              Text(
                  'Date of Birth: ${DateFormat.yMMMMEEEEd().format(DateTime.parse(data!.attributes.createdAt))}',
                  style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
