import 'package:geolocator/geolocator.dart';
import 'package:vm_rider/configMaps.dart';
import 'package:vm_rider/helper/requesthelper.dart';

class HelperMethods {
  static Future<String> searchcoordinateAddress(Position position) async {
    String placeAdress = "";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var response = await RequestHelper.getRequest(url);

    if (response != "failed") {
      placeAdress = response["results"][1]["formatted_address"];
    }
    return placeAdress;
  }
}
