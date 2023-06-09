import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/edit_screen.dart';
import 'package:todo/screens/login_screen.dart';
import 'package:todo/screens/sign_up1.dart';
import 'package:todo/screens/signup.dart';
import 'package:todo/shared/styles/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.disableNetwork();  ----> // to make app local
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  late MyProvider provider;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyProvider>(context);
    initSharedPref();

    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: Locale(provider.language),
      debugShowCheckedModeBanner: false,
      initialRoute: provider.firebaseUser != null
          ? HomeLayout.routeName
          : LoginScreen.routeName,
      routes: {
        CreateAccount1.routeName:(context) => CreateAccount1(),
        HomeLayout.routeName: (context) => HomeLayout(),
        EditScreen.routeName: (context) => EditScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        CreateAccount.routeName: (context) => CreateAccount(),
      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.theme,
    );
  }

  initSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String language = prefs.getString('lang') ?? 'en';
    provider.changeLanguage(language);
    String? mode = prefs.getString('mode');
    provider.changeTheme(mode == 'light' ? ThemeMode.light : ThemeMode.dark);
  }
}
