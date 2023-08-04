import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotme/CommonWidget/RipplesAnimation.dart';
import 'package:spotme/CommonWidget/drop_downButton.dart';
import 'package:spotme/Screens/Map/group_spot_widget.dart';
import 'package:spotme/Screens/ShowDialog/ShowDialog.dart';
import 'package:spotme/Screens/UserProfile/EditProfile.dart';
import 'package:spotme/res/app_strings.dart';
import 'package:spotme/utils/LocalImages.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:spotme/utils/color.dart';
import 'dart:ui' as ui;
import '../Chats/ModelPost.dart';

const LatLng currentLocation = LatLng(26.839994, 75.800974);

class MapNearMe extends StatefulWidget {
  @override
  MapNearMeWidgetState createState() => MapNearMeWidgetState();
}

class MapNearMeWidgetState extends State<MapNearMe>
    with SingleTickerProviderStateMixin {
  final List<ChatMessage> _messages = [];

  late AnimationController _animationController;
  double _circleRadius = 50.0;
  int _numCircles = 5;
  late var isApiloaded = false;

  Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  Uint8List? imgBitmap;

  final LatLng myLocation = LatLng(26.839994, 75.800974); // Your location coordinates

  // Sample locations for five friends (Replace these with your friends' coordinates)
  final List<LatLng> friendsLocations = [
    LatLng(26.8495027, 75.8240136),
    LatLng(26.8530258,75.8020939),
    LatLng(26.8878386,75.8148331),
    LatLng(26.8845611,75.8102119),
    LatLng(26.8158216,75.8455084),
  ];

  final List<String> friendsimages = [
    "assets/images/user.png",
    "assets/images/user.png",
    "assets/images/user.png",
    "assets/images/user.png",
    "assets/images/user.png",
  ];

 Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

 }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the new screen after the delay
      setState(() {
        isApiloaded = true;
      });
    });
    super.initState();
    imageData();
    this._animationController = AnimationController(
      duration: Duration(seconds: 01),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    List<String> items = ['Be friend', 'Coffee', 'Shop', 'Travel', 'Play'];
    final TextEditingController textEditingController = TextEditingController();

    void _sendMessage() {
      setState(() {
        _messages.add(ChatMessage(
            messageId: "007",
            senderId: "007",
            receiverId: "006",
            content: textEditingController.text,
            timestamp: DateTime.now()));
        _messages.add(ChatMessage(
            messageId: "007",
            senderId: "0007",
            receiverId: "007",
            content: textEditingController.text,
            timestamp: DateTime.now()));
        textEditingController.clear();
      });
    }

    double screenWidth = MediaQuery.of(context).size.width;
    _circleRadius = (screenWidth / 2 + 10) / 5;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Perform action when back button is pressed
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Text(
                        Strings.spotnearby,
                        style: TextStyle(
                            fontSize: 28,
                            fontFamily: FontName.simplified,
                            fontWeight: FontWeight.bold,
                            color: AppColor.grayColor),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "20 M",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: FontName.simplified,
                            fontWeight: FontWeight.w900,
                            color: AppColor.rangeGrayColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButtonCustom(
                        callBack: (seletcedItem) {
                          print(seletcedItem);
                        },
                        hint: 'Radious',
                        list: [
                          "10 Meter",
                          "20 Meter",
                          "30 Meter",
                          "More than 500 Meter"
                        ],
                      ),
                      DropdownButtonCustom(
                        callBack: (seletcedItem) {
                          print(seletcedItem);
                        },
                        hint: 'Gender',
                        list: ["Male", "Female", "Transgender", "Other"],
                      ),
                      DropdownButtonCustom(
                        callBack: (seletcedItem) {
                          print(seletcedItem);
                        },
                        hint: 'Age',
                        list: ["18-21", "21-25", "25-30", "30-Above"],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenWidth,
                  height: screenWidth,
                  // Height set equal to width to make it square
                  // child: Image.asset(
                  //   "assets/images/map.png",
                  //   fit: BoxFit.cover,
                  // ),

                  child: Center(
                      child: isApiloaded == true
                          ? myGoogleMap()
                          : Ripples(
                              key: UniqueKey(),
                              size: screenWidth * 1.1,
                              onPressed: () {},
                              child: Image.asset(LocalImages.user))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: GroupSpotWidget(
                    width: screenWidth * 0.113,
                  ),
                ),
                Divider(
                  color: Colors.black12,
                ),
                InterestList(items: items),
                Row(
                  children: [
                    IconButton(
                      icon: Image.asset("assets/images/camra.png"),
                      onPressed: _sendMessage,
                    ),
                    Container(
                      width: 2,
                      height: 33,
                      color: AppColor.AppBorderColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            hintText: 'Type a message...',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 33,
                      color: AppColor.AppBorderColor,
                    ),
                    IconButton(
                        icon: Image.asset("assets/images/send.png"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ShowDailog()),
                          );
                        }

                        // _sendMessage,
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myGoogleMap() {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          // myLocationButtonEnabled: true,
          mapType: MapType.normal,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          initialCameraPosition: const CameraPosition(
            target: currentLocation,
            zoom: 12,
          ),
          onMapCreated: (GoogleMapController controller) {
            // now we need a variable to get the controller of google map
            if (!_googleMapController.isCompleted) {
              _googleMapController.complete(controller);
            }
          },
          markers: _buildMarkers(),
        ),
        Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: _getMarker()
            )
        )
      ],
    );
  }


  Widget _getMarker() {
    return Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            spreadRadius: 4,
            blurRadius: 6,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset("assets/images/user.png"),
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    Set<Marker> markers = {};

    // Add your marker
    markers.add(_createMarker(myLocation, "You", 40.0));

    // Add markers for friends
    for (LatLng friendLocation in friendsLocations) {
      double distance = _calculateDistance(
        myLocation.latitude,
        myLocation.longitude,
        friendLocation.latitude,
        friendLocation.longitude,
      );

      double markerSize = 40.0 + (1000.0 * distance); // Adjust the multiplier based on your preference

      markers.add(_createMarker(friendLocation, "Friend", markerSize));
    }

    return markers;
  }

  imageData() async {
   imgBitmap = await getBytesFromAssets('assets/images/user.png', 100);
   setState(() {

   });
  }

  Marker _createMarker(LatLng location, String title, double size) {
    return Marker(
      markerId: MarkerId(location.toString()),
      position: location,
      infoWindow: InfoWindow(
        title: title,
        snippet: "Latitude: ${location.latitude}, Longitude: ${location.longitude}",
      ),
      icon: BitmapDescriptor.fromBytes(imgBitmap!),
      anchor: Offset(0.5, 0.5),
      zIndex: 2,
      // Set marker size here using size parameter
      // You can also use a custom BitmapDescriptor for more complex marker designs
      // size: size,
      draggable: false,
    );
  }

  double _calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }


}




class InterestList extends StatelessWidget {
  final List<String> items;

  InterestList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45, // Set the desired height for the horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 150, // Set the desired width for each item in the list
              color: AppColor.AppBorderColor,
              child: Center(
                child: Text(
                  items[index],
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: FontName.montserrat,
                      fontWeight: FontWeight.bold,
                      color: AppColor.TextColorGray),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
