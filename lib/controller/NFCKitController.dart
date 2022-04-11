import 'package:get/get.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;

class NFCKitController extends GetxController {
  static const VAILD_ID = "E004010080205B83";

  var isAvailable = false.obs;
  var isReading = false.obs;

  void checkNFC() async {
    var availability = await FlutterNfcKit.nfcAvailability;
    isAvailable.value = availability == NFCAvailability.available;
  }

  void stopNFC() async {
    await FlutterNfcKit.finish();
    await FlutterNfcKit.finish(iosAlertMessage: "Success");
    await FlutterNfcKit.finish(iosErrorMessage: "Failed");
  }

  Future<bool> startNFCSession() async {
    isReading.value = true;
    var result = false;
    try {
      var tag = await FlutterNfcKit.poll(
          timeout: const Duration(seconds: 10),
          iosMultipleTagMessage: "Multiple tags found!",
          iosAlertMessage: "Scan your tag");

      print('**** FOUND ****');
      if (tag.id == VAILD_ID) {
        result = true;
      }
    } catch (err) {
      print(err);
    }
    stopNFC();
    isReading.value = false;
    return result;
  }

  @override
  void onInit() async {
    checkNFC();
    super.onInit();
  }
}
