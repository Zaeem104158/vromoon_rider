import 'dart:async';
//import 'dart:math';
//import 'dart:ui';
//import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:vm_rider/dataHandler/appData.dart';
import 'package:vm_rider/helper/helpermethods.dart';
import 'package:js/js.dart';
import 'package:vm_rider/screens/searchdropoff.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "MainScreen";
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var geoLocator = Geolocator();
  late Position currentPosition;
  double bottomPaddingOfMap = 0;
  void setupPositionLocator() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = CameraPosition(
      target: latLngPosition,
      zoom: 15,
    );
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    String address =
        await HelperMethods.searchcoordinateAddress(position, context);
    print("This is your address: " + address);
  }

  static final CameraPosition _kDhaka = CameraPosition(
    target: LatLng(22.900750049006117, 89.50285650754132),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Vromoon'),
      ),
      drawer: Container(
        color: Colors.white,
        width: 255,
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 155.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/user_icon.png",
                        height: 65.0,
                        width: 65.0,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Profle Name:",
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: "Brand-Bold"),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "View Profle:",
                            // style: TextStyle(
                            //     fontSize: 16.0, fontFamily: "Brand-Bold"),
                          ),
                          //SizedBox(height: 6),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.cyan,
                thickness: 1.5,
              ),
              SizedBox(
                height: 12,
              ),
              ListTile(
                leading: Icon(Icons.history_outlined),
                title: Text(
                  "History",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle_outlined),
                title: Text(
                  "View Profile",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info_outlined),
                title: Text(
                  "Info",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                leading: Icon(Icons.help_outline_outlined),
                title: Text(
                  "Abouts",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kDhaka,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) async {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                bottomPaddingOfMap = 300.0;
              });
              LocationPermission permission;
              permission = await Geolocator.requestPermission();
              setupPositionLocator();
            },
          ),
          Positioned(
            top: 5,
            left: 5,
            child: GestureDetector(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.0)),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 300.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyan,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        "Hi there",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text(
                        "Where do you want to go?",
                        style:
                            TextStyle(fontSize: 20.0, fontFamily: "Brand-Bold"),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchDropOffScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 16.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search_outlined,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("Search Drop Off"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Divider(
                        color: Colors.cyan,
                        thickness: 1.5,
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            // BoxShadow(
                            //   color: Colors.black54,
                            //   blurRadius: 16.0,
                            //   spreadRadius: 0.5,
                            //   offset: Offset(0.7, 0.7),
                            // ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.home_outlined,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Provider.of<AppData>(context)
                                            .pickUpLocation !=
                                        null
                                    ? Provider.of<AppData>(context)
                                        .pickUpLocation!
                                        .placeName!
                                    : "Pick Up Location"),
                                SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "Your Current Address",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green[300],
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            // BoxShadow(
                            //   color: Colors.black54,
                            //   blurRadius: 16.0,
                            //   spreadRadius: 0.5,
                            //   offset: Offset(0.7, 0.7),
                            // ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.work_outline, color: Colors.blueAccent),
                            SizedBox(
                              width: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Add Office"),
                                SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "Add your office location",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
