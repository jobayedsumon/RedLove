import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final image;
  final name;

  const UserAvatar({Key? key, this.image, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image != null
        ? CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(image),
          )
        : CircleAvatar(
            radius: 30.0,
            child: Text(
              name != null ? name[0].toUpperCase() : '',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
