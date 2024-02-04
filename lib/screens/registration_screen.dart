
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pinNoController = TextEditingController();
  final TextEditingController _imagePathController = TextEditingController();
  final TextEditingController _pdfPathController = TextEditingController();
  final TextEditingController _agentNameController = TextEditingController();

  String _selectedLocation = 'Select';
  String _selectedGasType = 'Select';
  bool isLoading = false;

  File? _selectedFilePath;
  File? _image;
  File? _pdf;
  String? errorPhoneNo;
  Future<bool> checkInternetConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputField(
              'Applicant\'s Name*',
              _firstNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                if (RegExp(r'[0-9]').hasMatch(value)) {
                  return 'Name must contain only letters';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            _buildInputField(
              'Phone Number*', // Maximum of 10 digits
              _phoneNoController,
              keyboardType: TextInputType.phone,
              maxLines: 1,
              validator: (value) {
                if (value != null) {
                  if (value.length != 10 || int.tryParse(value) == null) {
                    return 'Phone number must be 10 digits';
                  }
                } else {
                  return 'Phone number is required';
                }
                return null;
              },
            ),
            if (errorPhoneNo != null)
              Text(
                errorPhoneNo!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 10.0),
            _buildInputField(
              'Email (optional)',
              _emailController,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (!_isValidEmail(value)) {
                    return 'Invalid email format';
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            _buildLocationDropdown(context),
            const SizedBox(height: 10.0),
            _buildInputField(
              'Address*',
              _addressController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Address is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            _buildInputField(
              'Pin No*',
              _pinNoController,
              keyboardType: TextInputType.number,
              maxLines: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pin No is required';
                }
                if (value.length != 6) {
                  return 'Pin No must be exactly 6 digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            _buildGasTypeDropdown(context),
            const SizedBox(height: 10.0),
            _buildInputField(
              'Agent Name',
              _agentNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null; // Agent Name is nullable based on user preference
                }
                if (value.length > 30) {
                  return 'Agent Name must be less than 30 characters';
                }
                if (RegExp(r'[0-9]').hasMatch(value)) {
                  return 'Agent Name must contain only letters';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              // Wrapping the Row with a Container
              decoration: BoxDecoration(
                color: Colors.green[200], // Background color
                border: Border.all(
                  color: Colors.greenAccent, // Border color
                ),
                borderRadius: BorderRadius.circular(8.0), // Border radius
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white24,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Attachment* (Aadhar Card/Driving License/Ration Card/Voter ID/Passport) *',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                          CustomButton(
                            onPressed: _showAttachmentDialog,
                            text: 'Attachment',
                            icon: Icons.upload_file_outlined,
                          ),
                          const Text(
                            'Please upload a valid image (jpeg/png) or pdf file. Size should not be more than 5MB.',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12, // Background color
                  border: Border.all(
                    color: Colors.greenAccent, // Border color
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Center(
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.contain,
                              width: 100.0,
                              height: 100.0,
                            )
                          : _pdf != null
                              ? Center(
                                  child: Text('Picked PDF: ${_pdf!.path}'),
                                )
                              : const SizedBox.shrink(),
                    ),
                    if (_image != null || _pdf != null)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _image = null;
                            _pdf = null;
                            _selectedFilePath = null;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity, // Make the button full width
              child: ElevatedButton(
                onPressed: isLoading ? null : _submitForm,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: isLoading
                    ? const CircularProgressIndicator() // Show loading indicator
                    : const Text(
                        'Submit',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAttachmentDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select Attachment Type',
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _pickFile(ImageSource.gallery);
                      },
                      text: 'Gallery',
                      icon: Icons.mobile_friendly,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _pickFile(ImageSource.camera);
                      },
                      text: 'Camera',
                      icon: Icons.camera,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8), // Adjust the spacing as needed
              CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pickPDF();
                },
                icon: Icons.file_copy,
                text: 'Pick PDF',
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickFile(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imagePathController.text = _image!.path;
        _selectedFilePath = _image!;
        _pdf = null;
      });
    }
  }

  Future<void> _pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _pdfPathController.text = result.files.single.path?.trim() ?? '';
          _pdf = File(result.files.single.path?.trim() ?? '');
          _selectedFilePath = _pdf!;
          _image = null;
          print(' picking PDF file: $_selectedFilePath');
        });
      }
    } catch (e) {
      print('Error picking PDF file: $e');
    }
  }

  bool _isValidEmail(String value) {
    // You can use a regular expression to validate the email format.
    // This is a simple example, and you can adjust it as needed.
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,})$');
    return emailRegex.hasMatch(value);
  }

  void _submitForm() async {
    final isInternetConnected = await checkInternetConnectivity();

    if (!isInternetConnected) {
      showSnackbar(context, 'No internet connection');
      return;
    }

    if (_formKey.currentState!.validate()) {
      // Form is valid, set loading to true
      if (_selectedFilePath == null) {
        showSnackbar(context, 'Please upload an attachment');
        return;
      }
      setState(() {
        isLoading = true;
      });

      // Form is valid, proceed with the submission
      _sendFormDataToApi();
    }
  }

  // void _sendFormDataToApi() {
  //   // Create a Map to store the form data
  //   final Map<String, dynamic> formData = {
  //     'name': _firstNameController.text,
  //     'phone_no': _phoneNoController.text,
  //     'email': _emailController.text.isNotEmpty ? _emailController.text : '',
  //     'location': _selectedLocation,
  //     'gas_type': _selectedGasType,
  //     'pin': _pinNoController.text,
  //     'address': _addressController.text,
  //   };

  //   // Log the input data
  //   print('Input Data: $formData');

  //   // Send the data to the API
  //   final Uri apiEndpoint =
  //       Uri.parse('https://pbg.indigidigital.in/api/register');
  //   http.post(apiEndpoint, body: formData).then((response) {
  //     // Log the API response
  //     print('API Response: ${response.body}');

  //     // Reset loading state
  //     setState(() {
  //       isLoading = false;
  //     });

  //     if (response.statusCode == 200) {
  //       // Successful API call
  //       final responseData = json.decode(response.body);

  //       if (responseData["success"] == true &&
  //           responseData.containsKey("token")) {
  //         // Token response
  //         final token = responseData["token"];

  //         // Log the success message and token
  //         print('Success Message: Thank you for your interest.');
  //         print('Token: $token');

  //         // Show success dialog
  //         showSuccessDialog(context, "Token Number: $token");

  //         // Clear input fields after submission (except for Email and Location)
  //         _firstNameController.clear();
  //         _phoneNoController.clear();
  //         _emailController.clear();
  //         _addressController.clear();
  //         _pinNoController.clear();
  //         _selectedLocation = 'Select';
  //         _selectedGasType = 'Select';
  //         setState(() {
  //           errorPhoneNo = null; // Reset phone number error
  //         });
  //       } else if (responseData["success"] == false &&
  //           responseData.containsKey("message")) {
  //         // Message response
  //         final message = responseData["message"];

  //         // Log the error message
  //         print('Error Message: $message');

  //         // Show error message
  //         showSnackbar(context, message);
  //       }
  //     } else if (response.statusCode == 422) {
  //       // Validation errors
  //       final responseData = json.decode(response.body);
  //       final errors = responseData["msg"];

  //       if (errors is Map && errors.containsKey("phone_no")) {
  //         // Set the phone number error message
  //         setState(() {
  //           errorPhoneNo = errors["phone_no"][0];
  //         });
  //       } else {
  //         setState(() {
  //           errorPhoneNo = null; // Reset phone number error
  //         });
  //       }

  //       // Handle validation errors here, e.g., show error messages to the user
  //     } else {
  //       // Handle other errors here, e.g., show a generic error message to the user
  //     }
  //   });
  // }
  void _sendFormDataToApi() async {
    // Check if a file is selected
    if (_selectedFilePath != null) {
      // Create a multipart request
      final http.MultipartRequest request = http.MultipartRequest(
          'POST', Uri.parse('https://pbg.indigidigital.in/api/register'));
// Add headers
      request.headers['Content-Type'] = 'multipart/form-data';
      // Add existing form data fields to the request
      request.fields['name'] = _firstNameController.text;
      request.fields['phone_no'] = _phoneNoController.text;
      request.fields['email'] =
          _emailController.text.isNotEmpty ? _emailController.text : '';
      request.fields['location'] = _selectedLocation;
      request.fields['gas_type'] = _selectedGasType;
      request.fields['pin'] = _pinNoController.text;
      request.fields['address'] = _addressController.text;
      request.fields['agent_name'] = _agentNameController.text;

      String originalFilename = _selectedFilePath!.path
          .split('/')
          .last; // Assumes '/' is the path separator
      // Add the file to the request
      request.files.add(
        http.MultipartFile.fromBytes(
          'attachment',
          await _selectedFilePath!.readAsBytes(),
          filename: originalFilename, // Provide a filename for the file
        ),
      );

      try {
        // Send the request
        final http.Response response =
            await http.Response.fromStream(await request.send());

        // Handle the response as needed
        if (response.statusCode == 200) {
          // Successful response, handle accordingly
          final responseData = json.decode(response.body);

          if (responseData["success"] == true &&
              responseData.containsKey("token")) {
            // Token response
            final token = responseData["token"];

            // Log the success message and token
            print('Success Message: Thank you for your interest.');
            print('Token: $token');

            // Show success dialog
            showSuccessDialog(context, "Token Number: $token");

            // Clear input fields after submission (except for Email and Location)
            _firstNameController.clear();
            _phoneNoController.clear();
            _emailController.clear();
            _addressController.clear();
            _pinNoController.clear();
            _selectedLocation = 'Select';
            _imagePathController.clear();
            _pdfPathController.clear();
            _selectedFilePath = null;
            _selectedGasType = 'Select';
            setState(() {
              errorPhoneNo = null; // Reset phone number error
            });
          } else if (responseData["success"] == false &&
              responseData.containsKey("message")) {
            // Message response
            final message = responseData["message"];

            // Log the error message
            print('Error Message: $message');

            // Show error message
            showSnackbar(context, message);
          }
        } else if (response.statusCode == 422) {
          // Validation errors
          final responseData = json.decode(response.body);
          final errors = responseData["msg"];

          if (errors is Map && errors.containsKey("phone_no")) {
            // Set the phone number error message
            setState(() {
              errorPhoneNo = errors["phone_no"][0];
            });
          } else {
            setState(() {
              errorPhoneNo = null; // Reset phone number error
            });
          }

          // Handle validation errors here, e.g., show error messages to the user
        } else {
          // Handle other errors here, e.g., show a generic error message to the user
        }
      } catch (error) {
        // Handle any exceptions during the request
        print('Error sending API request: $error');
      } finally {
        // Reset loading state
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // File is not selected, proceed without attaching the file
      showSnackbar(context, 'Please select a file');
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildInputField(
    String labelText,
    TextEditingController controller, {
    TextInputType? keyboardType,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
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
          color: Colors.green,
        ),
      ),
      validator: (value) {
        if (validator != null) {
          final customError = validator(value);
          if (customError != null) {
            return customError;
          }
        }
        return null;
      },
      keyboardType: keyboardType,
      inputFormatters: (maxLines != null && maxLines > 1)
          ? [LengthLimitingTextInputFormatter(maxLines * 50)]
          : [LengthLimitingTextInputFormatter(50)],
    );
  }

  Widget _buildLocationDropdown(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "City*",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
      validator: (value) {
        if (value == 'Select') {
          return 'This field is required.';
        }
        return null;
      },
    );
  }

  Widget _buildGasTypeDropdown(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Ownership of House (Rented/Owned)*",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
      validator: (value) {
        if (value == 'Select') {
          return 'This field is required.';
        }
        return null;
      },
    );
  }

  Future<void> showSuccessDialog(BuildContext context, String data) async {
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Thank you for your interest. Our representative will contact you soon!',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                color: Colors.green[200],
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  data,
                  style: const TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
}

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.green,
      child: MaterialButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
