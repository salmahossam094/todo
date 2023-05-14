import 'package:flutter/material.dart';
import 'package:todo/screens/settings.dart';
import 'package:todo/screens/widgets/show_floating_bottom.dart';
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
      extendBody: true,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'To Do List',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
      body: tabs[index],
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(4),
        shape: CircularNotchedRectangle(),
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
        shape: StadiumBorder(side: BorderSide(color: Colors.white,width: 3)),
        onPressed: () {
        showFloatingBottom();
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  showFloatingBottom(){
    showModalBottomSheet(context: context, builder: (context) {
      return ShowFloatingBottom();
    },);
  }
}
