import 'package:get/get.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:nfc_manager/nfc_manager.dart';

class NFCKitController extends GetxController {
  static const VAILD_RECORD =
      "BluetoothEasyPairingRecord: address=58:59:52:3c:02:00 name=SB ROAR SR20A attributes={EIRType.CompleteLocalName: [83, 66, 32, 82, 79, 65, 82, 32, 83, 82, 50, 48, 65], EIRType.ClassOfDevice: [20, 4, 44]}";
  var isAvailable = false.obs;

  void checkNFC() async {
    var availability = await FlutterNfcKit.nfcAvailability;
    isAvailable.value =
        availability == NFCAvailability.available ? true : false;
  }

  Future<bool> startNFCSession() async {
    try {
      var tag = await FlutterNfcKit.poll(
          timeout: const Duration(seconds: 10),
          iosMultipleTagMessage: "Multiple tags found!",
          iosAlertMessage: "Scan your tag");

      print(tag.toJson());

      if (tag.ndefAvailable) {
        for (var record in await FlutterNfcKit.readNDEFRecords(cached: false)) {
          print(record.toString());
          FlutterNfcKit.finish();
          if (record.toString() == VAILD_RECORD) {
            return true;
          } else {
            return false;
          }
        }
        return false;
      } else {
        FlutterNfcKit.finish();
        return false;
      }
    } catch (err) {
      print(err);
      FlutterNfcKit.finish();
      return false;
    }
  }

  @override
  void onInit() async {
    checkNFC();
    super.onInit();
  }
}
