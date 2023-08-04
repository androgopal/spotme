import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spotme/Screens/Chats/ModelPost.dart';
import 'package:spotme/Screens/ShowDialog/ShowDialog.dart';
import 'package:spotme/utils/TextStyle.dart';
import 'package:spotme/utils/color.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  File? _image;
  Future getImage() async{
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image == null) return;
  final imageTemp = File(image.path);
  setState(() {
    this._image =  imageTemp;
  });
  }

  List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _textEditingController = TextEditingController();

  void _sendMessage() {
    setState(() {
      _messages.add(ChatMessage(
          messageId: "007",
          senderId: "007",
          receiverId: "006",
          content: _textEditingController.text,
          timestamp: DateTime.now()));
      _messages.add(ChatMessage(
          messageId: "007",
          senderId: "0007",
          receiverId: "007",
          content: _textEditingController.text,
          timestamp: DateTime.now()));
      _textEditingController.clear();
      scrollToBottom();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed:  () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShowDailog()),
              );
            },
          ),
        ],
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"),
              backgroundColor: Colors.yellowAccent,
              radius: 25.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pooja Jade',
                  style: AppTextStyle.ChatHeaderTextStyle,
                ),
                Text('online',style: TextStyle(fontSize:12, fontWeight:FontWeight.w500 ,fontFamily: FontName.montserrat,color: AppColor.TextColorGray),),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ChatMessageWidget(message: _messages[index]),
                      );
                    })),
             const Divider(
              height: 2,
              thickness: 2,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset("assets/images/camra.png"),
                    onPressed: getImage
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
                        controller: _textEditingController,
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
                    icon:  Image.asset("assets/images/send.png"),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: message.senderId == "007"
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          alignment: message.senderId == "007"
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width *
                  0.8, // Set the maximum width
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: message.senderId == "007"
                  ? AppColor.appSecondaryColor
                  : AppColor.appwhile50,
              borderRadius: message.senderId == "007"
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
            ),
            child: Text(
              message.content,
              style:  message.senderId == "007" ? const TextStyle(color: AppColor.appWhiteColor,
                  fontFamily:FontName.simplified,fontWeight:FontWeight.w500 ,fontSize: 14) :   const TextStyle(color: AppColor.appRecieverChatColor,
              fontFamily:FontName.simplified,fontWeight:FontWeight.w500 ,fontSize: 14)
            ),
          ),
        ),
        Text(message.timestamp.toString(),
            style: const TextStyle(color: AppColor.appRecieverChatColor,
    fontFamily:FontName.simplified,fontWeight:FontWeight.w500 ,fontSize: 12)),
      ],
    );
    ;
  }
}
