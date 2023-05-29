import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/sign_up1.dart';
import 'package:todo/screens/signup.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/app_colors.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPass = true;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage(
                'assets/images/sign.png',
              ),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Text('To Do App',style: Theme.of(context).textTheme.bodyLarge,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value) {
                            bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!);
                            if (value.isEmpty) {
                              return 'Please Enter mail';
                            } else if (!emailValid) {
                              return "Please, Enter valid Email";
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                            label: const Text("Email"),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: AppColor.lightColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: AppColor.lightColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            suffixIcon: const Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            bool passValid = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(value!);
                            if (value.isEmpty) {
                              return 'Please, Enter password';
                            } else if (value.length < 6) {
                              return "Please, Enter at least 6 characters";
                            }
                            return null;
                          },
                          controller: passController,
                          obscureText: showPass,
                          decoration: InputDecoration(
                            label: const Text("Password"),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.remove_red_eye),
                              onPressed: () {
                                showPass = !showPass;
                                setState(() {});
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: AppColor.lightColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: AppColor.lightColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                FireBaseFunctions.login(
                                    emailController.text, passController.text,
                                        (value) {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        title: "Error",
                                        desc:
                                        "The email address or password you entered is invalid",
                                        dialogBorderRadius:
                                        BorderRadius.circular(20),
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {},
                                      ).show();
                                      setState(() {});
                                    }, () {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    title: "Successful",
                                    desc: "Login Successful",
                                    dialogBorderRadius:
                                    BorderRadius.circular(20),
                                 dismissOnTouchOutside: false,
                                    btnOkOnPress: () {},
                                  ).show().then((value) {
                                    pro.initUser();
                                    Navigator.pushReplacementNamed(
                                        context, HomeLayout.routeName);
                                  },);
                                });
                              }
                            },
                            child: const Text('Login')),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Don't have an account",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, CreateAccount1.routeName);
                          },
                          child: const Text('Create Account'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
