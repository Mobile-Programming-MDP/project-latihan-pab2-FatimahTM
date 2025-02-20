class Karyawan {
  final String nama;
  final int umur;
  final Alamat alamat;

  Karyawan({
    required this.nama,
    required this.umur,
    required this.alamat,
  });

  factory Karyawan.fromJson(Map<String, dynamic> json) {
    return Karyawan(
      nama: json['nama'],
      umur: json['umur'],
      alamat: Alamat.fromJson(json['alamat']),
    );
  }
}

class Alamat {
  final String jalan;
  final String kota;
  final String provinsi;

  Alamat({
    required this.jalan,
    required this.kota,
    required this.provinsi,
  });

  factory Alamat.fromJson(Map<String, dynamic> json) {
    return Alamat(
      jalan: json['jalan'],
      kota: json['kota'],
      provinsi: json['provinsi'],
    );
  }
}
