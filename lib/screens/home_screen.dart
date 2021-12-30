import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Simple Budget'),
            leading: IconButton(
              icon: Icon(
                Icons.settings,
                size: 30,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
