import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }
@override
  void didChangeDependencies() {
      Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats/U4WZwc8JaRV8bc8DETwO/messages')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // print(streamSnapshot.data.docs[0].data()['text']);
            final documents = streamSnapshot.data.docs;
            return ListView.builder(
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text(documents[index].data()['text']),
              ),
              itemCount: documents.length,
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/U4WZwc8JaRV8bc8DETwO/messages')
              .add({
                'text':'This was added by clicking'
              });
        },
      ),
    );
  }
}

// .listen((data) {
//             data.docs.forEach((element) {
//               print(element.data()['text']);
