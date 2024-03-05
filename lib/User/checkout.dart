import 'dart:convert';

import 'package:event_management/User/User_Home_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';
import '../notification_services.dart';



// Replace these images with your actual app logo and payment icons
// const logoImage = 'assets/images/logo.png';
const creditCardImage = 'assets/credit-card.png';
// const paypalImage = 'assets/paypal.png';
const applePayImage = 'assets/apple-pay.png';
const googlePayImage = 'assets/google-pay.png';

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

String? orgId; // Global variable to store the organizer ID

class CheckoutPage extends StatefulWidget {
  final String id;
  final String event_name;
  final String event_price;
  final String count;
  CheckoutPage({
    required this.id,
    required this.event_name,
    required this.event_price,
    required this.count,
  });
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}


class _CheckoutPageState extends State<CheckoutPage> {

  NotificationServices notificationsServices = new NotificationServices();
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now().toLocal());


  // String? orgId; // Global variable to store the organizer ID

  Future<void> retrieveOrgId(String event_type, String event_name) async {
    try {
      // Make a POST request to the organizer API endpoint
      final orgResponse = await http.post(
        Uri.parse('$ip_address/Event_Management/User/org.php'),
        body: {
          'event_type': event_type,
          'event_name': widget.event_name,
        },
      );

      // Check the response status
      if (orgResponse.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> orgData = json.decode(orgResponse.body);

        // Check if the 'uid' key exists in the response
        if (orgData.containsKey('uid')) {
          // Store the organizer ID in the global variable 'orgId'
          orgId = orgData['uid'];
          print('Organizer ID: $orgId');
          print(formattedDate);
        } else {
          // Handle the case when 'uid' key is not found in the response
          print('Organizer ID not found in the response');
        }
      } else {
        // Handle the case when the organizer API request fails
        print('Error fetching organizer info: ${orgResponse.body}');
      }
    } catch (error) {
      // Handle network errors or other exceptions
      print('Error fetching organizer info: $error');
    }
  }


  Widget buildLottieAnimation() {
    return Container(
      height: 200, // Adjust the height as needed
      width: 200, // Adjust the width as needed
      child: Lottie.asset('assets/thanks.json'),
    );
  }
  // Define variables for payment method selection and input fields
  int _selectedPaymentMethod = 0;
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDate = TextEditingController();
  TextEditingController _cvv = TextEditingController();
  // var _paypalEmail = '';
  TextEditingController _upiId = TextEditingController();
  TextEditingController _billingAddress = TextEditingController();
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );
  final RegExp _upiIdRegExp = RegExp(
    r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+$',
  );

  late List<Map<String, String>> _items;

  @override
  void initState() {
    retrieveOrgId(event_type, widget.event_name);
    super.initState();
    notificationsServices.initializeNotification();

    _items = [
      {'name': widget.event_name, 'price': widget.event_price},
      // {'name': 'Item 2', 'price': '5.00'},
    ];
  }

  String convertCardNumber(String src, String divider) {
    String newStr = '';
    int step = 4;
    for (int i = 0; i < src.length; i += step) {
      newStr += src.substring(i, math.min(i + step, src.length));
      if (i + step < src.length) newStr += divider;
    }
    return newStr;
  }

  String convertMonthYear(String month) {
    if (month.isNotEmpty) {
      // Ensure the input has at least two characters for the month
      String inputMonth = month.substring(0, math.min(2, month.length));

      // Check if there are more than two characters for the year
      if (month.length > 2) {
        String inputYear = month.substring(2);
        return '$inputMonth/$inputYear';
      } else {
        return inputMonth;
      }
    } else {
      return '';
    }
  }

  // Define a list of items for the order summary
  // List<Map<String, String>> _items = [
  //   {'name': widget.event_name, 'price': '10.00'},
  //   {'name': 'Item 2', 'price': '5.00'},
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),




              // App Logo and Page Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Payment',
                        style: TextStyle(
                          color: Theme
                              .of(context)
                              .brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CloseButton()
                  ],
                ),
              ),

              // Payment Method Selection
              SizedBox(height: 20.0),
              Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,

                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding:
                const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Colors.grey.shade800
                      : Colors.white,
                  boxShadow: shadow,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    buildPaymentMethodTile(0, creditCardImage, 'Credit/Debit Card'),
                    // buildPaymentMethodTile(1, paypalImage, 'PayPal'),
                    // buildPaymentMethodTile(2, applePayImage, 'Apple Pay'),
                    buildPaymentMethodTile(1, googlePayImage, 'Google Pay'),
                  ],
                ),
              ),

              // Payment Details based on selected method
              SizedBox(height: 20.0),
              Text(
                'Enter Payment Details',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                ),
              ),
              if (_selectedPaymentMethod == 0) buildCreditCardDetails(),
              // if (_selectedPaymentMethod == 1) buildPayPalDetails(),
              if (_selectedPaymentMethod == 1) buildGPayDetails(),

              // Billing Address (Optional)
              SizedBox(height: 20.0),
              Text(
                'Billing Address (Optional)',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                ),
              ),
              buildBillingAddressField(),

              // Order Summary
              SizedBox(height: 20.0),
              Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(16.0),
                  padding:
                  const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .brightness == Brightness.dark
                        ? Colors.grey.shade800
                        : Colors.white,
                    boxShadow: shadow,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: buildOrderSummary()
              ),

              // Payment Button
              SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Validate the form before processing the payment
                    if (_validateForm()) {
                      // Show the Lottie animation
                      notificationsServices.sendNotification('Ticket Purchased Successfully!🎉', 'Ticekt Purchased Successfully, Get deails on Your Orders page🎉');
                      showDialog(
                        context: context,
                        barrierDismissible: false, // Prevent dismissing on tap
                        builder: (context) => AlertDialog(
                          content: buildLottieAnimation(),
                        ),
                      );
                      // Simulate a delay (replace this with your actual payment processing)
                      Future.delayed(Duration(seconds: 3), () {
                        // Close the Lottie animation dialog
                        Navigator.pop(context);

                        // Navigate back to the previous page
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(
                            builder: (context) => User_HomePage(),
                          ),);
                      });
                      DateTime previousDate = DateTime.parse(formattedDate).subtract(Duration(days: 1));

                      // Schedule notification for the previous date at 10 AM
                      notificationsServices.scheduleDateNotification(
                        'Reminder!',
                        'Your event is tomorrow! Don\'t forget to attend.',
                        DateTime(previousDate.year, previousDate.month, previousDate.day, 10, 0),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme
                        .of(context)
                        .primaryColor,
                    // Choose appropriate colors for dark and light mode
                    onPrimary: Colors.white,
                    // Text color
                    padding: EdgeInsets.symmetric(
                        horizontal: 29, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text('Pay Now',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentMethodTile(int value, String image, String text) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: _selectedPaymentMethod,
          onChanged: (val) =>

              setState(() => _selectedPaymentMethod = val as int
              ),
        ),
        Container(
        height: 20,
        width: 20,
        child: Image.asset(image)),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget buildCreditCardDetails() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding:
      const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .brightness == Brightness.dark
            ? Colors.grey.shade800
            : Colors.white,
        boxShadow: shadow,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10,),
          TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(19),
              FilteringTextInputFormatter.digitsOnly,
              TextInputFormatter.withFunction(
                    (oldValue, newValue) {
                  return TextEditingValue(
                    text: convertCardNumber(newValue.text, '-'),
                    // selection: newValue.selection,
                  );
                },
              ),
            ],
            controller: _cardNumberController,

            decoration: InputDecoration(
              hintText: 'Card Number',
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5),
                    FilteringTextInputFormatter.digitsOnly,
                    TextInputFormatter.withFunction(
                          (oldValue, newValue) {
                        return TextEditingValue(
                          text: convertMonthYear(newValue.text),
                          // selection: newValue.selection,
                        );
                      },
                    ),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Expiry Date (MM/YY)',
                  ),
                  onChanged: (value) => setState(() => _expiryDate.text = value),
                  keyboardType: TextInputType.datetime,
                  controller: _expiryDate,
                ),
              ),

              SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    hintText: 'CVV',
                  ),
                  onChanged: (value) => setState(() => _cvv.text = value),
                  keyboardType: TextInputType.number,
                  controller: _cvv,
                ),
              ),
              SizedBox(height: 10,)
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  // Widget buildPayPalDetails() {
  //   return Container(
  //     margin: const EdgeInsets.all(10.0),
  //     padding:
  //     const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
  //     decoration: BoxDecoration(
  //       color: Theme
  //           .of(context)
  //           .brightness == Brightness.dark
  //           ? Colors.grey.shade800
  //           : Colors.white,
  //       boxShadow: shadow,
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(10),
  //         topRight: Radius.circular(10),
  //         bottomLeft: Radius.circular(10),
  //         bottomRight: Radius.circular(10),
  //       ),
  //     ),
  //     child: Column(
  //       children: [
  //         SizedBox(height: 10,),
  //         // TextField(
  //         //   decoration: InputDecoration(
  //         //     hintText: 'PayPal Email',
  //         //     errorText: (_paypalEmail.isNotEmpty && !_emailRegExp.hasMatch(_paypalEmail))
  //         //         ? 'Enter a valid email'
  //         //         : null,
  //         //   ),
  //         //   onChanged: (value) => setState(() => _paypalEmail = value),
  //         // ),
  //         SizedBox(height: 10,),
  //       ],
  //     ),
  //   );
  // }

  Widget buildGPayDetails() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding:
      const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .brightness == Brightness.dark
            ? Colors.grey.shade800
            : Colors.white,
        boxShadow: shadow,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10,),
          TextField(
            decoration: InputDecoration(
              hintText: 'UPI ID',
              errorText: (_upiId.text.isNotEmpty && !_upiIdRegExp.hasMatch(_upiId.text))
                  ? 'Enter a valid UPI ID'
                  : null,
            ),
            onChanged: (value) {
              setState(() {
                _upiId.text = value;
              });
            },
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }


  Widget buildBillingAddressField() {
    return TextField(
      maxLines: null,
      decoration: InputDecoration(
        hintText: 'Billing Address',
      ),
      onChanged: (value) => setState(() => _billingAddress.text = value),
    );
  }

  Widget buildOrderSummary() {
    return Container(
      child: Column(
        children: _items
            .map(
              (item) => ListTile(
            title: Text(item['name']!),
                trailing: Text('₹ ' + NumberFormat('#,##,##0').format(double.parse(item['price']!)), style: TextStyle(fontSize: 16),),
          ),
        )
            .toList(),
      ),
    );
  }

  bool _validateForm() {
    Map<String, String> paymentData = {
      'uid': user_Id,
      'name': username_user,
      'price': widget.event_price,
      'eventId': widget.id,
      'eventName' : widget.event_name,
      'billing': _billingAddress.text,
      'quantity':widget.count,
      'orgid': orgId ?? '',
      'event_type':event_type,
      'purchase_date':formattedDate,
    };

    // Validate if payment method is selected
    if (_selectedPaymentMethod < 0) {
      // Show error message for payment method selection
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a payment method.'),
        ),
      );
      return false;
    }

    // Validate credit card details if selected
    if (_selectedPaymentMethod == 0) {
      if (_cardNumberController.text.isEmpty ||
          _expiryDate.text.isEmpty ||
          _cvv.text.isEmpty) {
        // Show error message for credit card details
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill in all credit card details.'),
          ),
        );
        return false;
      }
    }

    // Validate UPI ID if Google Pay is selected
    if (_selectedPaymentMethod == 1) {
      if (_upiId.text.isEmpty) {
        // Show error message for UPI ID
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a UPI ID.'),
          ),
        );
        return false;
      }
    }


    if (_billingAddress.text.isNotEmpty) {
      paymentData['billing'] = _billingAddress.text;
    } else {
      // If billing address is blank, set it to "0"
      paymentData['billing'] = '0';
    }

    if (_selectedPaymentMethod == 0) {
      // Validate credit card details
      if (_cardNumberController.text.length < 16 ||
          _expiryDate.text.isEmpty ||
          (_cvv != null && _cvv.text.length < 3)) {
        // Show error message or handle validation accordingly
        print('Invalid credit card details!');
        return false;
      }

      // Add credit card details to payment data
      paymentData.addAll({
        'payment_method': 'credit_card',
        'card_number': _cardNumberController.text,
        'expiry': _expiryDate.text,
        'cvv': _cvv.text,
        'upi_id': '0',
      });
    } else if (_selectedPaymentMethod == 1) {
      // Validate Google Pay details
      if (_upiId.text.isEmpty || !_upiIdRegExp.hasMatch(_upiId.text)) {
        // Show error message or handle validation accordingly
        print('Invalid UPI details!');
        return false;
      }

      // Add Google Pay details to payment data
      paymentData.addAll({
        'payment_method': 'google_pay',
        'card_number': '0',
        'expiry': '0',
        'cvv': '0',
        'upi_id': _upiId.text,
      });
    }

    // Add additional validations if needed

    // Make the POST request
    _makePaymentRequest(paymentData);

    return true;
  }

  // Future<void> _makePaymentRequest(Map<String, String> paymentData) async {
  //   try {
  //     // Make a POST request to the server
  //     final response = await http.post(
  //       Uri.parse('$ip_address/Event_Management/User/payment.php'),
  //       body: paymentData,
  //     );
  //
  //     // Check the response status
  //     if (response.statusCode == 200) {
  //       // Payment successful, handle the response accordingly
  //       print('Payment Successful!');
  //       print(response.body);
  //     } else {
  //       // Payment failed, handle the response accordingly
  //       print('Payment Failed!');
  //       print(response.body);
  //     }
  //   } catch (error) {
  //     // Handle network errors or other exceptions
  //     print('Error making payment request: $error');
  //   }
  // }

  Future<void> _makePaymentRequest(Map<String, String> paymentData) async {
    try {
      // Make a POST request to the server
      final response = await http.post(
        Uri.parse('$ip_address/Event_Management/User/payment.php'),
        body: paymentData,
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Payment successful, handle the response accordingly
        print('Payment Successful!');
        print('Organizer ID: $orgId');
        print(response.body);

        // Parse the JSON response
        Map<String, dynamic> responseData = json.decode(response.body);

        // Check if the 'uid' key exists in the response
        if (responseData.containsKey('uid')) {
          // Store the organizer ID in the 'orgId' variable
          String orgId = responseData['uid'];

          // You can now use 'orgId' as needed
          print('Organizer ID: $orgId');

          // Use the organizer ID to fetch additional information
          await _fetchOrganizerInfo(orgId);
        } else {
          // Handle the case when 'uid' key is not found in the response
          print('Organizer ID not found in the response');
        }
      } else {
        // Payment failed, handle the response accordingly
        print('Payment Failed!');
        print(response.body);
      }
    } catch (error) {
      // Handle network errors or other exceptions
      print('Error making payment request: $error');
    }
  }

  Future<void> _fetchOrganizerInfo(String orgId) async {
    try {
      // Make a POST request to the organizer API endpoint
      final orgResponse = await http.post(
        Uri.parse('$ip_address/Event_Management/User/org.php'),
        body: {'orgId': orgId},
      );

      // Check the response status
      if (orgResponse.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> orgData = json.decode(orgResponse.body);

        // Handle the organizer data as needed
        print('Organizer Info: $orgData');
      } else {
        // Handle the case when the organizer API request fails
        print('Error fetching organizer info: ${orgResponse.body}');
      }
    } catch (error) {
      // Handle network errors or other exceptions
      print('Error fetching organizer info: $error');
    }
  }


}

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    Key? key,
    required Widget content,
    SnackBarAction? action,
  }) : super(
    key: key,
    content: content,
    action: action,
    backgroundColor: Colors.transparent, // Set the background color to transparent
    elevation: 0, // Remove elevation
    behavior: SnackBarBehavior.floating, // Make it floating
  );
}
