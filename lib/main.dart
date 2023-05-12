import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/shared/styles/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => MyProvider(),
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales:  [
        Locale('en'),
        Locale('ar'),
      ],
      locale: Locale(provider.language),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeLayout.routeName ,
      routes: {
        HomeLayout.routeName:(context) => HomeLayout(),
      },
      theme:MyThemeData.lightTheme ,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.theme,
    );
  }
}


