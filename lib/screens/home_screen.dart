import 'package:flutter/material.dart';

import 'package:pbgpl/screens/registration_screen.dart';
import 'package:pbgpl/widgets/continer_banner.dart';
import 'package:pbgpl/widgets/custom_searchbox.dart';
import 'package:marquee/marquee.dart';

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
            // centerTitle: true,
            leading: Container(
              margin: const EdgeInsets.only(left: 10.0),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white24,
                child:
                    Image.asset('assets/images/pbg.png', width: 40, height: 40),
              ),
            ),
            title: const Text(
              "PBGPL REGISTRATION FORM",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green[400]!,
                    Colors.yellow[400]!,
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                                // const Center(
                                //   child: Column(
                                //     children: [
                                //       Text(
                                //         "Registration for gas connection in guwahati & silchar",
                                //         style: TextStyle(
                                //           color: Colors.white,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 12,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 100,
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
                                // const ProjectInfoWidgettwo(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // SearchBoxWidget(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue[400]!,
                                Colors.blue[400]!,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ), // Set the background color
                          padding: const EdgeInsets.all(
                              8.0), // Adjust padding as needed
                          child: Row(
                            children: [
                              // Notification Bell Icon
                              const Icon(
                                Icons.notifications,
                                color: Colors.white, // Adjust icon color
                                size: 20.0, // Adjust icon size
                              ),
                              const SizedBox(
                                width:
                                    4.0, // Adjust spacing between icon and marquee
                              ),

                              // Marquee Widget
                              Expanded(
                                child: SizedBox(
                                  height:
                                      25.0, // Set a specific height or adjust as needed
                                  child: Marquee(
                                    text:
                                        "Registration for Gas Connection in Guwahati & Silchar (Registration free till 31st March 2024 for Gas connection. Post 31st March 2024 registration will be chargeable @275 INR)",
                                    style: const TextStyle(
                                      color: Colors.white, // Adjust text color
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.0, // Adjust font size
                                      fontFamily:
                                          'Roboto', // Set your desired font family
                                    ),
                                    scrollAxis: Axis.horizontal,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    blankSpace: 20.0,
                                    velocity: 100.0,
                                    pauseAfterRound: const Duration(seconds: 1),
                                    startPadding: 10.0,
                                    accelerationDuration:
                                        const Duration(seconds: 1),
                                    accelerationCurve: Curves.linear,
                                    decelerationDuration:
                                        const Duration(milliseconds: 500),
                                    decelerationCurve: Curves.easeOut,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const ProjectInfoWidget(),
                      const RegistrationScreen(),
                      // Footer section
                      Container(
                        padding: const EdgeInsets.all(10),
                        color: const Color(
                            0x33000000), // Semi-transparent black background color
                        child: const Center(
                          child: Text(
                            '© 2023-2024, Purba Bharati Gas Pvt. Ltd. All Rights Reserved.',
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
