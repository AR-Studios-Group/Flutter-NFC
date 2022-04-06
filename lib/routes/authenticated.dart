import 'package:flutter/material.dart';

class Authenticated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Authenicated")),
      body: const Center(child: Text("Correct NFC Tag")),
    );
  }
}
