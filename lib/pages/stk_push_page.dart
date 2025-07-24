import 'package:flutter/material.dart';

class STKPushPage extends StatefulWidget {
  final String initialAmount;

  const STKPushPage({Key? key, required this.initialAmount}) : super(key: key);

  @override
  State<STKPushPage> createState() => _STKPushPageState();
}

class _STKPushPageState extends State<STKPushPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M-PESA Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Processing payment of KES ${widget.initialAmount}...'),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
