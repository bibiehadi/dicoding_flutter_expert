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
    try {
      context.setTrustedCertificatesBytes(sslPemString.buffer.asUint8List());
    } catch (e) {
      print("Error setting trusted certificates: $e");
      rethrow;
    }

    // Configure the HttpClient with SSL pinning
    final HttpClient client = HttpClient(context: context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
      print("Host: $host, Port: $port");
      print("Certificate Subject: ${cert.subject}");
      print("Certificate Issuer: ${cert.issuer}");
      return false; // Ensure this doesn't blindly accept certificates
    };

    return IOClient(client);
  }
}
