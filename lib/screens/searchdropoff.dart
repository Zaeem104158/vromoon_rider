import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vm_rider/configMaps.dart';
import 'package:vm_rider/dataHandler/appData.dart';
import 'package:vm_rider/helper/requesthelper.dart';
//import 'package:vm_rider/helper/helpermethods.dart';

class SearchDropOffScreen extends StatefulWidget {
  const SearchDropOffScreen({Key? key}) : super(key: key);

  @override
  _SearchDropOffScreenState createState() => _SearchDropOffScreenState();
}

class _SearchDropOffScreenState extends State<SearchDropOffScreen> {
  TextEditingController PickUptextEditingController = TextEditingController();
  TextEditingController DropOfftextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String placeAddress =
        Provider.of<AppData>(context).pickUpLocation!.placeName! ?? " ";
    PickUptextEditingController.text = placeAddress;
    return Scaffold(
      body: Column(children: [
        Container(
          //margin: EdgeInsets.only(top: 30),
          height: 215.0,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black,
                blurRadius: 6.0,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7))
          ]),
          child: Padding(
            padding: EdgeInsets.only(
              left: 25.0,
              right: 25.0,
              top: 25.0,
              bottom: 20.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Stack(
                  children: [
                    GestureDetector(
                      child: Icon(Icons.arrow_back_ios_new_outlined),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Center(
                      child: Text(
                        "Set Drop off location",
                        style:
                            TextStyle(fontFamily: "Brand-Bold", fontSize: 18.0),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Image.asset(
                      "images/pickicon.png",
                      height: 26.0,
                      width: 26.0,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 18.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red[400],
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(
                              controller: PickUptextEditingController,
                              decoration: InputDecoration(
                                  hintText: "Pick Up Location",
                                  fillColor: Colors.grey,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                    left: 11.0,
                                    top: 8.0,
                                    bottom: 8.0,
                                  ))),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Image.asset(
                      "images/desticon.png",
                      height: 26.0,
                      width: 26.0,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 18.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(
                              onChanged: (val) {
                                finalplace(val);
                              },
                              controller: DropOfftextEditingController,
                              decoration: InputDecoration(
                                  hintText: "Drop Off",
                                  fillColor: Colors.grey,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                    left: 11.0,
                                    top: 8.0,
                                    bottom: 8.0,
                                  ))),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  void finalplace(String placeName) async {
    if (placeName.length > 1) {
      String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=123254251&components=country:BD';
      var response = await RequestHelper.getRequest(url);
      if (response == 'failed') {
        return;
      }
      print("Places Prediction Response ::");
      print(response);
    }
  }
}
