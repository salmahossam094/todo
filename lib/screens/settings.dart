import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/widgets/drop_down_lang.dart';
import 'package:todo/screens/widgets/drop_down_theme.dart';

class SettingsTab extends StatefulWidget {
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
                  color: prov.theme == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomDropDownLanguage(),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!.theming,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: prov.theme == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomDropDownTheme(),
        ],
      ),
    );
  }
}
