import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleRequest extends StatelessWidget {
  final Map request;

  const SingleRequest({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.transparent,
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              horizontalTitleGap: 0.0,
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Blood Group: ',
                          style: TextStyle(color: Colors.red)),
                      Text(
                        '${request['bloodGroup']}',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${request['createdAt']}',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Name: ${request['contactName']}'),
                  Text('Contact Phone: ${request['contactPhone']}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
