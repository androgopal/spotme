import 'package:flutter/material.dart';
import 'package:spotme/CommonWidget/RipplesAnimation.dart';
import 'package:spotme/CommonWidget/drop_downButton.dart';
import 'package:spotme/Screens/Map/group_spot_widget.dart';
import 'package:spotme/Screens/ShowDialog/ShowDialog.dart';
import 'package:spotme/Screens/UserProfile/EditProfile.dart';
import 'package:spotme/res/app_strings.dart';
import 'package:spotme/utils/LocalImages.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:spotme/utils/color.dart';

import '../Chats/ModelPost.dart';

class MapNearMe extends StatefulWidget {
  @override
  MapNearMeWidgetState createState() => MapNearMeWidgetState();
}

class MapNearMeWidgetState extends State<MapNearMe> with SingleTickerProviderStateMixin{
  final List<ChatMessage> _messages = [];


   late AnimationController _animationController;
  double _circleRadius = 50.0;
  int _numCircles = 5;
  late var isApiloaded = false;
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
    final TextEditingController textEditingController =
        TextEditingController();

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
    _circleRadius = (screenWidth/2+10)/5;

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
                MaterialPageRoute(
                    builder: (context) =>  EditProfile()),
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
                        }, hint: 'Radious', list: [ "10 Meter", "20 Meter", "30 Meter" ,  "More than 500 Meter"],
                      ),
                      DropdownButtonCustom(
                        callBack: (seletcedItem) {
                          print(seletcedItem);
                        }, hint: 'Gender', list: ["Male", "Female", "Transgender", "Other" ],
                      ),
                      DropdownButtonCustom(
                        callBack: (seletcedItem) {
                          print(seletcedItem);
                        }, hint: 'Age', list: ["18-21", "21-25", "25-30", "30-Above"],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenWidth,
                  height: screenWidth, // Height set equal to width to make it square
                  // child: Image.asset(
                  //   "assets/images/map.png",
                  //   fit: BoxFit.cover,
                  // ),

                    child:Center(
                      child:
                      isApiloaded == true ? Image.asset(LocalImages.map,fit: BoxFit.cover,) :
                        Ripples(key:UniqueKey(),size:screenWidth*1.1, onPressed: (){
                        
                      }, child: Image.asset(LocalImages.user))

                    ),
                ),
                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: GroupSpotWidget(width: screenWidth*0.113,),
                ),
                Divider(color:Colors.black12,),

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
                      onPressed:(){
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
