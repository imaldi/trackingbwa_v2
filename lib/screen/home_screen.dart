import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trackingbwa_v2/core/custom/responsive_widget.dart';
import 'package:trackingbwa_v2/core/custom/size_config.dart';
import 'package:trackingbwa_v2/screen/login_screen.dart';
import 'package:trackingbwa_v2/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackingbwa_v2/screen/bulk_scan_screen.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:trackingbwa_v2/screen/single_scan_screen.dart';

class Home extends StatefulWidget {
  static const String id = "HOME";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const IconData logouts = IconData(0xe848, fontFamily: 'MaterialIcons');
  String? name;
  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user') ?? "");
    if (user != null) {
      setState(() {
        name = user['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mediumScreen: _buildhomelayout(true),
      smallScreen: _buildhomelayout(false),
    );
  }

  Widget _buildhomelayout(bool isMedium) {
    return Scaffold(
        body :Column(
        children: <Widget>[
          Container(
            height: isMedium ? 365.0 : 355.0,
            color: const Color(0xff20ADDF),
            child:  Column(
              children: <Widget>[
                 Padding(
                  padding: EdgeInsets.only(
                      top: isMedium ? 45.0 : 35.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                     Padding(
                      padding: EdgeInsets.only(
                          left: 2.0 * (SizeConfig?.heightMultiplier ?? 0.1)),
                    ),
                    Material(
                        color: Colors.transparent,
                        child : IconButton(
                          icon: Icon(
                            logouts,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // logout();
                            _showSimpleDialog(context);
                          },
                        )
                    )
                  ],
                ),
                ListTile(
                  title:
                  Column(
                    children: [
                      Text(
                        'Petugas',
                        style: TextStyle(
                            fontSize: isMedium ? 34.0 : 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'),
                      ),
                      new Padding(
                        padding: EdgeInsets.only(
                            top: isMedium ? 28.0 : 18.0),
                      ),
                      Container(
                        width: isMedium ? 110.0 : 100.0,
                        height: isMedium ? 110.0 : 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:  AssetImage(
                                'assets/images/user.png',
                                // height: 50.0 * SizeConfig.heightMultiplier,
                              ),
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.only(
                            top: isMedium ? 30.0 : 20.0),
                      ),
                      Text(
                        'Assalamualaikum,',
                        style: TextStyle(
                            fontSize: isMedium ? 22.0 : 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'),
                      ),
                      new Padding(
                        padding: EdgeInsets.only(
                            top: isMedium ? 20.0 : 10.0),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    '$name',
                    style: TextStyle(fontSize: isMedium ? 26.0 : 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],),
          ),
          new Padding(
            padding: EdgeInsets.only(
                top: isMedium ? 25.0 : 15.0),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment
                .center,
            children: [
              // new Container(
              //   // padding: const EdgeInsets.only(right: 12.0),8
              //     width:  isMedium ? 280.0 : 270.0,
              //     height: isMedium ? 48.0 : 38.0,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black12,
              //           blurRadius: 3.0,
              //           spreadRadius: 1.0,
              //         ),
              //       ],
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     child:    Container(
              //       width: isMedium ? 318.0 : 308.0,
              //       height: isMedium ? 50.0 : 40.0,
              //       // constraints: BoxConstraints(minWidth: 33.0 * SizeConfig.heightMultiplier, maxWidth: 33.0 * SizeConfig.heightMultiplier),
              //       child :   new SizedBox(
              //         //   width: 217.0,
              //         //   height: 35.0,
              //         child: new RaisedButton(
              //           shape: new RoundedRectangleBorder(
              //               borderRadius:
              //               new BorderRadius.circular(
              //                   10.0)),
              //           color: Colors.white,
              //           onPressed: () {},
              //           child:Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: <Widget> [
              //                 new Padding(
              //                   padding: EdgeInsets.only(left: isMedium ? 55.0 : 45.0),
              //                 ),
              //                 new Text(
              //                   "Input Your UPC",
              //                   style: new TextStyle(
              //                     fontSize: isMedium ? 26.0 : 16.0,
              //                     fontFamily: 'Poppins',
              //                     fontWeight: FontWeight
              //                         .w600, color: Colors.black54,),
              //                 ),
              //                 new Padding(
              //                   padding: EdgeInsets.only(left: isMedium ? 63.0 : 33.0),
              //                 ),
              //                 new SvgPicture.asset(
              //                   'assets/icon/circle_right.svg',
              //                   //   fit: BoxFit.fill,
              //                   // height: isMedium ? 35.0 : 25.0,
              //                   // width: isMedium ? 35.0 : 25.0,
              //                   //fit: BoxFit.scaleDown,
              //                 ),
              //               ]
              //           ),
              //         ),
              //       ),
              //     )
              // ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: [
                  MenuItem(
                      title: 'Bulk Scan',
                      icon: 'assets/icon/bulk_scan.svg',
                      //iconColor: const Color(0xff2E3A59),
                      onTap: () async {
                        await BarcodeScanner.scan().then((String bulkDetail) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BulkScan(bulkDetail)));
                        });
                      }
                      ),
                  MenuItem(
                    title: 'Single Scan',
                    icon: 'assets/icon/single_scan.svg',
                    // iconColor: const Color(0xff2E3A59),
                    onTap: () async {
                      await BarcodeScanner.scan().then((String singleDetail) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SingleScan(singleDetail)));
                      });
                    }
                  ),
                ],
              ),
            ],
          )
        ]
    )
    );

  }




  void _showSimpleDialog(context) {
    //showDialog(
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Apa kamu ingin keluar dari Aplikasi ?"),
            actions: <Widget>[
              FlatButton(
                child: Text("TIDAK"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text("YA"),
                onPressed: () {
                  logout();
                  //Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
    //);
  }

  void logout() async {
    var res = await Network().getData('logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}

class MenuItem extends StatelessWidget {
  MenuItem(
      {this.title,
        this.icon,
        //  this.colorBox,
        // this.iconColor,
        //   this.iconSize,
        this.onTap});

  final String? title;
  final String? icon;
  // final Color colorBox, iconColor;
  // final Size iconSize;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mediumScreen: menu(true),
      smallScreen: menu(false),
    );
  }

  Widget menu(bool isMedium) {
    return GestureDetector(
        onTap: onTap ?? (){},
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 2.0 * (SizeConfig.heightMultiplier ?? 1.0)),
                // constraints: BoxConstraints( maxWidth: 40.0 * SizeConfig.heightMultiplier, maxHeight: 35.0 * SizeConfig.heightMultiplier),
                decoration: BoxDecoration(
                  // color: colorBox,
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.circular(15.0)),
                child: SvgPicture.asset(
                  icon,
                  height:  isMedium ? 110.0 : 100,
                  width:   isMedium ? 110.0 : 100,
                  //color: iconColor,
                )),
            Padding(
              padding:  EdgeInsets.only(top: isMedium ? 30.0 : 20.0),
              child: Text(
                title ?? '',
                style: TextStyle(fontSize: isMedium ? 26.0 : 16.0 , fontWeight: FontWeight.w600, fontFamily: 'Poppins', color: Colors.black54 ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}




