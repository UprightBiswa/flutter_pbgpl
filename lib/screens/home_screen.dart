import 'package:flutter/material.dart';

import 'package:pbgpl/screens/registration_screen.dart';
import 'package:pbgpl/widgets/continer_banner.dart';
import 'package:pbgpl/widgets/custom_searchbox.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          // When the user taps outside of the input box, hide the keyboard
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "PBGPL REGISTRATION FORM",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[400]!, Colors.yellow[400]!],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    GradientContainer(size),
                    Positioned(
                      top: 0.00,
                      left: 24,
                      right: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Column(
                              children: [
                                Text(
                                  "Registration for gas connection in guwahati & silchar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          SizedBox(
                            height: size.height * 0.15,
                            width: size.width, // Set a fixed width
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                CustomCard(
                                  size,
                                  context,
                                  image: "assets/images/1.png",
                                  // text: "PBGPL 1",
                                ),
                                CustomCard(
                                  size,
                                  context,
                                  image: "assets/images/2.png",
                                  // text: "PBGPL 2",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // SearchBoxWidget(),
                const ProjectInfoWidget(),
                const RegistrationScreen(),
                // Footer section
                Container(
                  padding: const EdgeInsets.all(10),
                  color: const Color(
                      0x33000000), // Semi-transparent black background color
                  child: const Center(
                    child: Text(
                      '© 2024, Purba Bharati Gas Pvt. Ltd. All Rights Reserved.',
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
