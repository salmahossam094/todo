import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/shared/styles/app_colors.dart';

class ShowThemeBottom extends StatelessWidget {
  const ShowThemeBottom({Key? key}) : super(key: key);

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
                pro.changeTheme(ThemeMode.light);
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context)!.light,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 20,
                    color: pro.theme == ThemeMode.light
                        ? AppColor.lightColor
                        : Colors.white),
              )),
          SizedBox(
            height: 15,
          ),
          InkWell(
              onTap: () {
                pro.changeTheme(ThemeMode.dark);
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.dark,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      color: pro.theme == ThemeMode.dark
                          ? AppColor.darkColor
                          : Colors.black))),


        ],
      ),
    );
  }
}
