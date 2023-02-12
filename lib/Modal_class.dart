
class Mnc {
  final int id;
  final String comname;
  final String ceoname;
  final String image;
  final String logo;
  final String dec;
  final int lat;
  final int long;


  Mnc({
    required this.id,
    required this.comname,
    required this.ceoname,
    required this.image,
    required this.logo,
    required this.dec,
    required this.lat,
    required this.long,
  });

  factory Mnc.fromJson({required Map json}){
    return Mnc(
      id: json['id'],
      comname: json['comName'],
      ceoname: json['ceoName'],
      image: json['image'],
      logo: json['logo'],
      dec: json['dec'],
      lat: json['lat'],
      long: json['long'],
    );
  }
}

