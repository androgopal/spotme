import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotme/CommonWidget/gradiantButton.dart';
import 'package:spotme/Models/LandingModel.dart';
import 'package:spotme/Screens/MobileLogin/Bloc/authBloc.dart';
import 'package:spotme/Screens/MobileLogin/MobileLogin.dart';
import 'package:spotme/res/app_strings.dart';
import 'package:spotme/utils/TextStyle.dart';

class LandingScreen extends StatefulWidget {
  static const String id = '/LandingScreen';
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  late final List<ModelLanding> _imageUrls = [
    ModelLanding(Strings.landingTitle1,Strings.landingDescription1,Image.asset("assets/images/landing1.png")),
    ModelLanding(Strings.landingTitle2,Strings.landingDescription2,Image.asset("assets/images/landing2.png")),
    // ModelLanding(Strings.landingTitle3,Strings.landingDescription3,Image.asset("assets/images/landing3.png")),
    // ModelLanding(Strings.landingTitle4,Strings.landingDescription4,Image.asset("assets/images/landing4.png")),

  ];

  @override
  void initState() {
    super.initState();
    // Add a delay to show the splash screen
    _pageController = PageController(initialPage: _currentPage);
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < _imageUrls.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
      else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MobileLogin()),
      );
    }

  }

  @override  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            // Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MobileLogin()),
            );
          }, child: const Text("SKIP",style: TextStyle(color: Colors.blue,
              fontFamily: FontName.montserrat,fontSize: 14,fontWeight: FontWeight.bold),))
        ],
      
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _imageUrls.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: [
                    _imageUrls[index].image,
                    const Spacer(),
                    Text(_imageUrls[index].title ,style: AppTextStyle.headerTextStyle,textAlign: TextAlign.center,),
                    const SizedBox(height: 20,),
                    Text(_imageUrls[index].description,style: AppTextStyle.subHeaderTextStyle,textAlign: TextAlign.center,),
                    const Spacer(),
                  ]);
                },
              ),
            ),
            SizedBox(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < _imageUrls.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor:
                        _currentPage == i ? Colors.blue : Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GradientButton(
                onPressed: _goToNextPage,
                text: 'Next',

              ),
            ),
          ],
        ),
      ),
    );
  }
}
