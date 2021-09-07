import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/layout/home_layout.dart';

import 'bloc_observer.dart';

void main() {
  runApp(MyApp());
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
    debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomeLayout(),
    );
  }
}
