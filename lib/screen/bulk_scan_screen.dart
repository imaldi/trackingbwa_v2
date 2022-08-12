import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
import 'package:trackingbwa_v2/core/custom/responsive_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:trackingbwa_v2/model/bulkscan_model.dart';
import 'package:trackingbwa_v2/model/response_post_model.dart';
import 'package:trackingbwa_v2/screen/history_bulkscan_screen.dart';
import 'package:trackingbwa_v2/screen/home_screen.dart';

import 'package:trackingbwa_v2/screen/edit_screen.dart';
import 'package:trackingbwa_v2/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackingbwa_v2/service/location_service.dart';

class BulkScan extends StatefulWidget {
  final String bulkscan;
  BulkScan(this.bulkscan);
  @override
  _BulkScanState createState() => new _BulkScanState();
}

class _BulkScanState extends State<BulkScan> {
   Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position? _currentPosition;
  String? _currentAddress;
 // BulkScan produk;
  XFile? _image;
  LocationService? locationService = LocationService();
  Completer<GoogleMapController> _controller = Completer();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool _isUpdate = false;
  // TextEditingController barcode,
  //     wakif,
  //     alamat,
  //     lokasi,
  //     kwit,
  //     kodeWakaf,
  //     tanggal,
  //     staff,
  //     statuspengiriman,
  //     latitudes,
  //     longtitudes;

  //ApiService service = ApiService();
  bool? _sukses;
  ResponsePost? responses;

  Set<Marker> _markers = {};
  double latitude = 0;
  double longtitude = 0;
  bool _isLoading = false;
  Directory? appDirectory;
  Stream<FileSystemEntity>? fileStream;
  List<String>? records;

   _getCurrentLocation() {
     geolocator
         .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
         .then((Position position) {
       setState(() {
         _currentPosition = position;
       });

       _getAddressFromLatLng();
     }).catchError((e) {
       print(e);
     });
   }

   _getAddressFromLatLng() async {
     try {
       List<Placemark> p = await geolocator.placemarkFromCoordinates(
           _currentPosition?.latitude, _currentPosition?.longitude);

       Placemark place = p[0];

       setState(() {
         _currentAddress =
         "${place.thoroughfare}, ${place.subLocality},  ${place.locality}, ${place.subAdministrativeArea}";
       });
     } catch (e) {
       print(e);
     }
   }

  @override
  void initState() {
    //getKampretos();
    super.initState();
    _getCurrentLocation();
    records = [];
    getApplicationDocumentsDirectory().then((value) {
      appDirectory = value;
      appDirectory?.list().listen((onData) {
        records?.add(onData.path);
      }).onDone(() {
        records = records?.reversed.toList();
        setState(() {});
      });
    });

    // barcode = TextEditingController();
    // wakif = TextEditingController();
    // kwit = TextEditingController();
    // kodeWakaf = TextEditingController();
    // alamat = TextEditingController();
    // lokasi = TextEditingController();
    // statuspengiriman = TextEditingController();
    // staff = TextEditingController();
    // alamat = TextEditingController();
    // latitudes = TextEditingController();
    // longtitudes = TextEditingController();

    locationService?.locationStream.listen((userLocation) {
      setState(() {
        latitude = userLocation.latitude ?? 0.0;
        longtitude = userLocation.longtitude ?? 0.0;
      });
    });
  }



  @override
  void dispose() {
    locationService?.dispose();
    _getCurrentLocation();
    super.dispose();
  }

  // @override
  // void main() {
  //   SdkContext.init(isolateOrigin.main);
  //   super.initState();
  // }

  // void cekValidasi() async {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //
  //     // if (_isUpdate) {
  //     //   responses = await service.updateBarang(
  //     //       _idBarang, _nmBarang.text, _jmlBarang.text, _urlBarang.text);
  //     // } else {
  //     responses = await Network().postScan(
  //         barcode.text,
  //         wakif.text,
  //         alamat.text,
  //         lokasi.text,
  //         kwit.text,
  //         kodeWakaf.text,
  //         tanggal.text,
  //         staff.text,
  //         statuspengiriman.text,
  //         longtitudes.text,
  //         latitudes.text);
  //
  //     _sukses = responses.success;
  //
  //     if (_sukses) {
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, Home.id, (Route<dynamic> route) => false);
  //       setState(() {});
  //       Toast.show('Berhasil', context);
  //     } else {
  //       Toast.show('Gagal', context);
  //     }
  //   } else {
  //     _validate = true;
  //   }
  // }

  String? validator(String value) {
    if (value.isEmpty)
      return "jangan kosong";
    else
      return null;
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
    // ScaffoldMessenger.showSnackBar(snackBar);
  }

  Future getImage(ImageSource media) async {
    var img = await ImagePicker().pickImage(source: media);
    setState(() {
      _image = img;
    });
  }

  Future<DataBulk> getKampretos() async {
    final response = await http
        .get(Uri(scheme: 'http://203.171.221.226:88/backend_inventory/api/posts/' + '${widget.bulkscan}'));

    if (response.statusCode == 200) {
      var detailcuk = json.decode(response.body);
      var userdatas = (detailcuk as Map<String, dynamic>)['data'];
      return DataBulk.fromJson(userdatas[0]);
    } else {
      throw Exception('Server Terputus');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mediumScreen: _builddetaillayout(true),
      smallScreen: _builddetaillayout(false),
    );
  }





  Widget _builddetaillayout(bool isMedium) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xff20ADDF),
        title:  Text(
          'Detail Barang',
          style: TextStyle(
              fontSize: isMedium ? 28.0 : 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'),
        ),
      ),
      body: Center(
        child: FutureBuilder<DataBulk>(
          future: getKampretos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                key: _formKey,
                children: <Widget>[
                  Text("Nomor PC : ${snapshot.data?.nomor_pc}",
                      style: TextStyle(fontSize: 20)),
                  Text("Project : ${snapshot.data?.project}",
                      style: TextStyle(fontSize: 20)),
                  Text("Program : ${snapshot.data?.program}",
                      style: TextStyle(fontSize: 20)),
                  Text("Tujuan : ${snapshot.data?.tujuan}",
                      style: TextStyle(fontSize: 20)),
                  Text("Provinsi : ${snapshot.data?.provinsi}",
                      style: TextStyle(fontSize: 20)),
                  Text("Kecamatan : ${snapshot.data?.kecamatan}",
                      style: TextStyle(fontSize: 20)),
                  Text("Kabupaten : ${snapshot.data?.kabupaten}",
                      style: TextStyle(fontSize: 20)),
                  Text("Desa : ${snapshot.data?.desa}",
                      style: TextStyle(fontSize: 20)),
                  Text("Terjemahan : ${snapshot.data?.terjemahan}",
                      style: TextStyle(fontSize: 20)),
                  Text("Mushaf : ${snapshot.data?.mushaf}",
                      style: TextStyle(fontSize: 20)),
                  // ListTile(
                  //   leading: Icon(Icons.check),
                  //   title: Text("Ambil Gambar"),
                  //   trailing: new IconButton(
                  //     icon: new Icon(Icons.camera_alt),
                  //     highlightColor: Colors.pink,
                  //     onPressed: () {
                  //       myAlert();
                  //     },
                  //   ),
                  // ),
                  //---
                  // Column(
                  //   children: <Widget>[
                  //     Padding(
                  //       padding:
                  //           const EdgeInsets.only(left: 16, top: 16, right: 16),
                  //       child: _image == null
                  //           ? GestureDetector(
                  //               onTap: () {
                  //                 myAlert();
                  //               },
                  //               child: Container(
                  //                 height: 100,
                  //                 width: 100,
                  //                 child: CircleAvatar(
                  //                   radius: 100,
                  //                 ),
                  //               ),
                  //             )
                  //           : ClipRRect(
                  //               borderRadius: BorderRadius.circular(8),
                  //               child: Image.file(
                  //                 _image,
                  //                 fit: BoxFit.cover,
                  //                 width: MediaQuery.of(context).size.width,
                  //                 height:
                  //                     MediaQuery.of(context).size.height / 2,
                  //               ),
                  //             ),
                  //     ),
                  //   ],
                  // ),

                  //---
                  // ListTile(
                  //   leading: Icon(Icons.check),
                  //   title: Text("Rekam Suara"),
                  //   trailing: Icon(Icons.mic),
                  //   onTap: () {
                  //     debugPrint("Tapped!");
                  //   },
                  // ),
                  //---

                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        new Text(
                          "Your Location",
                          style: new TextStyle(
                            fontSize: isMedium ? 24.0 : 14.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight
                                .w600, color: Colors.black,),
                        ),
                        new Padding(
                          padding: EdgeInsets.only(
                              top: isMedium ? 16.0 :6.0),
                        ),
                        Container(
                          width: isMedium ? 310.0 : 300.0,
                          height: isMedium ? 70.0 : 60.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            width: 1.0
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                              child: Text('${_currentAddress}',
                                  style: new TextStyle(
                                    fontSize: isMedium ? 24.0 : 14.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight
                                        .w600, color: const Color(0xff20ADDF)),
                                textAlign: TextAlign.center,
                              )
                          ),
                        ),

                        new Padding(
                          padding: EdgeInsets.only(
                              top: isMedium ? 28.0 : 18.0),
                        ),
                        new Text(
                          "Capture Your Package",
                          style: new TextStyle(
                            fontSize: isMedium ? 24.0 : 14.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight
                                .w600, color: Colors.black,),
                        ),
                        new Padding(
                          padding: EdgeInsets.only(
                              top: isMedium ? 22.0 : 12.0),
                        ),
                        new Container(
                          // padding: const EdgeInsets.only(right: 12.0),8
                            width:  isMedium ? 89.0 : 79.0,
                            height: isMedium ? 89.0 : 79.0,
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
                            child:    Container(
                              width:  isMedium ? 89.0 : 79.0,
                              height: isMedium ? 89.0 : 79.0,
                              // constraints: BoxConstraints(minWidth: 33.0 * SizeConfig.heightMultiplier, maxWidth: 33.0 * SizeConfig.heightMultiplier),
                              child :   new SizedBox(
                                //   width: 217.0,
                                //   height: 35.0,
                                child: new RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(
                                          10.0)),
                                  color: Colors.white,
                                  onPressed: () {
                                    myAlert();
                                  },
                                  child: new SvgPicture.asset(
                                          'assets/icon/camera.svg',
                                          //   fit: BoxFit.fill,
                                          // height: isMedium ? 35.0 : 25.0,
                                          // width: isMedium ? 35.0 : 25.0,
                                          //fit: BoxFit.scaleDown,
                                        ),
                                ),
                              ),
                            )
                        ),

                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: isMedium ? 35.0 : 25.0),
                              child:
                              SizedBox(
                                //constraints: BoxConstraints(minHeight: 6.5 * SizeConfig.heightMultiplier, maxHeight: 7.9 * SizeConfig.heightMultiplier),
                                width: isMedium ? 178.0 : 168.0,
                                height: isMedium ? 44.0 : 34.0,
                                child: FlatButton(
                                  shape: new RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: const Color(0xff1EA7E2),
                                      width: 1,
                                    ),
                                    borderRadius: new BorderRadius.circular(10.0),
                                  ),
                                  textColor: const Color(0xff1EA7E2),
                                  padding: EdgeInsets.all(5.0),
                                  onPressed: () {
                                    Navigator.of(context).push(new MaterialPageRoute(
                                      builder: (BuildContext context) => HistoryBulkScan(),
                                    ));
                                  },
                                  child: Text(
                                    "History",
                                    style: TextStyle(
                                        fontSize: isMedium ? 24.0 : 14.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        new Padding(
                          padding: EdgeInsets.only(
                              top: isMedium ? 24.0 : 14.0),
                        ),
                        Container(
                          width: isMedium ? 178.0 : 168.0,
                          height: isMedium ? 44.0 : 34.0,
                          // constraints: BoxConstraints(minWidth: 33.0 * SizeConfig.heightMultiplier, maxWidth: 33.0 * SizeConfig.heightMultiplier),
                          child :   new SizedBox(
                            //   width: 217.0,
                            //   height: 35.0,
                            child: new RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(
                                      10.0)),
                              color: const Color(0xff1FBFD7),
                              onPressed: () {
                                _showMyDialog();
                                // loginUser();
                              },
                              child: new Text(
                                "Simpan",
                                style: new TextStyle(
                                  fontSize: isMedium ? 24.0 : 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight
                                      .w700, color: const Color(0xffFFFFFF),),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("Server Gagal Load");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  //---maps
  Widget _buildGoogleMap(BuildContext context) {
    final CameraPosition _initPosition =
        CameraPosition(target: LatLng(latitude, longtitude), zoom: 14.5);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initPosition,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            _markers.add(Marker(
              markerId: MarkerId('marker_1'),
              position: LatLng(latitude, longtitude),
            ));
          });
        },
        minMaxZoomPreference: MinMaxZoomPreference(16, 18),
        myLocationEnabled: true,
      ),
    );
  }

//---dialog All
  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Apakah Data Sudah Sesuai ?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Tidak'),
                onPressed: () async {
                  await _showMyDialogForm();
                },
              ),
              TextButton(
                child: Text('Ya'),
                onPressed: ()  {
                 // await _showMyDialogForm();
                },
              ),
            ],
          );
        });
  }

  Future<void> _showMyDialogForm() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Membuat Form Keterangan ?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Scan Ulang'),
                onPressed: () async {
                  await BarcodeScanner.scan().then((String bulkDetail) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BulkScan(bulkDetail)));
                  });
                }
              ),
              TextButton(
                child: Text('Ya'),
                onPressed: () {
                   Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Edit_Screen(),
                  ));
                },
              ),
            ],
          );
        });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
