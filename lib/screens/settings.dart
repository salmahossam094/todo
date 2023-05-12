import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/show_language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/screens/show_theme.dart';
import 'package:todo/shared/styles/app_colors.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: prov.theme==ThemeMode.light?Colors.black:Colors.white,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                showLangBottom();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.lightColor)),
                child: Text(prov.language == 'en'
                    ? AppLocalizations.of(context)!.english
                    : AppLocalizations.of(context)!.arabic),
              )),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!.theming,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                   color: prov.theme==ThemeMode.light?Colors.black:Colors.white,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                showThemeBottom();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.lightColor)),
                child: Text(prov.theme == ThemeMode.light
                    ? AppLocalizations.of(context)!.light
                    : prov.theme == ThemeMode.dark
                        ? AppLocalizations.of(context)!.dark
                        : AppLocalizations.of(context)!.system),
              )),
        ],
      ),
    );
  }

  showThemeBottom() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const ShowThemeBottom();
      },
    );
  }

  showLangBottom() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const ShowLanguageBottom();
      },
    );
  }
}
