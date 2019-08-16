/// If FCM returns with statusCode != 200 it throws this Exception
class FCMException implements Exception {
  final int statusCode;
  final message;

  FCMException(this.statusCode, [this.message]);
}
