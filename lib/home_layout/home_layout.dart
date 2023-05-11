import 'package:flutter/material.dart';
import 'package:todo/screens/settings.dart';
import 'package:todo/screens/tasks.dart';

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
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: tabs[index],
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(4),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
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
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
