import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/base.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/login/login_screen.dart';
import 'package:todo/screens/signup/connector.dart';
import 'package:todo/screens/signup/signup_viewmodel.dart';
import 'package:todo/shared/styles/app_colors.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);
  static const String routeName = 'signup';

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends BaseView<SignUpViewModel, CreateAccount>
    implements SignUpConnector {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var ageController = TextEditingController();
  var nameController = TextEditingController();
  bool showPass = true;
  bool isPass6 = false;
  bool isPassOneNum = false;
  bool isPassOneUC = false;
  bool isPassOneLC = false;
  bool isPassOneSC = false;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    var args = ModalRoute.of(context)!.settings.arguments
        as List<TextEditingController>;
    nameController = args[0];
    ageController = args[1];
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/sign.png',
                ),
                fit: BoxFit.cover),
          ),
          child: Scaffold(
            //   resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'To Do App',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .26,
                      ),
                      // const Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Text(
                      //     "Name",
                      //   ),
                      // ),
                      // TextFormField(
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please Enter name';
                      //     }
                      //     return null;
                      //   },
                      //   controller: nameController,
                      //   decoration: InputDecoration(
                      //     label: const Text("name"),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide:
                      //           const BorderSide(color: AppColor.lightColor),
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide:
                      //           const BorderSide(color: AppColor.lightColor),
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //     suffixIcon: const Icon(Icons.drive_file_rename_outline),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Email",
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        validator: (value) {
                          bool emailValid = RegExp(r"""
^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""")
                              .hasMatch(value!);
                          if (value.isEmpty) {
                            return 'Please Enter mail';
                          } else if (!emailValid) {
                            return "Please, Enter valid Email";
                          }
                          return null;
                        },
                        style: TextStyle(
                            color: pro.theme == ThemeMode.light
                                ? Colors.black
                                : Colors.black),
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
                        height: 8,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Password",
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) => onPassChanged(value),
                        validator: (value) {
                          bool passValid = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value!);
                          if (value.isEmpty) {
                            return 'Please, Enter password';
                          } else if (value.length < 6) {
                            return "Please, Enter at least 6 characters";
                          } else if (!passValid) {
                            return "Password not valid";
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
                        height: 4,
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(microseconds: 500),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: isPass6
                                      ? Colors.transparent
                                      : Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.check,
                              color: isPass6 ? Colors.green : Colors.white,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('contains at least 6',
                              style: Theme.of(context).textTheme.bodySmall)
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(microseconds: 500),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: isPassOneLC
                                      ? Colors.transparent
                                      : Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.check,
                              color: isPassOneLC ? Colors.green : Colors.white,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'At least one lower case English letter',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(microseconds: 500),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: isPassOneUC
                                      ? Colors.transparent
                                      : Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.check,
                              color: isPassOneUC ? Colors.green : Colors.white,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'At least one upper case English letter',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(microseconds: 500),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: isPassOneSC
                                      ? Colors.transparent
                                      : Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.check,
                              color: isPassOneSC ? Colors.green : Colors.white,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'At least one Special Character English letter',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(microseconds: 500),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: isPassOneNum
                                      ? Colors.transparent
                                      : Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.check,
                              color: isPassOneNum ? Colors.green : Colors.white,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'At least one digit',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // const Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Text(
                      //     "Age",
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // TextFormField(
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please Enter age';
                      //     }
                      //     return null;
                      //   },
                      //   controller: ageController,
                      //   keyboardType: TextInputType.number,
                      //   decoration: InputDecoration(
                      //     label: const Text("Age"),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide:
                      //           const BorderSide(color: AppColor.lightColor),
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide:
                      //           const BorderSide(color: AppColor.lightColor),
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 6,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              viewModel.signUP(
                                  emailController.text,
                                  passController.text,
                                  nameController.text,
                                  int.parse(ageController.text));
                              // FireBaseFunctions.createAccount(
                              //     nameController.text,
                              //     int.parse(ageController.text),
                              //     emailController.text,
                              //     passController.text, () {
                              //   AwesomeDialog(
                              //     context: context,
                              //     dialogType: DialogType.success,
                              //     title: "Successful",
                              //     desc: "Sign Up Successful",
                              //     dialogBorderRadius: BorderRadius.circular(20),
                              //     dismissOnTouchOutside: false,
                              //     btnOkOnPress: () {},
                              //   ).show().then((value) =>
                              //       Navigator.pushReplacementNamed(
                              //           context, LoginScreen.routeName));
                              // });
                            }
                          },
                          child: const Text('Sign Up')),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            "I've an account",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routeName);
                              },
                              child: const Text('Login'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  onPassChanged(String password) {
    var numericRegex = RegExp(r'[0-9]');
    var uCRegex = RegExp(r'[A-Z]');
    var lCRegex = RegExp(r'[a-z]');
    var sCRegex = RegExp(r'[!@#\$&*~]');
    uCRegex.hasMatch(password) ? isPassOneUC = true : false;
    lCRegex.hasMatch(password) ? isPassOneLC = true : false;
    sCRegex.hasMatch(password) ? isPassOneSC = true : false;
    numericRegex.hasMatch(password)
        ? isPassOneNum = true
        : isPassOneNum = false;
    if (password.length >= 6) {
      isPass6 = true;
    }
    setState(() {});
  }

  @override
  void goToHome() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      title: "Successful",
      desc: "Sign Up Successful",
      dialogBorderRadius: BorderRadius.circular(20),
      dismissOnTouchOutside: false,
      btnOkOnPress: () {},
    ).show().then((value) =>
        Navigator.pushReplacementNamed(context, LoginScreen.routeName));
  }

  @override
  SignUpViewModel initViewModel() {
    return SignUpViewModel();
  }
}
