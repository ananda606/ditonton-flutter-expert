import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/services.dart';

class SSLPinningClient extends IOClient {
  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    return await Sharing.initializeIOClient().then((value) => value.get(url));
  }
}

class Sharing {
  static Future<IOClient> initializeIOClient() async {
    final ByteData sslCert = await rootBundle.load('assets/certificate.cer');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    HttpClient httpClient = HttpClient(context: securityContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    return IOClient(httpClient);
  }
}
