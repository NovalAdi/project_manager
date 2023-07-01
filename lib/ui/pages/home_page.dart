import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/cubit/home/home_cubit.dart';
import 'package:project_manager/cubit/notif/notif_cubit.dart';
import 'package:project_manager/cubit/project/project_cubit.dart';
import 'package:project_manager/cubit/task/task_cubit.dart';
import 'package:project_manager/ui/pages/list_project_page.dart';
import 'package:project_manager/ui/pages/profile_page.dart';
import 'package:project_manager/ui/widget/custom_button.dart';
import 'package:project_manager/ui/widget/notif_button_widget.dart';
import 'package:project_manager/ui/widget/project_widget.dart';
import 'package:project_manager/ui/widget/task_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future _onRefresh() async{
    log('on refresh jalan');
    context.read<ProjectCubit>().getListProject();
    context.read<HomeCubit>().init();
    context.read<TaskCubit>().init();
    context.read<NotifCubit>().init();

  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.user != null) {
              return ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 50,
                      right: 30,
                      left: 30,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    state.user!.image!,
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ProfilePage(),
                                  ),
                                );
                              },
                            ),
                            const NotifButtonWidget(),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.user!.username!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(state.user!.email!),
                              ],
                            ),
                            CustomButton(
                              text: 'Change Project',
                              textColor: Color(0xff2AAAD2),
                              backgroundColor: Color(0xff92E5FF),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) {
                                      context
                                          .read<ProjectCubit>()
                                          .getListProject();
                                      return const ListProjectPage();
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ProjectWidget(user: state.user!),
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text(
                      'Your Tasks',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TaskWidget(),
                ],
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
