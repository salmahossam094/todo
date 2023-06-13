import 'package:flutter/material.dart';
import 'package:todo/screens/signup.dart';
import 'package:todo/shared/styles/app_colors.dart';

class CreateAccount1 extends StatefulWidget {
  const CreateAccount1({Key? key}) : super(key: key);
  static const String routeName = 'signup1';

  @override
  State<CreateAccount1> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount1> {
  var ageController = TextEditingController();
  var nameController = TextEditingController();
  bool showPass = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Name",
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter name';
                        }
                        return null;
                      },
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        label: const Text("name"),
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
                        suffixIcon: const Icon(Icons.drive_file_rename_outline),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Age",
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter age';
                        }
                        return null;
                      },
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text("Age"),
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
                      height: 6,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pushNamed(
                                context, CreateAccount.routeName,
                                arguments: [nameController, ageController]);
                          }
                        },
                        child: const Text('Next')),
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
                                  context, CreateAccount.routeName);
                            },
                            child: const Text('Login'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
