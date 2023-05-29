import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/cubit/participant/participant_cubit.dart';

class ParticipantWidget extends StatelessWidget {
  const ParticipantWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipantCubit, ParticipantState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state.participant == null) {
          return const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Center(
              child: Text("This project doesn't have any projects"),
            ),
          );
        }
        return Container(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.participant!.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(width: 10);
              } else if (index == state.participant!.length + 1) {
                return Container(width: 24);
              } else {
                final user = state.participant![index - 1];
                final fullName = user.username!;
                final name =
                    fullName.split(" ")[0].substring(0, 1).toUpperCase() +
                        fullName.split(" ")[0].substring(1);
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            user.image!,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(name),
                      ],
                    ),
                  ),
                );
              }
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 15);
            },
          ),
        );
      },
    );
  }
}
