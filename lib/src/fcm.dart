import 'dart:async';
import 'dart:convert';
import 'package:node_http/node_http.dart' as http;

import 'exception.dart';
import 'message.dart';

export 'message.dart';

/// FCM Option defined here: https://firebase.google.com/docs/cloud-messaging/server
/// Don't know why you should overwrite these settings but you can.
class _FCMOptions {
  static const keepAlive = true;
  // final headers = <String, String>{};
  static const host = 'fcm.googleapis.com';
  // static const method = 'POST';
  static const path = '/fcm/send';
  static const port = 443;
}

class FCM {
  /// FCM-Options: https://firebase.google.com/docs/cloud-messaging/server
  FCM(this._serverKey);
  final String _serverKey;

  /// Sends the [FCMMessage] and returns the 'message_id'
  /// https://firebase.google.com/docs/cloud-messaging/http-server-ref#table4
  Future<String> send({
    String collapseKey,
    Map<String, dynamic> data = const <String, dynamic>{},
    bool logging = false,
    String text,
    String title,
    String to,
  }) async {
    final message = FCMMessage(
      collapseKey: collapseKey,
      data: {
        ...data,
        'body': text,
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'title': title,
      },
      text: text,
      title: title,
      to: to,
    );
    final Uri uri = Uri(
      host: _FCMOptions.host,
      path: _FCMOptions.path,
      port: _FCMOptions.port,
      scheme: 'https',
    );
    final headers = <String, String>{
      'Authorization': 'key=$_serverKey',
      if (_FCMOptions.keepAlive)
        'Connection': 'keep-alive',
      'Content-Type': 'application/json',
      // 'Host': _FCMOptions.host,
    };

    final http.Response response =
        await http.post(uri, headers: headers, body: '$message');

    if (logging) print('Status code: ${response.statusCode}');
    try {
      /// https://firebase.google.com/docs/cloud-messaging/http-server-ref#table4
      final result = json.decode(response.body);
      if (logging) print('Response: $result');
      if (response.statusCode == 200 &&
          int.parse(result['success'].toString()) == 1) {
        return result['results'].first['message_id'];
      } else {
        throw FCMException(response.statusCode, response.body);
      }
    } on FormatException {
      return null;
    }
  }
}
