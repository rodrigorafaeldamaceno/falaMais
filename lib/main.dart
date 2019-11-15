import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:falamais/bloc/result_bloc.dart';
import 'package:falamais/pages/Home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [Bloc((i) => ResultBloc())],
      child: MaterialApp(
        title: 'Fala Mais',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
