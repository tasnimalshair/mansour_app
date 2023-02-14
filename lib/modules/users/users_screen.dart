import '../../models/user/user_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  // const UsersScreen({Key? key}) : super(key: key);

  List<User> list = [
    User(id: 1, name: 'Tasnim Alshair', phone: '+970592421686'),
    User(id: 2, name: 'Lama Naser', phone: '+970591864823'),
    User(id: 3, name: 'Sama Ashi', phone: '+970599751389'),
    User(id: 4, name: 'Maher Saqer', phone: '+970594934865'),
    User(id: 1, name: 'Tasnim Alshair', phone: '+970592421686'),
    User(id: 2, name: 'Lama Naser', phone: '+970591864823'),
    User(id: 3, name: 'Sama Ashi', phone: '+970599751389'),
    User(id: 4, name: 'Maher Saqer', phone: '+970594934865'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return buildUserItem(list[index]);
          },
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              ),
          itemCount: list.length),
    );
  }

  Widget buildUserItem(User user) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            child: Text(
              '${user.id}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.name}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              Text(
                '${user.phone}',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              )
            ],
          )
        ],
      ),
    );
  }
}
