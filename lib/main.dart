import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/view/home_view.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/viewModel/home_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
            create: (context) => HomeViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(child:  HomeView()),
      ),
    );
  }
}
