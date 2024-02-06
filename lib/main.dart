import 'package:flutter/material.dart';
import 'package:pbgpl/screens/home_screen.dart';
import 'package:pbgpl/screens/splash_screnn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PBGPL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: SplashScreen(
        duration: const Duration(
            seconds: 4), // Set the duration for your splash screen
        nextPage: WillPopScope(
          onWillPop: () async => false, // Disable back button
          child: const MyHomePage(title: 'PBGPL'),
        ), // Replace with your custom logo widget
        // iconBackgroundColor:
        //     Colors.yellowAccent, // Customize the background color
        // backgroundColor: Colors.green[500], // Customize the background color
        // text: const Text('PBGPL',
        //     style: TextStyle(fontSize: 20, color: Colors.black)),

        // child: const YourSplashScreenLogo(),
      ),
    );
  }
}

// class YourSplashScreenLogo extends StatelessWidget {
//   const YourSplashScreenLogo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipOval(
//       child: Image.asset(
//         'assets/images/pbg.png', // Replace with the actual path to your logo image
//         width: 48.0, // Adjust the width as needed
//         height: 48.0, // Adjust the height as needed
//       ),
//     );
//   }
// }
