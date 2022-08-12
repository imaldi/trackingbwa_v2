import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:http/http.dart' as http;
import 'package:trackingbwa_v2/core/custom/responsive_widget.dart';
import 'dart:convert';
import 'dart:async';
import 'package:trackingbwa_v2/model/bulkscan_model.dart';

class HistorySingleScan extends StatefulWidget {

  @override
  _HistorySingleScanState createState() => new _HistorySingleScanState();
}

class _HistorySingleScanState extends State<HistorySingleScan> {
  var tanggal ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getTanggal();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getTanggal();

  }

  void getTanggal() async{
    var waktu = Waktu();
//    setState(() {
//      tanggal = new DateFormat("dd-MM-yyyy").format(tgl).toString() ;
//        });
    tanggal = waktu.yMMMMEEEEd();
    print('Tgl2: $tanggal');
  }


  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mediumScreen:_buildHistorylayout(true),
      smallScreen: _buildHistorylayout(false),
    );
  }


  Widget _buildHistorylayout(bool isMedium) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff20ADDF),
        title:  Text(
          'History Barang',
          style: TextStyle(
              fontSize: isMedium ? 28.0 : 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'),
        ),
      ),
      body: ListView(
        children: [
          new Padding(
            padding: EdgeInsets.only(top: isMedium ? 30.0 : 20.0),
          ),
          Column(
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Padding(
                padding: EdgeInsets.only(top: isMedium ? 20.0 : 10.0),
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only( left: isMedium ? 40.0 :30.0),
                      child: new SvgPicture.asset(
                        'assets/icon/done.svg',
                        //   fit: BoxFit.fill,
                        // height: isMedium ? 35.0 : 25.0,
                        // width: isMedium ? 35.0 : 25.0,
                        //fit: BoxFit.scaleDown,
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10.0, top: 15.0),
                    //   child: Image.asset(
                    //     'assets/images/circle.png',
                    //     height: 25.0,
                    //   ),
                    // ),
                    new Padding(
                      padding: EdgeInsets.only(left: isMedium ? 20.0 : 10.0),
                    ),
                    Column(
                        children: [
                          SizedBox(
                            width: isMedium ? 160.0 : 150.0,
                            height: isMedium ? 40.0 : 30.0,
                            child: Text(
                              "Drop Point 1",
                              style: TextStyle(
                                  fontSize: isMedium ? 28.0 : 18.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                          Text(
                            "${tanggal}",
                            style: TextStyle(
                                fontSize: isMedium ? 24.0 : 14.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins'),
                          ),

                        ]
                    ),
                  ]
              ),
              new Padding(
                padding: EdgeInsets.only(top: isMedium ? 13 : 3.0),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(left: isMedium ? 60.0 :50.0),
                  ),
                  Container(height: isMedium ? 96.0 : 86.0,
                      child: VerticalDivider(color: Colors.black, thickness: 2,)),
                  Row(
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.only(left: isMedium ? 25.0 : 15.0),
                      ),
                      Container(
                          width: isMedium ? 270.0 : 260.0,
                          height: isMedium ? 81.0 : 71.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color:  const Color(0xffBCEAF4),
                          ),
                          child: Row(
                              children : [
                                new Padding(
                                  padding: EdgeInsets.only( left: isMedium ? 20.0 : 10.0),
                                ),
                                Column(
                                    children : [
                                      new Padding(
                                        padding: EdgeInsets.only( top: isMedium ? 20.0 : 10.0),
                                      ),
                                      Text(
                                        'test',
                                        style: new TextStyle(
                                            fontSize: isMedium ? 24.0 : 14.0,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight
                                                .w600, color: Colors.black54),
                                        textAlign: TextAlign.start,
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.only(top: isMedium ? 21.0 : 11.0),
                                      ),
                                      Text(
                                        'test',
                                        style: new TextStyle(
                                            fontSize: isMedium ? 24.0 : 14.0,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight
                                                .w600, color: Colors.black54),
                                      )
                                    ]
                                )
                              ]
                          )
                      ),
                    ],
                  ),
                ],
              ),

            ],
          ),
          Column(
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Padding(
                padding: EdgeInsets.only(top: isMedium ? 20.0 : 10.0),
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only( left: isMedium ? 40.0 :30.0),
                      child: new SvgPicture.asset(
                        'assets/icon/done.svg',
                        //   fit: BoxFit.fill,
                        // height: isMedium ? 35.0 : 25.0,
                        // width: isMedium ? 35.0 : 25.0,
                        //fit: BoxFit.scaleDown,
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10.0, top: 15.0),
                    //   child: Image.asset(
                    //     'assets/images/circle.png',
                    //     height: 25.0,
                    //   ),
                    // ),
                    new Padding(
                      padding: EdgeInsets.only(left: isMedium ? 20.0 : 10.0),
                    ),
                    Column(
                        children: [
                          SizedBox(
                            width: isMedium ? 160.0 : 150.0,
                            height: isMedium ? 40.0 : 30.0,
                            child: Text(
                              "Drop Point 2",
                              style: TextStyle(
                                  fontSize: isMedium ? 28.0 : 18.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                          Text(
                            "${tanggal}",
                            style: TextStyle(
                                fontSize: isMedium ? 24.0 : 14.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins'),
                          ),

                        ]
                    ),
                  ]
              ),
              new Padding(
                padding: EdgeInsets.only(top: isMedium ? 13 : 3.0),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(left: isMedium ? 60.0 :50.0),
                  ),
                  Container(height: isMedium ? 96.0 : 86.0,
                      child: VerticalDivider(color: Colors.black, thickness: 2,)),
                  Row(
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.only(left: isMedium ? 25.0 : 15.0),
                      ),
                      Container(
                          width: isMedium ? 270.0 : 260.0,
                          height: isMedium ? 81.0 : 71.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color:  const Color(0xffBCEAF4),
                          ),
                          child: Row(
                              children : [
                                new Padding(
                                  padding: EdgeInsets.only( left: isMedium ? 20.0 : 10.0),
                                ),
                                Column(
                                    children : [
                                      new Padding(
                                        padding: EdgeInsets.only( top: isMedium ? 20.0 : 10.0),
                                      ),
                                      Text(
                                        'test',
                                        style: new TextStyle(
                                            fontSize: isMedium ? 24.0 : 14.0,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight
                                                .w600, color: Colors.black54),
                                        textAlign: TextAlign.start,
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.only(top: isMedium ? 21.0 : 11.0),
                                      ),
                                      Text(
                                        'test',
                                        style: new TextStyle(
                                            fontSize: isMedium ? 24.0 : 14.0,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight
                                                .w600, color: Colors.black54),
                                      )
                                    ]
                                )
                              ]
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}