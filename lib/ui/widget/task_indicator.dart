import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/cubit/home/home_cubit.dart';

class TaskIndicator extends StatefulWidget {
  String? id;
  const TaskIndicator({Key? key, required this.id}) : super(key: key);

  @override
  State<TaskIndicator> createState() => _TaskIndicatorState();
}

class _TaskIndicatorState extends State<TaskIndicator> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        context.read<HomeCubit>().getTask(widget.id!);
      },
      builder: (context, state) {
        return ListView.separated(
          itemCount: state.listTask.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final tasks = state.listTask[index];
            bool isDone = tasks.status == 'done';
            log(isDone.toString());
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: EdgeInsets.all(22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tasks.name!,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 200,
                          child: Text(tasks.desk!),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDone = !isDone;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: isDone
                                ? const Color(0xff58E76E)
                                : Colors.grey.shade400,
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
                              color: isDone
                                  ? const Color(0xff58E76E)
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // TaskIndicator(
                    //   status: tasks.status!,
                    //   id: tasks.id.toString(),
                    // ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 6);
          },
        );
      },
    );
  }
}
