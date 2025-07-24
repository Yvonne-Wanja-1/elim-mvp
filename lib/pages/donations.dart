import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elim_trust_2/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'stk_push_page.dart';

class DonationsPage extends StatefulWidget {
  const DonationsPage({super.key});

  @override
  State<DonationsPage> createState() => _DonationsPageState();
}

class _DonationsPageState extends State<DonationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String? _selectedPaymentMethod; // To keep track of the selected radio button
  final TextEditingController _emailController =
      TextEditingController(); // Controller for email input
  final TextEditingController _namecontroller =
      TextEditingController(); // Controller for name input
  final TextEditingController _confirmemailController =
      TextEditingController(); // Controller for confirm email input
  final TextEditingController _otherAmountController = TextEditingController();
  String? _otherAmountErrorText;
  int _selectedIndex = 1; // Variable to track the selected index for navigation

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Duration of one wave cycle
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut), // Smooth ease-in/out curve
    );
    _selectedPaymentMethod = null; // Initialize with no selection
  }

//credit card
  void _showCreditCardDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Enter Card Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              //fontSize: 20,
              fontStyle: FontStyle.italic,
              fontFamily: 'Arial',
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.credit_card, color: Colors.blue),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Expiry Date (MM/YY)',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  keyboardType: TextInputType.datetime,
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'CVV',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child:
                    const Text('Cancel', style: TextStyle(color: Colors.blue)),
                onPressed: () => Navigator.of(context).pop()),
            TextButton(
                child:
                    const Text('Submit', style: TextStyle(color: Colors.blue)),
                onPressed: () {}),
          ],
        );
      },
    );
  }

  void _handleMpesaPayment() {
    setState(() {
      _selectedPaymentMethod = 'mpesa';
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            STKPushPage(initialAmount: _otherAmountController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: AppBar(
              title: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset:
                        Offset(0, _animation.value), // Centered vertical offset
                    child: const Text(
                      '❤️Donations❤️',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              centerTitle: true,
              backgroundColor: Colors.blue,
              elevation: 2,
              leading: Container(
                margin: const EdgeInsets.all(10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Badge(
                        alignment: Alignment.topRight,
                        label: const Center(
                          child: Text(
                            '3',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        backgroundColor: Colors.red,
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 12),
                        child: IconButton(
                          icon: const Icon(Icons.notifications,
                              color: Colors.blue),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            Navigator.pushNamed(context, '/notifications');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics:
              const BouncingScrollPhysics(), // This enables the bouncing effect
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'How would you like to contribute?',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Monetary Contributions:',
                textAlign: TextAlign.left,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                  decorationThickness: 2.0,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your donations help us continue our mission and support those in need. Every contribution counts, no matter how small.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Arial',
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: Color.fromARGB(255, 120, 165, 201),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _otherAmountController.text = '100';
                          });
                        },
                        child: const Text('100 KES',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _otherAmountController.text = '200';
                          });
                        },
                        child: const Text('200 KES',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _otherAmountController.text = '500';
                          });
                        },
                        child: const Text('500 KES',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _otherAmountController.text = '1000';
                          });
                        },
                        child: const Text('1000 KES',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: TextField(
                  controller: _otherAmountController,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.monetization_on, color: Colors.blue),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Other Amount',
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'eg. 75,000 KES',
                    hintStyle: const TextStyle(color: Colors.grey),
                    errorText: _otherAmountErrorText,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // Using an if statement to validate the input
                    if (value.isEmpty) {
                      // If the field is empty, clear any previous error.
                      setState(() => _otherAmountErrorText = null);
                      return;
                    }
                    // This regular expression checks if the string contains only digits 0-9.
                    final isDigitsOnly = RegExp(r'^[0-9]+$').hasMatch(value);
                    setState(() {
                      _otherAmountErrorText =
                          isDigitsOnly ? null : 'Please enter only numbers.';
                    });
                  },
                  onSubmitted: (value) {
                    // Handle custom donation amount
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Payment Methods:',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

//debit/credit card
              Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  onTap: () {
                    setState(() => _selectedPaymentMethod = 'card');
                    _showCreditCardDialog();
                  },
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset('images/card.png',
                        fit: BoxFit.cover, color: Colors.blue),
                  ),
                  title: const Center(
                    child: Text(
                      'Credit/Debit Card',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  subtitle: const Center(
                    child: Text(
                      'Secure payment via visa, mastercard, etc.',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Arial',
                          color: Color.fromARGB(255, 107, 162, 207)),
                    ),
                  ),
                  trailing: Radio<String>(
                    value: 'card', // Unique value for Credit/Debit Card
                    groupValue: _selectedPaymentMethod,
                    activeColor: Colors.blue,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                      if (value == 'card') {
                        _showCreditCardDialog();
                      }
                    },
                  ),
                ),
              ),

//paypal
              Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  onTap: () =>
                      setState(() => _selectedPaymentMethod = 'paypal'),
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'images/paypal.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: const Center(
                    child: Text(
                      'PayPal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  subtitle: const Center(
                    child: Text(
                      'Secure payment via PayPal ',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Arial',
                          color: Color.fromARGB(255, 107, 162, 207)),
                    ),
                  ),
                  trailing: Radio<String>(
                    value: 'paypal', // Unique value for PayPal
                    groupValue: _selectedPaymentMethod,
                    activeColor: Colors.blue,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    },
                  ),
                ),
              ),

              Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  onTap: () =>
                      setState(() => _selectedPaymentMethod = 'applepay'),
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'images/applepay.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: const Center(
                    child: Text(
                      'Apple Pay',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  subtitle: const Center(
                    child: Text(
                      'Secure payment via Apple Pay',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Arial',
                          color: Color.fromARGB(255, 107, 162, 207)),
                    ),
                  ),
                  trailing: Radio<String>(
                    value: 'applepay', // Unique value for Apple Pay
                    groupValue: _selectedPaymentMethod,
                    activeColor: Colors.blue,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    },
                  ),
                ),
              ),

              Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  onTap: _handleMpesaPayment,
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(40)),
                    child: Image.asset(
                      'images/mpesa.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: const Center(
                    child: Text(
                      'M-PESA Payment',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  subtitle: const Center(
                    child: Text(
                      'PayBill 891300, Account No: 109225',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Arial',
                          color: Color.fromARGB(255, 107, 162, 207)),
                    ),
                  ),
                  trailing: Radio<String>(
                    value: 'mpesa', // Unique value for M-PESA
                    groupValue: _selectedPaymentMethod,
                    activeColor: Colors.blue,
                    onChanged: (String? value) {
                      _handleMpesaPayment();
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Donate Goods:',
                textAlign: TextAlign.left,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                  decorationThickness: 2.0,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 3),
              const Padding(
                padding: EdgeInsets.all(11.0),
                child: Text(
                  'Elim Trust accepts donations of goods such as clothing, food, and other essentials. Your contributions can make a significant difference in the lives of those we serve.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: Color.fromARGB(255, 120, 165, 201),
                  ),
                ),
              ),

              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0, top: 8.0),
                  child: Text(
                    'Your Donations:',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 10),
//dropdownbuttontextfield with dropdown menu:
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.list, color: Colors.blue),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Select Donation Type',
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'clothing',
                        child: Text('Clothing',
                            style: TextStyle(color: Colors.blue))),
                    DropdownMenuItem(
                        value: 'food',
                        child:
                            Text('Food', style: TextStyle(color: Colors.blue))),
                    DropdownMenuItem(
                        value: 'utilities',
                        child: Text('Utilities',
                            style: TextStyle(color: Colors.blue))),
                    DropdownMenuItem(
                        value: 'sponsor trainings',
                        child: Text('Sponsor Trainings',
                            style: TextStyle(color: Colors.blue))),
                    DropdownMenuItem(
                        value: 'support initiatives',
                        child: Text('Support Other Initiatives',
                            style: TextStyle(color: Colors.blue))),
                    DropdownMenuItem(
                        value: 'other',
                        child: Text('Other',
                            style: TextStyle(color: Colors.blue))),
                  ],
                  onChanged: (String? value) {
                    // Handle selection
                  },
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Your details:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  //
                  // fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please share your details so we can reach out',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Text('😊'),
                ],
              ),

              const SizedBox(
                height: 35,
              ),
              //name
              Mytextfield(
                labelText: 'Name',
                hintText: 'John Doe',
                obscureText: false,
                keyboardType: TextInputType.name,
                controller: _namecontroller,
              ),
              const SizedBox(height: 10),
              //email
              Mytextfield(
                controller: _emailController,
                labelText: 'Email',
                hintText: 'john@example.com',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
//confirm email
              Mytextfield(
                  labelText: 'Confirm Email',
                  hintText: 'john@example.com',
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: _confirmemailController),
              const SizedBox(height: 10),
//phone number
              const Mytextfield(
                labelText: 'Phone Number',
                hintText: '+254 700 000 000',
                obscureText: false,
                keyboardType: TextInputType.phone,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '''Thank you for your generosity! Your support makes a difference!''',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Text('''🤩✨'''),
                ],
              ),
              const SizedBox(
                  height: 70), // Added space for bottom navigation bar
            ],
          ), // End of Column
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: const Color.fromARGB(255, 4, 135, 242),
          height: 60,
          index: _selectedIndex,
          items: const <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.folder_open, size: 30, color: Colors.white),
                Text('Projects',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.italic)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.attach_money_rounded, size: 30, color: Colors.white),
                Text('Donations',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.italic)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home, size: 30, color: Colors.white),
                Text('Home',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.italic)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FontAwesomeIcons.peopleGroup,
                    size: 30, color: Colors.white),
                Text('Community',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.italic)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person, size: 30, color: Colors.white),
                Text('Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.italic)),
              ],
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/projects');
                break;
              case 1:
                Navigator.pushNamed(context, '/donations');
                break;
              case 2:
                Navigator.pushNamed(context, '/home');
                break;
              case 3:
                Navigator.pushNamed(context, '/community');
                break;
              case 4:
                Navigator.pushNamed(context, '/profile');
                break;
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the AnimationController
    _namecontroller.dispose(); // Dispose the name controller
    _emailController.dispose(); // Dispose the email controller
    _confirmemailController.dispose(); // Dispose the confirm email controller
    _otherAmountController.dispose();
    super.dispose(); // Must be the last call
  }
}
