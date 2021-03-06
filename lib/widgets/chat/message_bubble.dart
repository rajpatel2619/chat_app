import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final DateTime time;
  final String userName;
  final String userImage;
  final bool isMe;
  final Key key;
  MessageBubble(
      this.message, this.time, this.userName, this.userImage, this.isMe,
      {this.key});
  @override
  Widget build(BuildContext context) {
    var t = DateFormat.jm().format(time).toString();
    var d = DateFormat.MMMEd().format(time).toString();
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: isMe ? Colors.teal : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                        !isMe ? Radius.circular(0) : Radius.circular(12),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(12),
                  )),
              width: 150,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.white
                            : Theme.of(context)
                                .accentTextTheme
                                .headline6
                                .color),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        color: isMe
                            ? Colors.white
                            : Theme.of(context)
                                .accentTextTheme
                                .headline6
                                .color),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '$t $d',
                    style: TextStyle(
                        color: isMe
                            ? Colors.white
                            : Theme.of(context).accentTextTheme.headline6.color,
                        fontSize: 11),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
