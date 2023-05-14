import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/shared/styles/app_colors.dart';

class CustomDropDownTheme extends StatefulWidget {
  @override
  State<CustomDropDownTheme> createState() => _CustomDropDownThemeState();
}

class _CustomDropDownThemeState extends State<CustomDropDownTheme> {
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(bottom: 4, top: 4, left: 10, right: 10),
      decoration: BoxDecoration(border: Border.all(color: AppColor.lightColor)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          iconSize: 30,
          value: selectedValue,
          iconEnabledColor: AppColor.lightColor,
          isExpanded: true,
          items: [
            DropdownMenuItem(
              child: Text(
                AppLocalizations.of(context)!.light,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: pro.theme == ThemeMode.light
                        ? AppColor.lightColor
                        : Colors.white),
              ),
              value: 1,
              onTap: () {
                pro.changeTheme(ThemeMode.light);
              },
            ),
            DropdownMenuItem(
              child: Text(
                AppLocalizations.of(context)!.dark,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: pro.theme == ThemeMode.dark
                        ? AppColor.darkColor
                        : Colors.black),
              ),
              value: 2,
              onTap: () {
                pro.changeTheme(ThemeMode.dark);
              },
            ),
          ],
          onChanged: (value) {
            selectedValue = value!;
            setState(() {});
          },
        ),
      ),
    );
  }
}
