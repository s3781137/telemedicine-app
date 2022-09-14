import 'package:flutter/material.dart';
import 'signIn.dart';

class Homepage extends StatelessWidget {
  const Homepage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ND TELEMEDICINE'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('todo: homepage',
            style: Theme.of(context).textTheme.headline2),
      ),
    );
  }
}
