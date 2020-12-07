import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:zeras/view/user/navigation/navigationpage/promo.dart';
import 'package:zeras/view/user/navigation/navigationpage/chat.dart';
import 'package:zeras/view/user/navigation/navigationpage/homepage.dart';
import 'package:zeras/view/user/navigation/navigationpage/profile.dart';

class UserNavigation extends StatefulWidget {
  @override
  _UserNavigationState createState() => _UserNavigationState();
}

class _UserNavigationState extends State<UserNavigation> {
  int _selectedIndex = 0;

  final _page = [HomePage(), Promo(), Chat(), Profile()];
  
  // final _page = [Profile(), Calendar(), Chat(), HomePage()];

  void _onTabItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _page.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xffFFFFFF),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xff216353),
          unselectedItemColor: Colors.grey[500],
          items: [
            BottomNavigationBarItem(
                icon: Icon(EvaIcons.home),
                title: Text('Home',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'Poppins'))),
            BottomNavigationBarItem(
                icon: Icon(EvaIcons.pricetags),
                title: Text('Promo',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'Poppins'))),
            BottomNavigationBarItem(
                icon: Icon(EvaIcons.messageSquare),
                title: Text('Chat',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'Poppins'))),
            BottomNavigationBarItem(
                icon: Icon(EvaIcons.person),
                title: Text('Profile',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'Poppins')))
          ],
          currentIndex: _selectedIndex,
          onTap: _onTabItem,
        ));
  }
}
