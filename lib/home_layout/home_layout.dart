import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/screens/settings.dart';
import 'package:todo/screens/tasks.dart';
import 'package:todo/screens/widgets/show_floating_bottom.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'HomeLayout';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [TasksTab(), SettingsTab()];
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          index == 1
              ? AppLocalizations.of(context)!.settings
              : AppLocalizations.of(context)!.appTitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: tabs[index],
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(4),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: index,
            onTap: (value) {
              index = value;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    size: 30,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  label: ''),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(
            side: BorderSide(color: Colors.white, width: 3)),
        onPressed: () {
          showFloatingBottom();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  showFloatingBottom() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const ShowFloatingBottom(),
        );
      },
    );
  }
}
