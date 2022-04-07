import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:get/get.dart';

import '../controller/NFCController.dart';
import '../controller/NFCKitController.dart';
import 'authenticated.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final nfcController = Get.put(NFCKitController());

  bool? _isAuthenticated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('NFC Status: ${nfcController.isAvailable}')),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () async {
                  var res = await nfcController.startNFCSession();
                  if (res) {
                    Get.to(Authenticated());
                  }
                  setState(() {
                    _isAuthenticated = res;
                  });
                },
                child: const Text("Start Reading NFC")),
            const SizedBox(height: 20),
            _isAuthenticated == null
                ? const Text("Last Tag Result ")
                : Text("Last Tag Result $_isAuthenticated")
          ],
        ),
      ),
    );
  }
}
