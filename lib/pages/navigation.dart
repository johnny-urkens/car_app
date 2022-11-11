import 'package:car_app/pages/list.dart';
import 'package:car_app/pages/login.dart';
import 'package:car_app/pages/scan.dart';
import 'package:car_app/pages/user_list.dart';
import 'package:car_app/utils/user_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage();

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => NavigationPageState();
}

class NavigationPageState extends State {
  int _selectedIndex = 0;

  // ignore: prefer_initializing_formals
  NavigationPageState();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [
    const UserListPage(),
    const ListPage(),
    const ScanPage(),
    const LoginPage()
  ];
  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    final naam = await UsersecureStorage.getUserName() ?? '';
    print('naam' + naam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('test'),
        // ),
        body: screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'All cars',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.adf_scanner),
              label: 'scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Login',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ));
  }
}
