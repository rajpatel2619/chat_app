import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data.docs;
        // final key = chatDocs[0].id;
        // print(chatSnapshot.data.docs[0]);
        final uid = FirebaseAuth.instance.currentUser.uid;
      
        return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) => MessageBubble(
                  chatDocs[index].data()['text'],
                  chatDocs[index].data()['createdAt'].toDate(),
                  chatDocs[index].data()['username'],
                  chatDocs[index].data()['userImage'],
                  chatDocs[index].data()['userId'] == uid,
                  key: ValueKey(chatDocs[index].id),
                ));
      },
    );
  }
}
