import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/cubit/notif/notif_cubit.dart';

import '../pages/notif_page.dart';

class NotifButtonWidget extends StatelessWidget {
  const NotifButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotifCubit, NotifState>(
      builder: (context, state) {
        if (state.listNotif == null || state.listNotif!.isEmpty) {
          return Container(
            height: 40,
            width: 40,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotifPage(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.notifications_none_outlined,
                  size: 30,
                ),
              ),
            ),
          );
        }

        return Container(
          height: 40,
          width: 40,
          child: Stack(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotifPage(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.notifications_none_outlined,
                    size: 30,
                  ),
                ),
              ),
              Container(
                height: 17,
                width: 17,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.red),
                child: Center(
                  child: Text(
                    state.listNotif!.length.toString(),
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 10
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
