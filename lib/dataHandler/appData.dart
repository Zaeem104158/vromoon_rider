import 'package:flutter/cupertino.dart';
import 'package:vm_rider/models/address.dart';
//import 'package:provider/provider.dart';

class AppData extends ChangeNotifier {
  Address? pickUpLocation;
  void updatePickUpLocation(Address pickUpAdress) {
    pickUpLocation = pickUpAdress;
    notifyListeners();
  }
}
