// import 'package:flutter/material.dart';
// import 'package:pbgpl/screens/status_screen.dart';

// class SearchBoxWidget extends StatelessWidget {
//   final TextEditingController textController = TextEditingController();

//   SearchBoxWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // When the user taps outside of the input box, hide the keyboard
//         FocusScope.of(context).unfocus();
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const Text(
//               'Search for your existing connection here',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 17,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.0),
//                 border: Border.all(
//                   color: Colors
//                       .green, // Change the color to your desired border color
//                   width: 1.0, // You can adjust the border width as needed
//                 ),
//               ),
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: TextField(
//                         controller: textController,
//                         decoration: const InputDecoration(
//                           hintText: 'Enter your Token/Phone_no here',
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: const BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(6.0),
//                         bottomRight: Radius.circular(6.0),
//                       ),
//                     ),
//                     child: TextButton(
//                       onPressed: () {
//                         // Call the provided search function
//                         final searchText = textController.text;
//                         if (searchText.isNotEmpty) {
//                           // Navigate to the SearchScreen with the entered token
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => SearchScreen(
//                               token: searchText,
//                             ),
//                           ));
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text(
//                                 'Please enter a valid token before searching.',
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       child: const Text(
//                         'Search',
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pbgpl/screens/status_screen.dart';

class SearchBoxWidget extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  SearchBoxWidget({Key? key}) : super(key: key);

  void searchButtonPressed(BuildContext context) {
    final searchText = textController.text.trim(); // Trim white spaces
    if (searchText.isNotEmpty) {
      // Navigate to the SearchScreen with the entered token
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchScreen(
          token: searchText,
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter a valid token before searching.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // When the user taps outside of the input box, hide the keyboard
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Search for your existing connection here',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors
                      .green, // Change the color to your desired border color
                  width: 1.0, // You can adjust the border width as needed
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your Token/Phone_no here',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6.0),
                        bottomRight: Radius.circular(6.0),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        searchButtonPressed(
                            context); // Call the search function
                      },
                      child: const Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectInfoWidget extends StatelessWidget {
  const ProjectInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.green[200], // Background color
                border: Border.all(
                  color: Colors.greenAccent, // Border color
                ),
                borderRadius: BorderRadius.circular(8.0), // Border radius
              ),
              child: Text(
                'Please fill up the form below',
                style: TextStyle(fontSize: 18.0, color: Colors.green[800]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
