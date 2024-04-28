import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String msg;
  var bubble_color;
  ChatBubble({super.key, required this.msg, required this.bubble_color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: bubble_color,
      ),
      child: Text(
        msg,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
