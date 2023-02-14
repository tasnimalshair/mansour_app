import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Icon(Icons.menu),
        title: Text('First App'),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notification_important)),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: 200,
          height: 200,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                'images/white.jpg',
              ),
              Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(.7)),
                width: double.infinity,
                child: Text(
                  'Flower',
                  style: TextStyle(color: Colors.pink, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
