import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackingbwa_v2/model/response_post_model.dart';

class Network {
  final String _url = 'http://203.171.221.226:88/backend_inventory/api/';
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token') ?? "" )['token'];
    //AuthUtils.authTokenKey
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri(scheme: fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.get(Uri(scheme: fullUrl), headers: _setHeaders());
  }

  getDatas(apiUrl) async {
    var fullUrl = _url + apiUrl;
    // await _getToken();
    return await http.get(Uri(scheme: fullUrl), headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  // Future<ResponsePost> postScan(barcode, wakif, alamat, lokasi, kwit, kodeWakaf,
  //     tanggal, staff, statuspengiriman, longtitude, latitude) async {
  //   final responses = await http.post('$_url/store', body: {
  //     'nomor_pc': barcode,
  //     'project': wakif,
  //     'program': alamat,
  //     'tujuan': lokasi,
  //     'tanggal' : tanggal,
  //     'lokasi' : lokasi,
  //     'staff' : staff,
  //     'status_pengiriman': statuspengiriman,
  //     'keterangan': keterangan,
  //     'latitude' : latitude,
  //     'longitude' : longtitude,
  //     //'file' :
  //   });
  //
  //   if (responses.statusCode == 200) {
  //     ResponsePost responseRequest =
  //         ResponsePost.fromJson(jsonDecode(responses.body));
  //
  //     return responseRequest;
  //   } else {
  //     return null;
  //   }
  // }
}
