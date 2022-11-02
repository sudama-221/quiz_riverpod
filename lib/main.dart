import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/pages/quiz_page.dart';
import 'package:quiz_app/pages/test_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Quiz App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.yellow,
            bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Colors.transparent)),
        home: const QuizPage(),
        // home: const TestPage(),
      ),
    );
  }
}
