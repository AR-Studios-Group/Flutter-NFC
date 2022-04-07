import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCController extends GetxController {
  var isAvailable = false.obs;

  void checkNFC() async {
    try {
      isAvailable.value = await NfcManager.instance.isAvailable();
    } catch (err) {
      print(err);
    }
  }

  void startNFCSession() async {
    print("starting");

    NfcManager.instance.startSession(
        alertMessage: "iOS Alert Message",
        onDiscovered: (tag) async {
          print(tag);
          NfcManager.instance.stopSession();
        },
        onError: (err) async {
          print(err.message);
        });
  }

  @override
  void onInit() {
    super.onInit();
    checkNFC();
  }
}
