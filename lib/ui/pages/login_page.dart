import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../service/auth_service.dart';
import '../../utils/utils.dart';
import 'chose_role_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
        const EdgeInsets.only(top: 50, right: 24, left: 24, bottom: 24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login into your account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text.rich(TextSpan(
                    children: <InlineSpan>[
                      const TextSpan(
                        text: 'Dont have an account ?  ',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      TextSpan(
                        text: 'Register',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChoseRolePage(),
                              ),
                            );
                          },
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
                  const SizedBox(height: 46),
                  TextFormField(
                    controller: _usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Usernmae can not be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Username / Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password can not be empty';
                      } else if (value.length < 8) {
                        return 'Password minimal 8 character';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
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
                    if (_formKey.currentState!.validate()) {
                      bool registerValid = false;

                      await Utils.dialog(context, () async {
                        final res = await AuthService.login(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        );
                        setState(() {
                          registerValid = res;
                        });
                      });

                      if (registerValid) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomePage(),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                            title: Text('Error'),
                            content:
                            Text('Register is not valid or a server error'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
