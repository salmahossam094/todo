import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/shared/styles/app_colors.dart';

class ShowLanguageBottom extends StatelessWidget {
  const ShowLanguageBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                pro.changeLanguage('en');
              },
              child: Text(
                AppLocalizations.of(context)!.english,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 20,
                    color: pro.theme == ThemeMode.light
                        ? pro.language == "en"
                            ? AppColor.lightColor
                            : Colors.black
                        : pro.language == "en"
                            ? AppColor.darkColor
                            : Colors.white),
              )),
          SizedBox(
            height: 15,
          ),
          InkWell(
              onTap: () {
                pro.changeLanguage('ar');
              },
              child: Text(AppLocalizations.of(context)!.arabic,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      color: pro.theme == ThemeMode.light
                          ? pro.language == 'ar'
                              ? AppColor.lightColor
                              : Colors.black
                          : pro.language == 'ar'
                              ? AppColor.darkColor
                              : Colors.white))),
          // InkWell(
          //   onTap: () {
          //     pro.changeLanguage('d');
          //   },
          //   child: Text(
          //     AppLocalizations.of(context)!.arabic,
          //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          //         fontSize: 20,
          //         color: pro.theme == ThemeMode.light
          //             ? pro.language == "ar"
          //             ? AppColor.lightColor
          //             : Colors.black
          //             : pro.language == "ar"
          //             ? AppColor.darkColor
          //             : Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }
}
