import 'dart:convert';
import 'package:crypto/crypto.dart';

String generateHash(String input) {
  var bytes = utf8.encode(input);
  var digest = sha256.convert(bytes);
  return digest.toString();
}

String createGravatarURL(String email) {
  return 'https://www.gravatar.com/avatar/${generateHash(email)}?rating=PG&size=50&default=identicon';
}
