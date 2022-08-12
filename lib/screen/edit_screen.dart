import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:trackingbwa_v2/core/custom/responsive_widget.dart';

class Edit_Screen extends StatefulWidget {
  @override
  _Edit_ScreenState createState() => new _Edit_ScreenState();
}

class _Edit_ScreenState extends State<Edit_Screen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mediumScreen: _formpage(true),
      smallScreen: _formpage(false),
    );
  }
  // This widget is the root of your application.
  Widget _formpage(bool isMedium) {
    // return ScopedModelDescendant<AppModel>(
    //     builder: (BuildContext context, Widget child, AppModel model) {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff20ADDF),
        leading:  GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title:
        Text(
          'Form Tidak Sesuai',
          style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
        ),
        centerTitle: true,
      ),
      body: new ListView(
          children: <Widget>[
            new Container(
              width: 500,
              padding: new EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[

                  new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 12.0),
                        child: new Text("Jumlah Dus",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      new Padding(
                        padding: EdgeInsets.only(left: 20.0),
                      ),
                      Container(
                        width: 290.0,
                        child: new TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                       //   controller: _kodeAssetController,

                          //validator: (e) {
                          //if (e.isEmpty) {
                          // return "Please insert email";
                          // }
                          //},
                          //onSaved: (e) => username = e,
                          autofocus: false,
                          decoration:
                          new InputDecoration(
                            labelText: "Jumlah Dus",
                            labelStyle: TextStyle(color: const Color(0xffBDBDBD),),
                          ),
                          keyboardType: TextInputType
                              .text,
                          //  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        ),
                      )
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 12.0),
                        child: new Text("Jumlah Mushaf",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      new Padding(
                        padding: EdgeInsets.only(left: 20.0),
                      ),
                      Container(
                        width: 290.0,
                        child: new TextFormField(
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                          // controller: _usernameFilter,
                          //validator: (e) {
                          //if (e.isEmpty) {
                          // return "Please insert email";
                          // }
                          //},
                          //onSaved: (e) => username = e,
                          autofocus: false,
                          decoration:
                          new InputDecoration(
                            labelText: "Jumlah Mushaf",
                            labelStyle: TextStyle(color: const Color(0xffBDBDBD),),
                          ),
                          keyboardType: TextInputType
                              .text,
                          //  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        ),
                      )
                    ],
                  ),
                  new Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, bottom: 10.0, top: 12.0),
                        child: new Text("Jumlah Terjemahan",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      new Padding(
                        padding: EdgeInsets.only(left: 20.0),
                      ),
                      Container(
                        width: 290.0,
                        child: new TextFormField(
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                          // controller: _usernameFilter,
                          //validator: (e) {
                          //if (e.isEmpty) {
                          // return "Please insert email";
                          // }
                          //},
                          //onSaved: (e) => username = e,
                          autofocus: false,
                          decoration:
                          new InputDecoration(
                            labelText: "Jumlah Terjemahan",
                            labelStyle: TextStyle(color: const Color(0xffBDBDBD),),
                          ),
                          keyboardType: TextInputType
                              .text,
                          //  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        ),
                      )
                    ],
                  ),
                  new Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, bottom: 10.0, top: 12.0),
                        child: new Text("Kehilangan",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      new Padding(
                        padding: EdgeInsets.only(left: 20.0),
                      ),
                      Container(
                        width: 290.0,
                        child: new TextFormField(
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                          // controller: _usernameFilter,
                          //validator: (e) {
                          //if (e.isEmpty) {
                          // return "Please insert email";
                          // }
                          //},
                          //onSaved: (e) => username = e,
                          autofocus: false,
                          decoration:
                          new InputDecoration(
                            labelText: "Kehilangan",
                            labelStyle: TextStyle(color: const Color(0xffBDBDBD),),
                          ),
                          keyboardType: TextInputType
                              .text,
                          //  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        ),
                      )
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                        child: new Text("Keterangan",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: const Color(0xff757575),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                  new Padding(
                    padding: EdgeInsets.only(top: 11.0),
                  ),
                  Container (
                    width: 300.0,

                    child:
                    new TextField(
                     // controller: controllerKeterangan,
                      maxLines: 2,
                      decoration: new InputDecoration(
                        //fillColor: const Color(0xffFFECB3),
                        //filled: true,
                          enabledBorder: new OutlineInputBorder(

                              borderSide: BorderSide(color: const Color(0xffCBCBCB), width: 3.0),
                              borderRadius: new BorderRadius.circular(5.0))
                      ),
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(top: 35.0),
                  ),
                  SizedBox(
                    width: 208.0,
                    height: 40.0,
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      color: const Color(0xff1FBFD7),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(5.0),
                      onPressed: () {
                        // addData();
                        //  Navigator.of(context).push(new MaterialPageRoute(
                        //   builder: (BuildContext context) => AttendanceMenu(),
                        //   ));
                      },
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'
                        ),
                      ),
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  // FlatButton(
                  //   child: Text("Batalkan",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       fontFamily: 'Poppins',
                  //       fontSize: 14.0,
                  //     ),
                  //   ),
                  //   textColor: const Color(0xff212121),
                  //   onPressed: () {
                  //     //upload1(_image, context);
                  //     // Navigator.of(context).push(new MaterialPageRoute(
                  //     //   builder: (BuildContext context) => MemberPage(model),
                  //     // ));
                  //   },
                  // ),
                ],
              ),
            )
          ]

      ),
    );
    //      }
    //  );
  }
   // );
  }



