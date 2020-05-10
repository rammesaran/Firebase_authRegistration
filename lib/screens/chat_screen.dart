import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
final _fireStoreAuth = Firestore.instance;
  FirebaseUser loggedinuser;

class ChatScreen extends StatefulWidget {
  static String url = '/chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _controller = TextEditingController();
  String messagetext;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    final user = await _auth.currentUser();
    if (user != null) {
      loggedinuser = user;
      print(loggedinuser.email);
    }
  }

  void logOutUser() async {
    final userid = await _auth.signOut();
    return userid;
  }

  void sendMessage() async {
    await for (var data in _fireStoreAuth.collection("messages").snapshots()) {
      for (var messages in data.documents) {
        print(messages.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //sendMessage ();
                logOutUser();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _fireStoreAuth.collection("messages").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final message = snapshot.data.documents.reversed;
                  List<TextIconButton> textwidget = [];
                  for (var myvariable in message) {
                    final messageText = myvariable.data['text'];
                    final messageSender = myvariable.data['sender'];
                    final currentuser = loggedinuser.email;
                    if(currentuser == messageSender)
                    {

                    }
                    final messagesWidget =TextIconButton(
                      messageSender: messageSender,
                      messageText: messageText,
                      iswho: currentuser == messageSender,
                    );
                    textwidget.add(messagesWidget);
                  }

                  // return Column(
                  //   children: textwidget,
                  // );

                  return Expanded(
                    child: ListView(
                      reverse: true,
                      children: textwidget,
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                    ),
                  );
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        messagetext = value.trim();
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _fireStoreAuth.collection("messages").add({
                        "sender": loggedinuser.email,
                        "text": messagetext,
                      });
                     _controller.clear();

                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextIconButton extends StatelessWidget {
  final String messageText;
  final String messageSender;
  final bool iswho;
  TextIconButton({this.messageSender, this.messageText,this.iswho});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment: iswho? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(messageSender,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12.0
              ),
          
          ),
          Material(
          elevation: 5.0,
          borderRadius: iswho ? BorderRadius.only(
              topLeft:  Radius.circular(30.0),
              bottomLeft:  Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
          ) :  BorderRadius.only(
              topRight:  Radius.circular(30.0),
              bottomLeft:  Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
          ),
          color: iswho ? Colors.lightBlueAccent : Colors.black87,
          child: Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
            ),
            child: Text(
              '$messageText',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}
