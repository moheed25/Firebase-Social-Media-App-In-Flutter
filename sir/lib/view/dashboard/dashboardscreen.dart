import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sir/res/colours.dart';
import 'package:sir/utils/route/route_name.dart';
import 'package:sir/view/dashboard/Home/homescreen.dart';
import 'package:sir/view/dashboard/profile/profile.dart';
import 'package:sir/view/dashboard/user/user_list.dart';
import 'package:sir/viewmodel/services/session_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreen() {
    return [
      //HomeScreen(),

      SafeArea(
        child: Text(
          "Home",
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      SafeArea(
        child: Text(
          "Chat",
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      SafeArea(
        child: Text(
          "Add",
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      UserListScreen(),
      // SafeArea(
      //   child: Text(
      //     "Message",
      //     style: Theme.of(context).textTheme.subtitle1,
      //   ),
      // ),
      // SafeArea(
      //   child: Text(
      //     "Profile",
      //     style: Theme.of(context).textTheme.subtitle1,
      //   ),
      // ),
      ProfileScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(
            Icons.home,
            color: Colors.grey.shade100,
          )),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.message),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(
            Icons.message,
            color: Colors.grey.shade100,
          )),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.add),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(
            Icons.add,
            color: Colors.grey.shade100,
          )),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.people),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(
            Icons.people,
            color: Colors.grey.shade100,
          )),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          activeColorPrimary: AppColors.primaryIconColor,
          inactiveIcon: Icon(
            Icons.person,
            color: Colors.grey.shade100,
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),

          //Text(SessionController().userid.toString()),
          //Text(SessionController().ue\.toString()),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut().then((value) {
                    SessionController().userid = '';
                    Navigator.pushNamed(context, RouteName.loginview);
                  });
                },
                icon: Icon(Icons.login_outlined))
          ],
        ), ////
        body: PersistentTabView(
          context,
          screens: _buildScreen(),
          items: _navBarItem(),
          controller: controller,
          backgroundColor: AppColors.otpHintColor,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(1),
          ),
          navBarStyle: NavBarStyle.style15,
        ));

    //  );
  }
}
