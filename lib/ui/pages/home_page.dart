import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_manager/cubit/home/home_cubit.dart';
import 'package:project_manager/ui/widget/task_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.mainProject != null) {
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: state.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                        right: 30,
                        left: 30,
                        bottom: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.notifications_none_outlined,
                                size: 30,
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Text(
                            state.user!.username!,
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          const SizedBox(height: 6),
                          Text(state.user!.email!),
                          const SizedBox(height: 24),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            child: Padding(
                              padding: EdgeInsets.all(22),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 180,
                                            child: Text(
                                              state.mainProject!.name!,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFF9292),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 6),
                                              child: Text(
                                                '${state.mainProject!.dayLeft!} Days left',
                                                style: TextStyle(
                                                  color: Color(0xFFDD2727),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      CircularPercentIndicator(
                                        radius: 35,
                                        lineWidth: 7,
                                        animation: true,
                                        percent:
                                            state.mainProject!.percentage! /
                                                100,
                                        backgroundColor: Colors.white,
                                        center: Text(
                                            "${state.mainProject!.percentage!} %"),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        progressColor: Color(0xff58E76E),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Continue Progress',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blueAccent),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_outlined,
                                          color: Colors.blueAccent,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Your Tasks',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          TaskIndicator(state.user!.id!),
                        ],
                      ),
                    ),
                  ),
          );
        }
        return SizedBox();
      },
    );
  }
}
