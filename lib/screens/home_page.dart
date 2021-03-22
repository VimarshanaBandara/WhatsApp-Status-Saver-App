import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_status_download/image_screen.dart';
import 'package:whatsapp_status_download/screens/video_screen.dart';





class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
   // testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['WhatsApp', 'Status','WhatsApp Status','Status Downloader','Social Media' ,],
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: 'ca-app-pub-7778261196555839/3190395653',

        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }



  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-7778261196555839~4695049011');
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }


  @override
  void dispose() {
    _bannerAd.dispose();

    super.dispose();
  }



  Color _themeColor=Colors.greenAccent[700];
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      _bannerAd?.show();
    });

    return DefaultTabController(

      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.greenAccent[700],
            title: Text('Status Downloader',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(child: Text('Images',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),
                Tab(child: Text('Video',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),),
              ],
            ),
          ),
          body: Container(

            child: TabBarView(
              children: [

                ImageScreen(),
                VideoScreen(),
              ],
            ),
          )
      ),
    );
  }
}
