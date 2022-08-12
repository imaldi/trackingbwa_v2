import 'dart:convert';

class DataBulk {
  int? idPermintaan;
  String? nomor_pc;
  String? project;
  String? program;
  String? tujuan;
  String? provinsi;
  String? kecamatan;
  String? kabupaten;
  String? desa;
  String? terjemahan;
  String? mushaf;
  String? status;
  String? updatedAt;
  String? createdAt;

  DataBulk(
      {this.idPermintaan,
      this.nomor_pc,
      this.project,
      this.program,
      this.tujuan,
      this.provinsi,
      this.kecamatan,
      this.kabupaten,
      this.desa,
      this.terjemahan,
      this.mushaf,
      this.status,
      this.updatedAt,
      this.createdAt});

  // factory Produk.fromJson(Map<String, dynamic> json) {
  //   id_status = json['id_status'];
  //   barcode = json['barcode'];
  //   wakif = json['wakif'];
  //   alamat = json['alamat'];
  //   lokasi = json['lokasi'];
  // }

  factory DataBulk.fromJson(Map<String, dynamic> map) {
    return DataBulk(
        idPermintaan: map['id_permintaan'],
        nomor_pc: map['nomor_pc'],
        project: map['project'],
        program: map['program'],
        tujuan: map['tujuan'],
        provinsi: map['provinsi'],
        kecamatan: map['kecamatan'],
        kabupaten: map['kabupaten'],
        desa: map['desa'],
        terjemahan: map['terjemahan'],
        mushaf: map['mushaf'],
        status: map['status'],
        updatedAt: map['updated_at'],
        createdAt: map['created_at']);
  }
}

List<DataBulk> userFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<DataBulk>.from(data.map((item) => DataBulk.fromJson(item)));
}
