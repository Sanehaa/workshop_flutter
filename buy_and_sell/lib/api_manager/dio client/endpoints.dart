class Endpoints {
  Endpoints._();

  //Ports
  static const String serverPort = "4002";

  // base url
  static const String baseUrl = "http://192.168.117.37"; //saneha

  //specific URLs
  // static const String serverURL = "${baseUrl}:${serverPort}";
  static const String serverURL = "http://192.168.117.37:3000";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 15000);

  //get featured prod

  static const String getprods = "/api/products";
  static const String checkout = "/api/checkout";
}
