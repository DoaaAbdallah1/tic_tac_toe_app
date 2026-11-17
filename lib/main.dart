import 'package:flutter/material.dart';
import 'package:tic_tac_toe/features/home/presentation/screens/first_screen.dart';
import 'package:tic_tac_toe/features/home/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Montserrat",

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      routes:{
        FirstScreen.routeName:(context)=> FirstScreen(),
        HomeScreen.routeName :(context) =>  HomeScreen(mySymbol: ModalRoute.of(context)!.settings.arguments as String,),
      },
      initialRoute: FirstScreen.routeName ,
    );
  }
}
