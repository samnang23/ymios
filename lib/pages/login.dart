import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../model/user_model.dart';
import '../repository/user_repo.dart' as userRepo;
import '../screen/main_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  Widget buildTextField({
    required Icon prefixIcon,
    required String labelText,
    required TextEditingController controller,
    required Function(String?)? validator,
    required inputType inputType,
  }) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF005C78).withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            prefixIconColor: Color(0xFF005C78),
            hintText: labelText,
            labelStyle: TextStyle(color: Color(0xFF005C78)),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(10),
            // ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  height: 150,
                  width: 150,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Yorkmars App',
                    style: TextStyle(
                      color: Color(0xFF005C78),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    color: Color(0xFF005C78),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Form(
                    key: loginFormKey,
                    child: Column(children: [
                      buildTextField(
                        controller: usernameController,
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Username',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Username';
                          }
                        },
                      ),
                      buildTextField(
                        controller: passwordController,
                        prefixIcon: Icon(Icons.lock),
                        
                        labelText: 'Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                        },
                      ),
                    ])),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color(0xFF005C78).withOpacity(0.4),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(0, 5),
                    )
                  ]),
                  child: ElevatedButton(
                    onPressed: () {
                      if (loginFormKey.currentState!.validate()) {
                        var user = UserModel(
                          username: usernameController.text,
                          password: passwordController.text,
                        );
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => Center(
                              child: LoadingAnimationWidget.inkDrop(
                            color: Colors.blue,
                            size: 50,
                          )),
                        );

                        userRepo.login(user).then((res) {
                          if (res.token != null) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreen()),
                                (Route<dynamic> route) => false);
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF005C78),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFFF3F7EC),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Don\'t have an account?',
                //       style: TextStyle(color: Color(0xFF005C78)),
                //     ),
                //     TextButton(
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => Register(),
                //             ));
                //       },
                //       child: Text(
                //         'Register',
                //         style: TextStyle(fontSize: 15),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
