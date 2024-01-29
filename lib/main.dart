import 'package:flutter/material.dart';
import 'package:netfloux/repositories/data_repository.dart';
import 'package:netfloux/ui/screens/home_screen.dart';
import 'package:netfloux/ui/screens/loading_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => DataRepository(),
  child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetFloux',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
       
      ),
      home: const LoadingScreen(),
    );
  }
}

