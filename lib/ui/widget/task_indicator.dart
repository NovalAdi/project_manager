import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/ui/widget/custom_button.dart';
import 'package:project_manager/utils/utils.dart';

import '../../cubit/task/task_cubit.dart';
import '../../models/task.dart';

class TaskIndicator extends StatelessWidget {
  Task task;

  TaskIndicator({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (task.status == 'pending') {
          return CustomButton(
            text: 'Pending',
            textColor: Color(0xffCEBD24),
            backgroundColor: Color(0xffFBF454),
            onTap: () {
              Utils.resubmitDialog(context, task.id!);
            },
          );
        }
        return GestureDetector(
          onTap: () {
            context
                .read<TaskCubit>()
                .setStatus(task.id!, taskStatus: task.status!);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color:
                    task.done! ? const Color(0xff58E76E) : Colors.grey.shade400,
                width: 3,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: task.done!
                      ? const Color(0xff58E76E)
                      : Colors.grey.shade400,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
