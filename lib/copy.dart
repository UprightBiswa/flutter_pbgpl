import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _firstNameController = TextEditingController();
  String _selectedLocation = 'Select';
  String _selectedGasType = 'Select';
  String _selectedPOIType = 'Select';
  bool isPhoneNumberVerified = false;
  bool isInformationLater = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PBGPL'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Banner
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/do.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Search for your existing connection here',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
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
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter your token here',
                                border: InputBorder
                                    .none, // Remove the default TextField border
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors
                                .green, // Set the background color to green
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                  6.0), // Curved top right corner
                              bottomRight: Radius.circular(
                                  6.0), // Curved bottom right corner
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Handle the search button click
                              // You can add the search functionality here
                              // Navigate to the SearchScreen with example data
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SearchScreen(
                                  name: 'Biswajit',
                                  phoneNumber: '9706904301',
                                  location: 'Guwahati',
                                  fatherOrHusbandName: 'Deuta Sinha',
                                  gasType: 'Owner',
                                ),
                              ));
                            },
                            child: const Text(
                              'Search',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                              selectionColor: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Container with project information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.green[200], // Background color
                        border: Border.all(
                          color: Colors.greenAccent, // Border color
                        ),
                        borderRadius:
                            BorderRadius.circular(0.0), // Border radius
                      ),
                      child: Text(
                        'Please fill up the form below',
                        style:
                            TextStyle(fontSize: 18.0, color: Colors.green[800]),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Form
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildInputField('Applicant\'s Name*', _firstNameController),
                    const SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _buildInputField(
                              'Phone Number*', TextEditingController(),
                              keyboardType: TextInputType.phone),
                        ),
                        const SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            // Handle phone number verification
                            isPhoneNumberVerified =
                                true; // Update this based on your verification logic

                            // Show the OTP verification dialog
                            showDialog(
                              context: context,
                              builder: (context) {
                                return showOTPdialog(context);
                              },
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors
                                .green), // Set the background color to green
                          ),
                          child: const Text(
                            'Verify',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Visibility(
                      visible:
                          isPhoneNumberVerified, // Show if phone number is verified
                      child: const Row(
                        children: [
                          Icon(
                            Icons.verified_user,
                            color: Colors.green,
                          ),
                          Text('Verified',
                              style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    _buildLocationDropdown(context),
                    const SizedBox(height: 10.0),
                    _buildInputField(
                        "Father's/Husband's Name*", TextEditingController()),
                    const SizedBox(height: 10.0),
                    _buildGasTypeDropdown(context),
                    const SizedBox(height: 10.0),
                    // _buildPOIDropdown(context),
                    // const SizedBox(
                    //   height: 10.0,
                    // ),
                    // _buildInputField('Enter ID here', TextEditingController(),
                    //     keyboardType: TextInputType.text),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: isInformationLater,
                                    onChanged: (value) {
                                      // Handle checkbox change to toggle container background color
                                      setState(() {
                                        isInformationLater = value!;
                                      });
                                    },
                                    fillColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return Colors
                                              .green; // Selected color (green)
                                        }
                                        return Colors
                                            .white; // Unselected color (grey)
                                      },
                                    ),
                                  ),
                                  const Text(
                                      "I wish to enter below information later"),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(
                                    16.0), // Add padding to the container
                                decoration: BoxDecoration(
                                  color: isInformationLater
                                      ? Colors.grey[400]
                                      : Colors
                                          .transparent, // Background color based on checkbox
                                  border: Border.all(
                                    color: Colors.grey, // Border color
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Border radius
                                ),
                                child: Column(
                                  children: [
                                    _buildPOIDropdown(context),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    _buildInputField('Enter ID here',
                                        TextEditingController(),
                                        keyboardType: TextInputType.text),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showSuccessDialog(context);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
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
  }

  Future<dynamic> showSuccessDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 48.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Token Number: 123456', // Replace with the actual token number
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  AlertDialog showOTPdialog(BuildContext context) {
    final List<TextEditingController> otpControllers =
        List.generate(6, (index) => TextEditingController());

    // Focus nodes for the OTP input fields
    final List<FocusNode> otpFocusNodes =
        List.generate(6, (index) => FocusNode());

    return AlertDialog(
      title: const Text(
        "Verify with OTP",
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Enter OTP sent on 9706904301"),
              const SizedBox(
                height: 10.0,
              ), // Replace with the actual phone number variable
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Container(
                    width: 40,
                    height: 40, // Adjust the size as needed
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: TextFormField(
                      controller: otpControllers[index],
                      focusNode: otpFocusNodes[index],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0, // Adjust the font size as needed
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          // Move focus to the next input field
                          otpFocusNodes[index].unfocus();
                          otpFocusNodes[index + 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle OTP verification
                  // Close the dialog if OTP is verified
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.green,
                  ), // Set the background color to green
                ),
                child: const Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String labelText, TextEditingController controller,
      {String? Function(String?)? validator, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        labelStyle: const TextStyle(
          fontSize: 16.0,
          color:Colors.green,
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }

  Widget _buildLocationDropdown(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Location*",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        labelStyle: const TextStyle(
          fontSize: 16.0,
          color: Colors.green,
        ),
      ),
      value: _selectedLocation,
      onChanged: (newValue) {
        setState(() {
          _selectedLocation = newValue!;
        });
      },
      items: [
        'Select',
        'Guwahati',
        'Silchar',
      ]
          .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
      // validator: (value) {
      //   if (value == 'Select') {
      //     return translation(context).please_select_a_location;
      //   }
      //   return null;
      // },
    );
  }

  Widget _buildGasTypeDropdown(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Gas Type*",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        labelStyle: const TextStyle(
          fontSize: 16.0,
          color: Colors.green,
        ),
      ),
      value: _selectedGasType,
      onChanged: (newValue) {
        setState(() {
          _selectedGasType = newValue!;
        });
      },
      items: [
        'Select',
        'Owner',
        'Rental',
      ]
          .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
      // validator: (value) {
      //   if (value == 'Select') {
      //     return translation(context).please_select_a_blood_group;
      //   }
      //   return null;
      // },
    );
  }

  Widget _buildPOIDropdown(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Proof Of Identity",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        labelStyle: const TextStyle(
          fontSize: 16.0,
          color: Colors.green,
        ),
      ),
      value: _selectedPOIType,
      onChanged: (newValue) {
        setState(() {
          _selectedPOIType = newValue!;
        });
      },
      items: [
        'Select',
        'Aadhaar',
        'PAN',
      ]
          .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
      // validator: (value) {
      //   if (value == 'Select') {
      //     return translation(context).please_select_a_blood_group;
      //   }
      //   return null;
      // },
    );
  }
}
// import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String location;
  final String fatherOrHusbandName;
  final String gasType;

  const SearchScreen({super.key, 
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.fatherOrHusbandName,
    required this.gasType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.yellow], // Adjust colors as needed
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('Name'),
                        subtitle: Text('Your name'),
                      ),
                      ListTile(
                        title: Text('Phone number'),
                        subtitle: Text('Your phone number'),
                      ),
                      ListTile(
                        title: Text('Location'),
                        subtitle: Text('Your location'),
                      ),
                      ListTile(
                        title: Text("Father's/Husband's name"),
                        subtitle: Text('Name'),
                      ),
                      ListTile(
                        title: Text('Gas Type'),
                        subtitle: Text('Gas type'),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Go back to the HomePage
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'dart:async'; // Import the 'dart:async' library for the Future.delayed method.
// import 'home_page.dart'; // Import your HomePage widget.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 2 seconds and then navigate to the homepage.
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // You can customize the splash screen as needed
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// class DevicesGridDashboard extends StatelessWidget {
//   const DevicesGridDashboard({
//     Key? key,
//     required this.size,
//   }) : super(key: key);

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(bottom: 15),
//             child: Text(
//               "Devices",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 17),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CardField(
//                   size,
//                   Colors.blue,
//                   Icon(
//                     Icons.camera_outlined,
//                     color: Colors.white,
//                   ),
//                   'Cameras',
//                   '8 Devices'),
//               CardField(
//                   size,
//                   Colors.amber,
//                   Icon(Icons.lightbulb_outline, color: Colors.white),
//                   'Lights',
//                   '8 Devices'),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CardField(
//                   size,
//                   Colors.orange,
//                   Icon(Icons.music_note_outlined, color: Colors.white),
//                   'Speakers',
//                   '2 Devices'),
//               CardField(
//                   size,
//                   Colors.teal,
//                   Icon(Icons.sports_cricket_sharp, color: Colors.white),
//                   'Cricket bat',
//                   '8 Devices'),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CardField(
//                   size,
//                   Colors.purple,
//                   Icon(Icons.wifi_outlined, color: Colors.white),
//                   'Sensors',
//                   '5 Devices'),
//               CardField(
//                   size,
//                   Colors.green,
//                   Icon(Icons.air_outlined, color: Colors.white),
//                   'Air Condition',
//                   '4 Devices'),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// CardField(
//   Size size,
//   Color color,
//   Icon icon,
//   String title,
//   String subtitle,
// ) {
//   return Padding(
//     padding: const EdgeInsets.all(2),
//     child: Card(
//         child: SizedBox(
//             height: size.height * .1,
//             width: size.width * .39,
//             child: Center(
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: color,
//                   child: icon,
//                 ),
//                 title: Text(
//                   title,
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14),
//                 ),
//                 subtitle: Text(
//                   subtitle,
//                   style: const TextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 13),
//                 ),
//               ),
//             ))),
//   );
// }




////
///
///
///
///
///
///
///
///
///
///
///
///

// import 'package:flutter/material.dart';

// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});

//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final TextEditingController _firstNameController = TextEditingController();
//   String _selectedLocation = 'Select';
//   String _selectedGasType = 'Select';
//   String _selectedPOIType = 'Select';
//   bool isPhoneNumberVerified = false;
//   bool isInformationLater = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30),
//       child: Form(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _buildInputField('Applicant\'s Name*', _firstNameController),
//             const SizedBox(height: 10.0),
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   child: _buildInputField(
//                     'Phone Number*',
//                     TextEditingController(),
//                     keyboardType: TextInputType.phone,
//                   ),
//                 ),
//                 const SizedBox(width: 10.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle phone number verification
//                     isPhoneNumberVerified =
//                         true; // Update this based on your verification logic

//                     // Show the OTP verification dialog
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return showOTPdialog(context);
//                       },
//                     );
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(Colors.green),
//                   ),
//                   child: const Text(
//                     'Verify',
//                     style: TextStyle(fontSize: 16.0, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 8.0,
//             ),
//             Visibility(
//               visible:
//                   isPhoneNumberVerified, // Show if the phone number is verified
//               child: const Row(
//                 children: [
//                   Icon(
//                     Icons.verified_user,
//                     color: Colors.green,
//                   ),
//                   Text('Verified', style: TextStyle(color: Colors.green)),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             _buildInputField(
//                 "Father's/Husband's Name*", TextEditingController()),
//             const SizedBox(height: 10.0),
//             _buildLocationDropdown(context),
//             const SizedBox(height: 10.0),
//             _buildGasTypeDropdown(context),
//             const SizedBox(height: 10.0),
//             Padding(
//               padding: const EdgeInsets.all(0.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: isInformationLater,
//                             onChanged: (value) {
//                               // Handle checkbox change to toggle container background color
//                               setState(() {
//                                 isInformationLater = value!;
//                               });
//                             },
//                             fillColor: MaterialStateProperty.resolveWith<Color>(
//                               (Set<MaterialState> states) {
//                                 if (states.contains(MaterialState.selected)) {
//                                   return Colors.green; // Selected color (green)
//                                 }
//                                 return Colors.red; // Unselected color (grey)
//                               },
//                             ),
//                           ),
//                           const Text("I wish to enter below information later"),
//                         ],
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(16.0),
//                         decoration: BoxDecoration(
//                           color: isInformationLater
//                               ? Colors.grey[400]
//                               : Colors.transparent,
//                           border: Border.all(
//                             color: Colors.grey,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Column(
//                           children: [
//                             _buildPOIDropdown(context),
//                             const SizedBox(
//                               height: 10.0,
//                             ),
//                             _buildInputField(
//                               'Enter ID here',
//                               TextEditingController(),
//                               keyboardType: TextInputType.text,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10.0,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 showSuccessDialog(context);
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.green),
//               ),
//               child: const Text(
//                 'Submit',
//                 style: TextStyle(fontSize: 16.0, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField(String labelText, TextEditingController controller,
//       {String? Function(String?)? validator, TextInputType? keyboardType}) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: labelText,
//         border: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(8.0),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(
//             Radius.circular(8.0),
//           ),
//           borderSide: BorderSide(color: Theme.of(context).primaryColor),
//         ),
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 16.0,
//           horizontal: 12.0,
//         ),
//         labelStyle: const TextStyle(
//           fontSize: 16.0,
//           color: Colors.green,
//         ),
//       ),
//       validator: validator,
//       keyboardType: keyboardType,
//     );
//   }

//   Widget _buildLocationDropdown(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         labelText: "Location*",
//         border: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(8.0),
//           ),
//           borderSide: BorderSide(color: Colors.green),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(
//             Radius.circular(8.0),
//           ),
//           borderSide: BorderSide(color: Theme.of(context).primaryColor),
//         ),
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 16.0,
//           horizontal: 12.0,
//         ),
//         labelStyle: const TextStyle(
//           fontSize: 16.0,
//           color: Colors.green,
//         ),
//       ),
//       value: _selectedLocation,
//       onChanged: (newValue) {
//         setState(() {
//           _selectedLocation = newValue!;
//         });
//       },
//       items: [
//         'Select',
//         'Guwahati',
//         'Silchar',
//       ]
//           .map<DropdownMenuItem<String>>(
//             (String value) => DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             ),
//           )
//           .toList(),
//       validator: (value) {
//         if (value == 'Select') {
//           return 'please_select_a_location';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildGasTypeDropdown(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         labelText: "Gas Type*",
//         border: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(8.0),
//           ),
//           borderSide: BorderSide(color: Colors.green),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(
//             Radius.circular(8.0),
//           ),
//           borderSide: BorderSide(color: Theme.of(context).primaryColor),
//         ),
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 16.0,
//           horizontal: 12.0,
//         ),
//         labelStyle: const TextStyle(
//           fontSize: 16.0,
//           color: Colors.green,
//         ),
//       ),
//       value: _selectedGasType,
//       onChanged: (newValue) {
//         setState(() {
//           _selectedGasType = newValue!;
//         });
//       },
//       items: [
//         'Select',
//         'Owner',
//         'Rental',
//       ]
//           .map<DropdownMenuItem<String>>(
//             (String value) => DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             ),
//           )
//           .toList(),
//       validator: (value) {
//         if (value == 'Select') {
//           return 'please_select_a_blood_group';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildPOIDropdown(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         labelText: "Proof Of Identity",
//         border: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(8.0),
//           ),
//           borderSide: BorderSide(color: Colors.green),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(
//             Radius.circular(8.0),
//           ),
//           borderSide: BorderSide(color: Theme.of(context).primaryColor),
//         ),
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 16.0,
//           horizontal: 12.0,
//         ),
//         labelStyle: const TextStyle(
//           fontSize: 16.0,
//           color: Colors.green,
//         ),
//       ),
//       value: _selectedPOIType,
//       onChanged: (newValue) {
//         setState(() {
//           _selectedPOIType = newValue!;
//         });
//       },
//       items: [
//         'Select',
//         'Aadhaar',
//         'PAN',
//       ]
//           .map<DropdownMenuItem<String>>(
//             (String value) => DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             ),
//           )
//           .toList(),
//       validator: (value) {
//         if (value == 'Select') {
//           return 'please_select_a_blood_group';
//         }
//         return null;
//       },
//     );
//   }

//   Future<dynamic> showSuccessDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(
//                 Icons.check_circle,
//                 color: Colors.green,
//                 size: 48.0,
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               const Text(
//                 'Token Number: 123456', // Replace with the actual token number
//                 style: TextStyle(fontSize: 18.0),
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.green),
//                 ),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   AlertDialog showOTPdialog(BuildContext context) {
//     final List<TextEditingController> otpControllers =
//         List.generate(6, (index) => TextEditingController());

//     // Focus nodes for the OTP input fields
//     final List<FocusNode> otpFocusNodes =
//         List.generate(6, (index) => FocusNode());

//     return AlertDialog(
//       title: const Text(
//         "Verify with OTP",
//         style: TextStyle(
//           fontSize: 18.0,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       content: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text("Enter OTP sent on 9706904301"),
//               const SizedBox(
//                 height: 10.0,
//               ), // Replace with the actual phone number variable
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(6, (index) {
//                   return Container(
//                     width: 40,
//                     height: 40, // Adjust the size as needed
//                     margin: const EdgeInsets.symmetric(horizontal: 4),
//                     child: TextFormField(
//                       controller: otpControllers[index],
//                       focusNode: otpFocusNodes[index],
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.number,
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 16.0, // Adjust the font size as needed
//                       ),
//                       onChanged: (value) {
//                         if (value.isNotEmpty && index < 5) {
//                           // Move focus to the next input field
//                           otpFocusNodes[index].unfocus();
//                           otpFocusNodes[index + 1].requestFocus();
//                         }
//                       },
//                     ),
//                   );
//                 }),
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle OTP verification
//                   // Close the dialog if OTP is verified
//                   Navigator.of(context).pop();
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(
//                     Colors.green,
//                   ), // Set the background color to green
//                 ),
//                 child: const Text('Verify'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
