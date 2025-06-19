import 'package:flutter/material.dart';

class UserData {
  String name;
  String email;
  String address;
  String phone;
  UserData({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
  });
}

// Global notifier (import this wherever you need user data)
final ValueNotifier<UserData> userNotifier = ValueNotifier(
  UserData(
    name: 'Robert Smith',
    email: 'robert@gmail.com',
    address: 'Mumbai 400050',
    phone: '222-444-1111',
  ),
);
