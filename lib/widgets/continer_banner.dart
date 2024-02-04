// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';

Container GradientContainer(Size size) {
  var secondaryColor = Colors.green[400]; // Replace with your desired color
  var primaryColor = Colors.yellow[400]; // Replace with your desired color

  return Container(
    height: size.height * .2,
    width: size.width,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        image: DecorationImage(
            image: AssetImage('assets/images/logo.png'), fit: BoxFit.cover)),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          gradient: LinearGradient(colors: [
            secondaryColor!.withOpacity(0.9),
            primaryColor!.withOpacity(0.9)
          ])),
    ),
  );
}

// ignore: non_constant_identifier_names
Padding CustomCard(Size size, context, {required String image}) {
  return Padding(
    padding: const EdgeInsets.only(right: 15),
    child: GestureDetector(
      // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Rooms(),)),
      child: Container(
        height: size.height * 0.15,
        width: size.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black.withOpacity(0.1),
          ),
          // child: Padding(
          //   padding: EdgeInsets.only(left: 15, top: size.height * 0.12),
          //   child: Text(
          //     text,
          //     style: const TextStyle(
          //       color: Colors.white,
          //       fontSize: 15,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        ),
      ),
    ),
  );
}
