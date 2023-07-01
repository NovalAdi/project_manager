import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/cubit/home/home_cubit.dart';
import 'package:project_manager/cubit/task/task_cubit.dart';

import '../models/task.dart';
import '../ui/widget/custom_button.dart';

class Utils {
  static Future<void> dialog(
      BuildContext context, Future<void> Function() process,
      [bool mounted = true]) async {
    // show the loading dialog
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    // await Future.delayed(const Duration(seconds: 3));
    // final datas = await ProductService.getProducts();
    // if (datas != null) {
    //   for (final element in datas) {
    //     log(element.toJson().toString());
    //   }
    // } else {
    //   log('Product NULL');
    // }
    await process();

    // Close the dialog programmatically
    // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  static void resubmitDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Do you want to resubmit this task',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    CustomButton(
                      text: 'Yes',
                      textColor: Color(0xff27DD44),
                      backgroundColor: Color(0xff92FFA3),
                      onTap: () {
                        context.read<TaskCubit>().setStatus(id, status: 'done');
                        context.read<TaskCubit>().init();
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 15),
                    CustomButton(
                      text: 'No',
                      textColor: Color(0xFFDD2727),
                      backgroundColor: Color(0xFFFF9292),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
