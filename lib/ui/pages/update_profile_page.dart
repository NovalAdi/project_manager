import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/cubit/home/home_cubit.dart';
import 'package:validators/validators.dart';

import '../../cubit/notif/notif_cubit.dart';
import '../../cubit/task/task_cubit.dart';
import '../../service/auth_service.dart';
import '../../utils/utils.dart';
import 'home_page.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            const EdgeInsets.only(right: 24, left: 24, top: 50, bottom: 24),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final formKey = GlobalKey<FormState>();
            final usernameController =
                TextEditingController(text: state.user!.username);
            final emailController =
                TextEditingController(text: state.user!.email);
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: usernameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return null;
                          } else if (!isEmail(value)) {
                            return 'Email is not valid';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formKey.currentState!.validate()) {
                          bool registerValid = false;

                          await Utils.dialog(context, () async {
                            final res = await AuthService.updateUser(
                              username: usernameController.text,
                              email: emailController.text,
                              id: state.user!.id.toString(),
                            );
                            setState(() {
                              registerValid = res;
                            });
                          });
                          if (!mounted) return;
                          if (registerValid) {
                            log('VALID');
                            context.read<HomeCubit>().init();
                            context.read<TaskCubit>().init();
                            context.read<NotifCubit>().init();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomePage(),
                              ),
                              (_) => false,
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) => const AlertDialog(
                                title: Text('Error'),
                                content: Text(
                                    'Update is not valid or a server error'),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
