import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_manager/cubit/project/project_cubit.dart';

class ListProjectPage extends StatelessWidget {
  const ListProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 24, left: 24, top: 50, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              BlocBuilder<ProjectCubit, ProjectState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Container(
                      margin: EdgeInsets.only(top: 50),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state.listProject == null) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text("You dont't have any project"),
                      ),
                    );
                  }
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.listProject!.length,
                    itemBuilder: (context, index) {
                      final project = state.listProject![index];
                      return GestureDetector(
                        onTap: () {
                          context.read<ProjectCubit>().updateMainProjectIndex(
                              index.toString(), project.id!);
                          Navigator.pop(context);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      project.name!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(project.desk!),
                                    const SizedBox(height: 18),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xff92E5FF),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        child: Text(
                                          '${project.dayLeft!} Days left',
                                          style: const TextStyle(
                                            color: Color(0xff2AAAD2),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                CircularPercentIndicator(
                                  radius: 30,
                                  lineWidth: 5,
                                  animation: true,
                                  percent: project.percentage! / 100,
                                  backgroundColor: Colors.grey.shade200,
                                  center: Text("${project.percentage!} %"),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Color(0xff58E76E),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
