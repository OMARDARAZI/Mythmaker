import 'package:flutter/material.dart';
import 'package:myth_maker/widgets/pfp.dart';

class userTile extends StatelessWidget {
  userTile({super.key, required this.userName, required this.pfpLink});

  String userName;
  String pfpLink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: pfp(userName: userName, pfpLink: pfpLink),
        title: Text(userName),
        trailing: Container(
          width: 20,
          height: 10,
        ),
      ),
    );
  }
}
