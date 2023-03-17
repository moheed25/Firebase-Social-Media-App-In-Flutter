import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sir/res/colours.dart';
import 'package:sir/view/dashboard/chat/chatscreen.dart';
import 'package:sir/viewmodel/services/session_manager.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  if (SessionController().userid.toString() ==
                      snapshot.child('uid').value.toString()) {
                    return Container();
                  } else {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: ChatScreen(
                              receiverId:
                                  snapshot.child('uid').value.toString(),
                              name: snapshot.child('userName').value.toString(),
                              email: snapshot.child('email').value.toString(),
                              image: snapshot.child('profile').value.toString(),
                            ),
                            withNavBar: false,
                          );
                        },
                        leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: AppColors.primaryColor)),
                            child:
                                snapshot.child('profile').value.toString() == ''
                                    ? Icon(Icons.person_outline)
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image(
                                          image: NetworkImage(snapshot
                                              .child('profile')
                                              .value
                                              .toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                            //child: CircleAvatar()
                            ),
                        title:
                            Text(snapshot.child('userName').value.toString()),
                        subtitle:
                            Text(snapshot.child('email').value.toString()),
                      ),
                    );
                  }

                  // return Card(
                  //   child: ListTile(
                  //     leading: CircleAvatar(),
                  //     title: Text(snapshot.child('userName').value.toString()),
                  //     subtitle: Text(snapshot.child('email').value.toString()),
                  //   ),
                  // );
                })));
  }
}
