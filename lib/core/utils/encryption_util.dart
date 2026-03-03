import 'dart:convert';
import 'package:crypto/crypto.dart';

class EncryptionUtil {
  static String generateSHA1(String input) {
    final bytes = utf8.encode(input);
    final digest = sha1.convert(bytes);
    return digest.toString();
  }

  static String generateMD5(String input) {
    final bytes = utf8.encode(input);
    final digest = md5.convert(bytes);
    return digest.toString();
  }
}
