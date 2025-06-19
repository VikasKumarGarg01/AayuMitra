import 'package:aayumitra/screens/usermodel/userdata.dart';
import 'package:flutter/material.dart';
// import 'user_data.dart'; // import the notifier
// 
class ValueListenerWidget extends StatelessWidget {
  const ValueListenerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserData>(
      valueListenable: userNotifier,
      builder: (context, user, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hi ${user.name}'),
          Text(user.email),
          Text(user.address),
          Text(user.phone),
        ],
      ),
    );
  }
}