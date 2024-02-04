//  import 'dart:convert';

// import 'package:flutter/material.dart';

// class SearchScreen extends StatelessWidget {
//   final String name;
//   final String phoneNumber;
//   final String location;
//   final String fatherOrHusbandName;
//   final String gasType;

//   const SearchScreen({super.key,
//     required this.name,
//     required this.phoneNumber,
//     required this.location,
//     required this.fatherOrHusbandName,
//     required this.gasType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Result'),
//         backgroundColor: Colors.green,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.green, Colors.yellow], // Adjust colors as needed
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Card(
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     children: <Widget>[
//                       ListTile(
//                         title: Text('Name'),
//                         subtitle: Text('Your name'),
//                       ),
//                       ListTile(
//                         title: Text('Phone number'),
//                         subtitle: Text('Your phone number'),
//                       ),
//                       ListTile(
//                         title: Text('Location'),
//                         subtitle: Text('Your location'),
//                       ),
//                       ListTile(
//                         title: Text("Father's/Husband's name"),
//                         subtitle: Text('Name'),
//                       ),
//                       ListTile(
//                         title: Text('Gas Type'),
//                         subtitle: Text('Gas type'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Go back to the HomePage
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

class SearchScreen extends StatefulWidget {
  final token;
  const SearchScreen({super.key, required this.token});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? name;
  String? phoneNumber;
  String? email;
  String? city;
  String? address;
  String? pin;
  String? gasType;
  bool isLoading = false;
  bool _isConnected = false; // Declare and initialize the _isConnected variable
  @override
  void initState() {
    super.initState();
    // Check network connectivity when the screen loads
    checkConnectivity();
    searchUser(widget.token);
    print('Token number : $widget.token');
  }

  Future<void> checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection, show a Snackbar message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network connection is off'),
        ),
      );
      setState(() {
        _isConnected = false; // Set _isConnected to false
      });
    } else {
      setState(() {
        _isConnected = true; // Set _isConnected to true
      });
    }
  }

  // void searchUser(String token) async {
  //   // Log the token number
  //   print('Token number entered: $token');

  //   // Show loading spinner
  //   setState(() {
  //     isLoading = true;
  //   });
  //   // Convert token to uppercase
  //   token = token.toUpperCase();

  //   // Make an HTTP POST request to your API
  //   final response = await http.post(
  //     Uri.parse('https://pbg.indigidigital.in/api/userdetails'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'value': token,
  //     }),
  //   );

  //   // Hide loading spinner
  //   setState(() {
  //     isLoading = false;
  //   });

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     if (data['user'] != null) {
  //       // Retrieve and display the user data
  //       setState(() {
  //         name = data['user']['name'];
  //         phoneNumber = data['user']['phone_no'];
  //         email = data['user']['email'];
  //         city = data['user']['location'];
  //         address = data['user']['address'];
  //         pin = data['user']['pin'];
  //         gasType = data['user']['gas_type'];
  //       });
  //       // Log the user data
  //       print('User Data: $data');
  //     } else if (data.containsKey('message')) {
  //       // Handle user not found
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(data['message']),
  //         ),
  //       );
  //     }
  //   } else if (response.statusCode == 404) {
  //     // Handle 404 Not Found
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('User not found (404)'),
  //       ),
  //     );
  //   } else {
  //     // Handle other API request errors
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('API request error'),
  //       ),
  //     );
  //   }
  // }
  void searchUser(String token) async {
    try {
      // Log the token number
      print('Token number entered: $token');

      // Show loading spinner
      setState(() {
        isLoading = true;
      });
      // Convert token to uppercase
      token = token.toUpperCase();

      // Make an HTTP POST request to your API
      final response = await http.post(
        Uri.parse('https://pbg.indigidigital.in/api/userdetails'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'value': token,
        }),
      );

      // Hide loading spinner
      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['user'] != null) {
          // Retrieve and display the user data
          setState(() {
            name = data['user']['name'];
            phoneNumber = data['user']['phone_no'];
            email = data['user']['email'];
            city = data['user']['location'];
            address = data['user']['address'];
            pin = data['user']['pin'];
            gasType = data['user']['gas_type'];
          });
          // Log the user data
          print('User Data: $data');
        } else if (data.containsKey('message')) {
          // Handle user not found
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
            ),
          );
        } else {
          // Handle other API response errors
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid response from the server'),
            ),
          );
        }
      } else if (response.statusCode == 404) {
        // Handle 404 Not Found
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found'),
          ),
        );
      } else {
        // Handle other HTTP request errors
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('API request error'),
          ),
        );
      }
    } catch (e) {
      // Handle other exceptions, including connectivity or DNS issues
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network connection or DNS issue'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
        backgroundColor: Colors.green,
        leading: Builder(
          builder: (BuildContext builderContext) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Clear the current focus to dismiss the keyboard
                FocusManager.instance.primaryFocus?.unfocus();

                // Handle back button press
                Navigator.of(builderContext).pop();
              },
            );
          },
        ),
      ),
      body: (isLoading && _isConnected)
          ? Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.yellow],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : _isConnected
              ? Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green, Colors.yellow],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: name == null
                        ? const Center(
                            child: Text(
                              'Data not found',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                          ),
                                          color: Colors.blueGrey,
                                        ),
                                        padding: const EdgeInsets.all(16.0),
                                        child: const Text(
                                          'Your information is available, and we\'ll be in touch soon.',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text('Name'),
                                        subtitle: Text(name ?? 'N/A'),
                                      ),
                                      const Divider(thickness: 1),
                                      ListTile(
                                        title: const Text('Phone number'),
                                        subtitle: Text(phoneNumber ?? 'N/A'),
                                      ),
                                      const Divider(thickness: 1),
                                      ListTile(
                                        title: const Text('Email address'),
                                        subtitle: Text(email ?? 'N/A'),
                                      ),
                                      const Divider(thickness: 1),
                                      ListTile(
                                        title: const Text('Location'),
                                        subtitle: Text(city ?? 'N/A'),
                                      ),
                                      const Divider(thickness: 1),
                                      ListTile(
                                        title: const Text("Address"),
                                        subtitle: Text(address ?? 'N/A'),
                                      ),
                                      const Divider(thickness: 1),
                                      ListTile(
                                        title: const Text("Pin"),
                                        subtitle: Text(pin ?? 'N/A'),
                                      ),
                                      const Divider(thickness: 1),
                                      ListTile(
                                        title: const Text(
                                            'Ownership of House (Rented/Owned)'),
                                        subtitle: Text(gasType ?? 'N/A'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Clear the current focus to dismiss the keyboard
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      // Handle OK button press to go back
                                      Navigator.of(context).pop();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green),
                                    ),
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                )
              : Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green, Colors.yellow],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'No internet',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
    );
  }
}
