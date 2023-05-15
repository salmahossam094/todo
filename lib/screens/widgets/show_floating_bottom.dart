import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/shared/styles/app_colors.dart';

class ShowFloatingBottom extends StatefulWidget {
  const ShowFloatingBottom({Key? key}) : super(key: key);

  @override
  State<ShowFloatingBottom> createState() => _ShowFloatingBottomState();
}

class _ShowFloatingBottomState extends State<ShowFloatingBottom> {
  var formKey = GlobalKey<FormState>();
  String date = "12/12/2012";

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.addNew,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: pro.theme == ThemeMode.light
                        ? Colors.black
                        : Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return AppLocalizations.of(context)!.error1;
                  } else if (value.length < 10) {
                    return AppLocalizations.of(context)!.error2;
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: Text(AppLocalizations.of(context)!.taskDescrip),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.error3;
                  }
                },
                textInputAction: TextInputAction.done,
                maxLines: 3,
                decoration: InputDecoration(
                  label: Text(AppLocalizations.of(context)!.taskDescrip),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  AppLocalizations.of(context)!.selectDate,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: pro.theme == ThemeMode.light
                          ? Colors.black
                          : Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  chooseDate();
                },
                child: Text(
                  date,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: pro.theme == ThemeMode.light
                          ? AppColor.lightColor
                          : Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
                child: Text(AppLocalizations.of(context)!.addTask),
              ),
            ],
          ),
        ),
      ),
    );
  }

  chooseDate() async {
    DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365 * 2)));
    if (selected != null) {
      date = selected.toString().substring(0, 10);
    }
    setState(() {});
  }
}
