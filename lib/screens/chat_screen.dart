import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatar Patar'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout')
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}

//  StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('chats/U4WZwc8JaRV8bc8DETwO/messages')
//               .snapshots(),
//           builder: (ctx, streamSnapshot) {
//             if (streamSnapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             // print(streamSnapshot.data.docs[0].data()['text']);
//             final documents = streamSnapshot.data.docs;
//             return ListView.builder(
//               itemBuilder: (ctx, index) => Container(
//                 padding: EdgeInsets.all(8),
//                 child: Text(documents[index].data()['text']),
//               ),
//               itemCount: documents.length,
//             );
//           })
