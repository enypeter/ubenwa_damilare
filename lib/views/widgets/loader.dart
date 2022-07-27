import 'package:flutter/material.dart';
import 'package:ubenwa_damilare/core/app_colors.dart';

Future<void> showLoading(BuildContext context, {text}) async => showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        content: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 15, 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 15.0,
                                  top: 20),
                              child: Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.PRIMARY))),
                          Container(
                            height: 10,
                          ),
                          Text(text ?? 'Please wait...',
                              style:
                                  const TextStyle(color: Colors.black, fontSize: 15))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
