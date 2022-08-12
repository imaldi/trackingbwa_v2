// import 'package:flutter/material.dart';
// import 'package:tutorial_app/model/bulkscan_model.dart';
// import 'package:tutorial_app/model/response_post_model.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:tutorial_app/screen/location_service.dart';
// import 'package:tutorial_app/screen/home_screen.dart';
// import 'package:tutorial_app/screen/edit_screen.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:tutorial_app/network_utils/api.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toast/toast.dart';
// import 'dart:convert';
// import 'dart:async';
// import 'dart:io';
//
// class Lihat extends StatefulWidget {
//   final String produk2;
//   Lihat(this.produk2);
//   @override
//   _LihatState createState() => new _LihatState();
// }
//
// class _LihatState extends State<Lihat> {
//   Produk produk;
//   File _image;
//   LocationService locationService = LocationService();
//   Completer<GoogleMapController> _controller = Completer();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final _formKey = GlobalKey<FormState>();
//   bool _validate = false;
//   bool _isUpdate = false;
//   TextEditingController barcode,
//       wakif,
//       alamat,
//       lokasi,
//       kwit,
//       kodeWakaf,
//       tanggal,
//       staff,
//       statuspengiriman,
//       latitudes,
//       longtitudes;
//
//   //ApiService service = ApiService();
//   bool _sukses;
//   ResponsePost responses;
//
//   Set<Marker> _markers = {};
//   double latitude = 0;
//   double longtitude = 0;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     //getKampretos();
//     super.initState();
//
//     barcode = TextEditingController();
//     wakif = TextEditingController();
//     kwit = TextEditingController();
//     kodeWakaf = TextEditingController();
//     alamat = TextEditingController();
//     lokasi = TextEditingController();
//     statuspengiriman = TextEditingController();
//     staff = TextEditingController();
//     alamat = TextEditingController();
//     latitudes = TextEditingController();
//     longtitudes = TextEditingController();
//
//     locationService.locationStream.listen((userLocation) {
//       setState(() {
//         latitude = userLocation.latitude;
//         longtitude = userLocation.longtitude;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     locationService.dispose();
//     super.dispose();
//   }
//
//   // @override
//   // void main() {
//   //   SdkContext.init(isolateOrigin.main);
//   //   super.initState();
//   // }
//
//   void cekValidasi() async {
//     if (_formKey.currentState.validate()) {
//       _formKey.currentState.save();
//
//       // if (_isUpdate) {
//       //   responses = await service.updateBarang(
//       //       _idBarang, _nmBarang.text, _jmlBarang.text, _urlBarang.text);
//       // } else {
//       responses = await Network().postScan(
//           barcode.text,
//           wakif.text,
//           alamat.text,
//           lokasi.text,
//           kwit.text,
//           kodeWakaf.text,
//           tanggal.text,
//           staff.text,
//           statuspengiriman.text,
//           longtitudes.text,
//           latitudes.text);
//
//       _sukses = responses.success;
//
//       if (_sukses) {
//         Navigator.pushNamedAndRemoveUntil(
//             context, Home.id, (Route<dynamic> route) => false);
//         setState(() {});
//         Toast.show('Berhasil', context);
//       } else {
//         Toast.show('Gagal', context);
//       }
//     } else {
//       _validate = true;
//     }
//   }
//
//   String validator(String value) {
//     if (value.isEmpty)
//       return "jangan kosong";
//     else
//       return null;
//   }
//
//   _showMsg(msg) {
//     final snackBar = SnackBar(
//       content: Text(msg),
//       action: SnackBarAction(
//         label: 'Close',
//         onPressed: () {
//           // Some code to undo the change!
//         },
//       ),
//     );
//     _scaffoldKey.currentState.showSnackBar(snackBar);
//   }
//
//   Future getImage(ImageSource media) async {
//     var img = await ImagePicker.pickImage(source: media);
//     setState(() {
//       _image = img;
//     });
//   }
//
//   Future<Produk> getKampretos() async {
//     final response = await http
//         .get('https://ed0c14979138.ngrok.io/api/posts/' + '${widget.produk2}');
//
//     if (response.statusCode == 200) {
//       var detailcuk = json.decode(response.body);
//       var userdatas = (detailcuk as Map<String, dynamic>)['data'];
//       return Produk.fromJson(userdatas[0]);
//     } else {
//       throw Exception('Server Terputus');
//     }
//   }
//
//   // @override
//   // void initState() {
//   //   getKampretos();
//   //   super.initState();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Text('Scan BWA Tracking'),
//       ),
//       body: Center(
//         child: FutureBuilder<Produk>(
//           future: getKampretos(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView(
//                 key: _formKey,
//                 children: <Widget>[
//                   TextFormField(
//                     controller: barcode,
//                     //autofillHints: [AutofillHints.barcode],
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(), labelText: 'Url Barang'),
//                     validator: validator,
//                   ),
//                   Text("wakif : ${snapshot.data.barcode}",
//                       style: TextStyle(fontSize: 20)),
//                   Text("wakif : ${snapshot.data.wakif}",
//                       style: TextStyle(fontSize: 20)),
//                   Text("alamat : ${snapshot.data.alamat}",
//                       style: TextStyle(fontSize: 20)),
//                   Text("lokasi : ${snapshot.data.lokasi}",
//                       style: TextStyle(fontSize: 20)),
//                   Text("kwit : ${snapshot.data.kwit}",
//                       style: TextStyle(fontSize: 20)),
//                   Text("kode wakaf : ${snapshot.data.kodeWakaf}",
//                       style: TextStyle(fontSize: 20)),
//                   Text("tanggal : ${snapshot.data.tanggal}",
//                       style: TextStyle(fontSize: 20)),
//                   Text("staff : ${snapshot.data.staff}",
//                       style: TextStyle(fontSize: 20)),
//                   ListTile(
//                     leading: Icon(Icons.check),
//                     title: Text("Ambil Gambar"),
//                     trailing: new IconButton(
//                       icon: new Icon(Icons.camera_alt),
//                       highlightColor: Colors.pink,
//                       onPressed: () {
//                         myAlert();
//                       },
//                     ),
//                   ),
//                   //---
//                   Column(
//                     children: <Widget>[
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(left: 16, top: 16, right: 16),
//                         child: _image == null
//                             ? GestureDetector(
//                                 onTap: () {
//                                   myAlert();
//                                 },
//                                 child: Container(
//                                   height: 100,
//                                   width: 100,
//                                   child: CircleAvatar(
//                                     radius: 100,
//                                   ),
//                                 ),
//                               )
//                             : ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.file(
//                                   _image,
//                                   fit: BoxFit.cover,
//                                   width: MediaQuery.of(context).size.width,
//                                   height:
//                                       MediaQuery.of(context).size.height / 2,
//                                 ),
//                               ),
//                       ),
//                     ],
//                   ),
//
//                   //---
//                   ListTile(
//                     leading: Icon(Icons.check),
//                     title: Text("Rekam Suara"),
//                     trailing: Icon(Icons.mic),
//                     onTap: () {
//                       debugPrint("Tapped!");
//                     },
//                   ),
//                   Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         SizedBox(
//                           height: 20.0,
//                         ),
//                         Text.rich(
//                           TextSpan(
//                             style: TextStyle(
//                               fontSize: 17,
//                             ),
//                             children: [
//                               TextSpan(
//                                 text: 'Lokasi Anda Scan :',
//                               ),
//                               TextSpan(
//                                 text: '$latitude' ',' '$longtitude',
//                               )
//                             ],
//                           ),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: <Widget>[
//                             SizedBox(
//                               height: 20.0,
//                             ),
//                             Container(
//                               height: 250,
//                               width: MediaQuery.of(context).size.width,
//                               child: _buildGoogleMap(context),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20.0,
//                         ),
//                         new RaisedButton(
//                           child: new Text("Simpan",
//                               style: TextStyle(color: Colors.white)),
//                           color: const Color(0xFF51AD7F),
//                           onPressed: () {
//                             _showMyDialog();
//                           },
//                         ),
//                         SizedBox(
//                           height: 30.0,
//                         ),
//                       ]),
//                 ],
//               );
//             } else if (snapshot.hasError) {
//               return Text("Server Gagal Load");
//             }
//             return CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
//
//   //---maps
//   Widget _buildGoogleMap(BuildContext context) {
//     final CameraPosition _initPosition =
//         CameraPosition(target: LatLng(latitude, longtitude), zoom: 14.5);
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _initPosition,
//         markers: _markers,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//           setState(() {
//             _markers.add(Marker(
//               markerId: MarkerId('marker_1'),
//               position: LatLng(latitude, longtitude),
//             ));
//           });
//         },
//         minMaxZoomPreference: MinMaxZoomPreference(16, 18),
//         myLocationEnabled: true,
//       ),
//     );
//   }
//
// //---dialog All
//   Future<void> _showMyDialog() async {
//     return showDialog<void>(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Konfirmasi'),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   Text('Apakah Data Sudah Sesuai ?'),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('Tidak'),
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => FtdkSesuai()));
//                   //   FtdkSesuai
//                 },
//               ),
//               TextButton(
//                 child: Text('Ya'),
//                 onPressed: () async {
//                   await _showMyDialogsuccess();
//                 },
//               ),
//             ],
//           );
//         });
//   }
//
//   Future<void> _showMyDialogsuccess() async {
//     return showDialog<void>(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return AlertDialog(
//             // title: Text('Konfirmasi'),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   Text('Data Berhasil Tersimpan'),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('v'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         });
//   }
//
//   void myAlert() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             title: Text('Please choose media to select'),
//             content: Container(
//               height: MediaQuery.of(context).size.height / 6,
//               child: Column(
//                 children: <Widget>[
//                   FlatButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       getImage(ImageSource.gallery);
//                     },
//                     child: Row(
//                       children: <Widget>[
//                         Icon(Icons.image),
//                         Text('From Gallery'),
//                       ],
//                     ),
//                   ),
//                   FlatButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       getImage(ImageSource.camera);
//                     },
//                     child: Row(
//                       children: <Widget>[
//                         Icon(Icons.camera),
//                         Text('From Camera'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   // void _login() async {
//   //   setState(() {
//   //     _isLoading = true;
//   //   });
//   //   var data = {'barcode': barcodes, 'password': password};
//
//   //   var res = await Network().authData(data, 'login');
//   //   var body = json.decode(res.body);
//   //   print(body);
//   //   if (body["success"]) {
//   //     SharedPreferences localStorage = await SharedPreferences.getInstance();
//   //     localStorage.setString('token', json.encode(body['token']));
//   //     localStorage.setString('data', json.encode(body['data']));
//   //     Navigator.push(
//   //       context,
//   //       new MaterialPageRoute(builder: (context) => Home()),
//   //     );
//   //   } else {
//   //     _showMsg(body['message']);
//   //   }
//
//   //   setState(() {
//   //     _isLoading = false;
//   //   });
//   // }
// }
