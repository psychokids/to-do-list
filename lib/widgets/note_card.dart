import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;

  const NoteCard({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: Column(
          children: [
            Text(
              '$title',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: .3,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Text(
                '$content',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      ),
    );
  }
}
