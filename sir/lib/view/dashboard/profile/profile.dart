import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sir/res/colours.dart';
import 'package:sir/res/components/round_buttons.dart';
import 'package:sir/utils/route/route_name.dart';
import 'package:sir/view/dashboard/profile/profileController.dart';
import 'package:sir/viewmodel/services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('User');

  // late io.File imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
          create: (_) => ProfileController(),
          child:
              Consumer<ProfileController>(builder: (context, provider, child) {
            return SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: StreamBuilder(
                      stream: ref
                          .child(SessionController().userid.toString())
                          .onValue,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          Map<dynamic, dynamic> map =
                              snapshot.data.snapshot.value;
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),

                                // Uploading Image :
                                Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Center(
                                          child: Container(
                                            height: 130,
                                            width: 130,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors
                                                        .secondaryTextColor,
                                                    width: 5),
                                                shape: BoxShape.circle),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: provider.image == null
                                                    ? map['profile']
                                                                .toString() ==
                                                            " "
                                                        ? Icon(
                                                            Icons.person,
                                                            size: 35,
                                                          )
                                                        : Image(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                map['profile']
                                                                    .toString()
                                                                //"https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg?fit=640,427"),
                                                                ),
                                                            loadingBuilder:
                                                                (context, child,
                                                                    loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null)
                                                                return child;
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: AppColors
                                                                      .focusUnderLineColor,
                                                                ),
                                                              );
                                                              //
                                                              // Center(
                                                              //   child: Container(
                                                              //     height: 130,
                                                              //     width: 130,
                                                              //     decoration: BoxDecoration(
                                                              //         border: Border.all(
                                                              //             color: AppColors.secondaryTextColor,
                                                              //             width: 5),
                                                              //         shape: BoxShape.circle),
                                                              //     child: ClipRRect(
                                                              //       borderRadius: BorderRadius.circular(100),
                                                              //       child: map['profile'].toString() == " "
                                                              //           ? Icon(
                                                              //               Icons.person,
                                                              //               size: 35,
                                                              //             )
                                                              //           : Image(
                                                              //               fit: BoxFit.cover,
                                                              //               image: NetworkImage(
                                                              //                   map['profile'].toString()
                                                              //                   //"https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg?fit=640,427"),
                                                              //                   ),
                                                              //               loadingBuilder:
                                                              //                   (context, child, loadingProgress) {
                                                              //                 if (loadingProgress == null)
                                                              //                    return child;
                                                              //                 return Center(
                                                              //                   child: CircularProgressIndicator(
                                                              //                     color:
                                                              //                         AppColors.focusUnderLineColor,
                                                              //                   ),
                                                              //                 );
                                                            },
                                                            errorBuilder:
                                                                (context,
                                                                    object,
                                                                    stack) {
                                                              return Container(
                                                                child: Icon(
                                                                  Icons
                                                                      .error_outline,
                                                                  color: AppColors
                                                                      .alertColor,
                                                                ),
                                                              );
                                                            },
                                                          )
                                                    : Image.file(File(provider
                                                            .image!.path)
                                                        .absolute)),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          provider.pickImage(context);
                                        },
                                        child: CircleAvatar(
                                          radius: 14,
                                          backgroundColor:
                                              AppColors.primaryIconColor,
                                          child: Icon(
                                            Icons.add,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ]),
                                SizedBox(
                                  height: 40,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    provider.showUserNameDailogAlert(
                                        context, map['userName']);
                                  },
                                  child: ReusableRow(
                                      iconData: Icons.person_outline,
                                      title: 'userName',
                                      value: map['userName']),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    provider.showUserPhoneDailogAlert(
                                        context, map["phone"]);
                                  },
                                  child: ReusableRow(
                                      iconData: Icons.phone_outlined,
                                      title: 'Phone',
                                      value: map['phone'] == " "
                                          ? 'xxx xxx xxx'
                                          : map['phone']),
                                ),
                                ReusableRow(
                                    iconData: Icons.email_outlined,
                                    title: 'Email',
                                    value: map['email']),
                                // ListTile(
                                //   title: Text(map['userName']),
                                // )

                                SizedBox(
                                  height: 40,
                                ),
                                // RoundButton(
                                //     title: 'Logout',
                                //     onPress: () {
                                //       FirebaseAuth auth = FirebaseAuth.instance;
                                //       auth.signOut().then((value) {
                                //         SessionController().userid = '';
                                //         Navigator.pushNamed(
                                //             context, RouteName.loginview);
                                //       });
                                //     })
                              ],
                            ),
                          );
                        } else {
                          return Center(
                            child: Text("Something went Wrong"),
                          );
                        }
                      })),
            );
          }),
        )

        /// Adding Controller :

        // SafeArea(
        //   child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 15),
        //       child: StreamBuilder(
        //           stream:
        //               ref.child(SessionController().userid.toString()).onValue,
        //           builder: (context, AsyncSnapshot snapshot) {
        //             if (snapshot.hasError) {
        //               return Center(
        //                 child: CircularProgressIndicator(),
        //               );
        //             } else if (snapshot.hasData) {
        //               Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
        //               return Column(
        //                 children: [
        //                   SizedBox(
        //                     height: 20,
        //                   ),

        //                   // Uploading Image :
        //                   Stack(alignment: Alignment.bottomCenter, children: [
        //                     Padding(
        //                       padding: const EdgeInsets.symmetric(vertical: 10),
        //                       child: Center(
        //                         child: Container(
        //                           height: 130,
        //                           width: 130,
        //                           decoration: BoxDecoration(
        //                               border: Border.all(
        //                                   color: AppColors.secondaryTextColor,
        //                                   width: 5),
        //                               shape: BoxShape.circle),
        //                           child: ClipRRect(
        //                             borderRadius: BorderRadius.circular(100),
        //                             child: map['profile'].toString() == " "
        //                                 ? Icon(
        //                                     Icons.person,
        //                                     size: 35,
        //                                   )
        //                                 : Image(
        //                                     fit: BoxFit.cover,
        //                                     image: NetworkImage(
        //                                         map['profile'].toString()
        //                                         //"https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg?fit=640,427"),
        //                                         ),
        //                                     loadingBuilder: (context, child,
        //                                         loadingProgress) {
        //                                       if (loadingProgress == null)
        //                                         return child;
        //                                       return Center(
        //                                         child: CircularProgressIndicator(
        //                                           color: AppColors
        //                                               .focusUnderLineColor,
        //                                         ),
        //                                       );
        //                                       //
        //                                       // Center(
        //                                       //   child: Container(
        //                                       //     height: 130,
        //                                       //     width: 130,
        //                                       //     decoration: BoxDecoration(
        //                                       //         border: Border.all(
        //                                       //             color: AppColors.secondaryTextColor,
        //                                       //             width: 5),
        //                                       //         shape: BoxShape.circle),
        //                                       //     child: ClipRRect(
        //                                       //       borderRadius: BorderRadius.circular(100),
        //                                       //       child: map['profile'].toString() == " "
        //                                       //           ? Icon(
        //                                       //               Icons.person,
        //                                       //               size: 35,
        //                                       //             )
        //                                       //           : Image(
        //                                       //               fit: BoxFit.cover,
        //                                       //               image: NetworkImage(
        //                                       //                   map['profile'].toString()
        //                                       //                   //"https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg?fit=640,427"),
        //                                       //                   ),
        //                                       //               loadingBuilder:
        //                                       //                   (context, child, loadingProgress) {
        //                                       //                 if (loadingProgress == null)
        //                                       //                   return child;
        //                                       //                 return Center(
        //                                       //                   child: CircularProgressIndicator(
        //                                       //                     color:
        //                                       //                         AppColors.focusUnderLineColor,
        //                                       //                   ),
        //                                       //                 );
        //                                     },
        //                                     errorBuilder:
        //                                         (context, object, stack) {
        //                                       return Container(
        //                                         child: Icon(
        //                                           Icons.error_outline,
        //                                           color: AppColors.alertColor,
        //                                         ),
        //                                       );
        //                                     },
        //                                   ),
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                     InkWell(
        //                       onTap: (){

        //                       },
        //                       child: CircleAvatar(
        //                         radius: 14,
        //                         backgroundColor: AppColors.primaryIconColor,
        //                         child: Icon(
        //                           Icons.add,
        //                           size: 18,
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                     )
        //                   ]),
        //                   SizedBox(
        //                     height: 40,
        //                   ),
        //                   ReusableRow(
        //                       iconData: Icons.person_outline,
        //                       title: 'userName',
        //                       value: map['userName']),
        //                   ReusableRow(
        //                       iconData: Icons.phone_outlined,
        //                       title: 'Phone',
        //                       value: map['phone'] == " "
        //                           ? 'xxx xxx xxx'
        //                           : map['phone']),
        //                   ReusableRow(
        //                       iconData: Icons.email_outlined,
        //                       title: 'Email',
        //                       value: map['email']),
        //                   // ListTile(
        //                   //   title: Text(map['userName']),
        //                   // )
        //                 ],
        //               );
        //             } else {
        //               return Center(
        //                 child: Text("Something went Wrong"),
        //               );
        //             }
        //           })),
        // ),
        );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  const ReusableRow(
      {super.key,
      required this.iconData,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: Icon(iconData),
          trailing: Text(value),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.5),
        )
      ],
    );
  }
}
