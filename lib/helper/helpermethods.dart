import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:vm_rider/configMaps.dart';
import 'package:vm_rider/dataHandler/appData.dart';
import 'package:vm_rider/helper/requesthelper.dart';
import 'package:vm_rider/models/address.dart';

class HelperMethods {
  static Future<String> searchcoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var response = await RequestHelper.getRequest(url);

    if (response != "failed") {
      //placeAddress = response["results"][1]["formatted_address"];
      st1 = response["results"][1]["address_components"][0]["long_name"];
      st2 = response["results"][1]["address_components"][1]["short_name"];
      st3 = response["results"][1]["address_components"][5]["short_name"];
      st4 = response["results"][1]["address_components"][6]["short_name"];
      placeAddress = st1 + "," + st2 + "," + st3 + "," + st4 + ".";
      Address userPickUpAddress = Address();
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.placeName = placeAddress;
      Provider.of<AppData>(context, listen: false)
          .updatePickUpLocation(userPickUpAddress);
    }
    return placeAddress;
  }
}
