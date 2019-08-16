import 'dart:convert';

/// https://firebase.google.com/docs/cloud-messaging/http-server-ref
class FCMMessage {
  FCMMessage({
    this.text,
    this.collapseKey,
    this.data = const <String, dynamic>{},
    this.title,
    this.to,
  });
  final String collapseKey;
  final Map<String, dynamic> data;
  final String text;
  final String title;
  final String to;

  Map<String, dynamic> _toJson() {
    final json = <String, dynamic>{};

    json['to'] = to;
    if (_hasCollapseKey) json['collapse_key'] = collapseKey;
    if (_hasData) json['data'] = <String, dynamic>{};
    data.forEach((key, value) => json['data'][key] = value);
    if (_hasTitle || _hasBody) {
      json['notification'] = <String, dynamic>{};
      if (_hasTitle) json['notification']['title'] = title;
      if (_hasBody) json['notification']['body'] = text;
    }

    return json;
  }

  @override
  String toString() => json.encode(_toJson());

  bool get _hasTitle => (title ?? '').isNotEmpty;
  bool get _hasBody => (text ?? '').isNotEmpty;
  bool get _hasCollapseKey => (collapseKey ?? '').isNotEmpty;
  bool get _hasData => (data ?? {}).isNotEmpty;
}
