import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/shared/styles/app_colors.dart';

class CustomDropDownLanguage extends StatefulWidget {
  @override
  State<CustomDropDownLanguage> createState() => _CustomDropDownLanguageState();
}

class _CustomDropDownLanguageState extends State<CustomDropDownLanguage> {
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
          value: selectedValue,
          isExpanded: true,
          iconSize: 30,
          iconEnabledColor: AppColor.lightColor,
          items: [
            DropdownMenuItem(
              value: 1,
              onTap: () {
                pro.changeLanguage('en');
              },
              child: Text(
                AppLocalizations.of(context)!.english,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: pro.theme == ThemeMode.light
                        ? pro.language == 'en'
                            ? AppColor.lightColor
                            : Colors.black
                        : pro.language == 'en'
                            ? AppColor.darkColor
                            : Colors.white),
              ),
            ),
            DropdownMenuItem(
              value: 2,
              onTap: () {
                pro.changeLanguage('ar');
              },
              child: Text(
                AppLocalizations.of(context)!.arabic,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: pro.theme == ThemeMode.light
                        ? pro.language == 'ar'
                            ? AppColor.lightColor
                            : Colors.black
                        : pro.language == 'ar'
                            ? AppColor.darkColor
                            : Colors.white),
              ),
            )
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
