import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens a phone dialer for [phoneNumber].
Future<void> launchPhoneCall(String phoneNumber) async {
  final uri = Uri(scheme: 'tel', path: phoneNumber.replaceAll(' ', ''));
  await _launch(uri);
}

/// Opens the default mail client for [email].
Future<void> launchEmail(String email) async {
  final uri = Uri(scheme: 'mailto', path: email);
  await _launch(uri);
}

Future<void> _launch(Uri uri) async {
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    if (kDebugMode) {
      debugPrint('Could not launch $uri');
    }
  }
}
