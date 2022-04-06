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

    if (isAvailable.value) {
      NfcManager.instance.startSession(
          alertMessage: "iOS Message",
          onDiscovered: (NfcTag tag) async {
            print('tag');
          },
          onError: (err) async {
            print(err);
          });
    } else {
      print("NFC Not supported");
    }
  }

  @override
  void onInit() {
    checkNFC();
    super.onInit();
  }
}
