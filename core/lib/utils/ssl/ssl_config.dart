import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpSSLPinning {
  // Singleton pattern
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await _createLEClient();
  static http.Client? _clientInstance;

  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await _instance;
  }

  // Create an HTTP client with SSL pinning
  static Future<http.Client> _createLEClient() async {
    // Load the PEM certificate from assets

    final sslPemString = await rootBundle
        .load('packages/core/assets/certificates/certificates.pem');

    SecurityContext context = SecurityContext(withTrustedRoots: false);
    context.setTrustedCertificatesBytes(sslPemString.buffer.asUint8List());

    // Configure the HttpClient with SSL pinning
    final HttpClient client = HttpClient(context: context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    return IOClient(client);
  }
}
