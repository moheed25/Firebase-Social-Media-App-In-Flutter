import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sir/res/colours.dart';
import 'package:sir/utils/utils.dart';
import 'package:sir/viewmodel/services/session_manager.dart';

class ChatScreen extends StatefulWidget {
  String image, name, email, receiverId;

  ChatScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.receiverId,
      required this.email});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child('Chat');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Text(index.toString());
                  })),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: TextFormField(
                    controller: messageController,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(height: 0, fontSize: 19),
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            sendmessage();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: CircleAvatar(
                              child: Icon(Icons.send),
                            ),
                          ),
                        ),
                        hintText: 'Enter Message',
                        contentPadding: EdgeInsets.all(15),
                        hintStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  height: 0,
                                  color: AppColors.primaryTextTextColor
                                      .withOpacity(0.8),
                                ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textFieldDefaultBorderColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.secondaryColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textFieldDefaultBorderColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  sendmessage() {
    if (messageController.text.isEmpty) {
      Utils.toastMessage('Enter Message');
    } else {
      final Timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      ref.child(Timestamp).set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userid.toString(),
        'receiver': widget.receiverId,
        'type': 'text',
        'time': Timestamp.toString()
      }).then((value) {
        messageController.clear();
      });
    }
  }
}
