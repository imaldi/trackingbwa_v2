import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trackingbwa_v2/core/custom/responsive_widget.dart';
import 'package:trackingbwa_v2/core/custom/size_config.dart';
import 'package:trackingbwa_v2/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackingbwa_v2/screen/home_screen.dart';
import 'package:trackingbwa_v2/screen/register_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() =>  _LoginState();
}

class _LoginState extends State<Login> {
  bool _secureText = true;
  bool _isLoading = false;
  var email;
  var password;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email =  TextEditingController();
  TextEditingController _password =  TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  Future<bool> _onbackStart() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Apa kamu ingin keluar dari Aplikasi ?..."),
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
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mediumScreen: _logininventory(true),
      smallScreen: _logininventory(false),
    );
  }


  Widget _logininventory(bool isMedium) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            //    return ScopedModelDescendant<AppModel>(
            //    builder: (BuildContext context, Widget child, AppModel model) {
            return Scaffold(
                key: _scaffoldKey,
                resizeToAvoidBottomInset: true,
                body:  ListView(
                  //   shrinkWrap: true,
                  //   reverse: false,
                  children: <Widget>[
                     Column(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //    mainAxisSize: MainAxisSize.max,
                      //    crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                           Padding(
                            padding: EdgeInsets.only(top: isMedium ? 40.0 : 30),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0 * (SizeConfig.heightMultiplier ?? 1.0)),
                            child:  SvgPicture.asset(
                              'assets/images/bwa.svg',
                              //   fit: BoxFit.fill,
                              //  height: 351.0,
                              //   width: 400.0,
                              //fit: BoxFit.scaleDown,
                            ),
                          ),
                           Padding(
                            padding: EdgeInsets.only(top: isMedium ? 15 : 5.0),
                          ),
                          // Column(
                          // height: size.height / 2,
                          //decoration: BoxDecoration(
                          //  color: Theme.of(context).primaryColor,
                          //  borderRadius: BorderRadius.only(
                          //  bottomLeft: Radius.circular(20.0),
                          //  bottomRight: Radius.circular(20.0),
                          //),
                           Text("TRACKING",
                            style: TextStyle(
                                fontSize: isMedium ? 40 : 30.0,
                                color: const Color(0xff20B3DD),
                                fontFamily: 'Orbitron',
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                           Padding(
                            padding: EdgeInsets.only(top: isMedium ? 25.0 : 15.0),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0 * (SizeConfig.heightMultiplier ?? 1.0)),
                            child:  Image.asset(
                              'assets/images/vector.png',
                              //   fit: BoxFit.fill,
                              //  height: 351.0,
                              //   width: 400.0,
                              //fit: BoxFit.scaleDown,
                            ),
                          ),
                        ]
                    ),
                     Padding(
                      padding: EdgeInsets.only(top: isMedium ? 35.0 : 25.0),
                    ),
                     Container(
                      // padding: const EdgeInsets.only(right: 12.0),8
                      //constraints: BoxConstraints(minWidth: isMedium ? 52.0 : 42.0, maxWidth:  isMedium ? 52.0 : 42.0,
                      //    minHeight: isMedium ? 50.0 : 50.0, maxHeight:  isMedium ? 50.0 : 50.0),
                        height: isMedium ? 270.0 : 260.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child : Column(
                          children: [
                             Padding(
                              padding: EdgeInsets.only(top: isMedium ? 25.0 : 15.0),
                            ),
                             Text("Log In Your Account",
                              style: TextStyle(
                                  fontSize: isMedium ? 27.0 : 17.0,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                             Padding(
                              padding: EdgeInsets.only(top: isMedium ? 34.0 : 24.0),
                            ),
                             Center(
                              child:  Form(
                                key: _formKey,
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: [
                                     Container(
                                      // padding: const EdgeInsets.only(right: 12.0),8

                                      width:  isMedium ? 280.0 : 270.0,
                                      height: isMedium ? 48.0 : 38.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 3.0,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Form(
                                        // key: _formKey,
                                        child :  TextFormField(
                                          controller: _email,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: isMedium ? 22.0 : 12.0,
                                            fontFamily: 'Poppins',
                                          ),
                                          //validator: (e) {
                                          //if (e.isEmpty) {
                                          // return "Please insert email";
                                          // }
                                          //},
                                          //onSaved: (e) => username = e,
                                          autofocus: false,
                                          decoration:
                                           InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                                            //hintText: hint,
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintText: "Your Email",
                                            hintStyle: TextStyle(
                                              fontSize: isMedium ? 24.0 : 14.0,
                                              fontWeight: FontWeight.w300,
                                              color: const Color(0xffBDBDBD),
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          keyboardType: TextInputType
                                              .emailAddress,
                                          validator: (emailValue) {
                                            if (emailValue?.isEmpty ?? true) {
                                              return 'Please enter email';
                                            }
                                            email = emailValue;
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                     Padding(
                                      padding: EdgeInsets.only(top: isMedium ? 25.0 : 15.0),
                                    ),
                                     Container(
                                      //padding: const EdgeInsets.only(right: 12.0),
                                        width:  isMedium ? 280.0 : 270.0,
                                        height: isMedium ? 48.0 : 38.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 3.0,
                                              spreadRadius: 1.0,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Form(
                                            child :  TextFormField(
                                              obscureText: _secureText,
                                              //onSaved: (e) => password = e,
                                              //obscureText: true,
                                              autofocus: false,
                                              controller: _password,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: isMedium ? 22.0 : 12.0,
                                                fontFamily: 'Poppins',
                                              ),
                                              decoration:  InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder: InputBorder.none,
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                  fontSize: isMedium ? 24.0 : 14.0,
                                                  fontWeight: FontWeight.w300,
                                                  color: const Color(0xffBDBDBD),
                                                  fontFamily: 'Poppins',
                                                ),
                                                suffixIcon: IconButton(
                                                  onPressed: showHide,
                                                  icon: Icon(_secureText
                                                      ? Icons.visibility_off
                                                      : Icons.visibility, size:  isMedium ? 28.0 : 18.0, color: const Color(0xff20ADDF),),
                                                ),
                                              ),
                                              keyboardType: TextInputType
                                                  .text,
                                              validator: (passwordValue) {
                                                if (passwordValue?.isEmpty ?? true) {
                                                  return 'Please enter password';
                                                }
                                                password = passwordValue;
                                                return null;
                                              },
                                            )
                                        )),
                                     Padding(
                                      padding: EdgeInsets.only(top: isMedium ? 25.0 : 15.0),
                                    ),
                                    Text(
                                      'Forgot Your Password ?',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: isMedium ? 24.0 : 14.0,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff20ADDF),
                                      ),
                                    ),
                                     Padding(
                                      padding: EdgeInsets.only(top: isMedium ? 28.0 : 18.0),
                                    ),
                                    Container(
                                      width: isMedium ? 227.0 : 217.0,
                                      height: isMedium ? 53.0 : 43.0,
                                      // constraints: BoxConstraints(minWidth: 33.0 * SizeConfig.heightMultiplier, maxWidth: 33.0 * SizeConfig.heightMultiplier),
                                      child :    SizedBox(
                                        //   width: 217.0,
                                        //   height: 35.0,
                                        child:  RaisedButton(
                                          shape:  RoundedRectangleBorder(
                                              borderRadius:
                                               BorderRadius.circular(
                                                  10.0)),
                                          color: const Color(0xff1FBFD7),
                                          onPressed: () {
                                            if (_formKey.currentState?.validate() ?? false) {
                                              _login();
                                            }
                                            // loginUser();
                                          },
                                          child:  Text(
                                            "Login",
                                            style:  TextStyle(
                                              fontSize: isMedium ? 26.0 : 16.0,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight
                                                  .w700, color: const Color(0xffFFFFFF),),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ],
                        )
                    )],
                ));
          },
        );
      },
    );

  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': _email.text, 'password': _password.text};

    var res = await Network().authData(data, 'login');
    var body = json.decode(res.body);
    print(body);
    if (body["success"]) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
         MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
//-----

}
