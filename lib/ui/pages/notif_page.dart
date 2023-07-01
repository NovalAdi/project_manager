import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/cubit/notif/notif_cubit.dart';
import 'package:project_manager/ui/widget/custom_button.dart';
import 'package:project_manager/utils/utils.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({Key? key}) : super(key: key);

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
              BlocBuilder<NotifCubit, NotifState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Container(
                      margin: EdgeInsets.only(top: 50),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state.listNotif == null || state.listNotif!.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text("You don't have any notification"),
                      ),
                    );
                  }
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.listNotif!.length,
                    itemBuilder: (context, index) {
                      final notif = state.listNotif![index];

                      if (notif.type == 'task_return') {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notif.message!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                CustomButton(
                                  text: 'Pending',
                                  textColor: Color(0xffCEBD24),
                                  backgroundColor: Color(0xffFBF454),
                                  onTap: () {
                                    Utils.resubmitDialog(context, notif.idTask!);
                                  },
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        notif.from!.image!,
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(notif.from!.username!),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notif.message!,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  CustomButton(
                                    text: 'Accept',
                                    textColor: Color(0xff27DD44),
                                    backgroundColor: Color(0xff92FFA3),
                                    onTap: () {
                                      context.read<NotifCubit>().updateInvitation(
                                          notif.idInvitation!, 'accepted');
                                      context.read<NotifCubit>().init();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  SizedBox(width: 15),
                                  CustomButton(
                                    text: 'Deny',
                                    textColor: Color(0xFFDD2727),
                                    backgroundColor: Color(0xFFFF9292),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      notif.from!.image!,
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(notif.from!.username!),
                                ],
                              ),
                            ],
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
