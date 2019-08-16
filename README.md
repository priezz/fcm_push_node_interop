# fcm_push_node_interop

> A Dart interface to Firebase Cloud Messaging (FCM) for NodeJS
> To be used as a library in your Dart projects, compiled to NodeJS.

## Prerequisite

- [Setup FireBase](https://firebase.google.com/docs/cloud-messaging/)
- [Get server key (StackOverflow)](https://stackoverflow.com/a/42439563/504184)

For the `serverKey` go to your Firebase console / Settings:

![Screenshot](https://raw.githubusercontent.com/MikeMitterer/dart-fcm-push/master/doc/images/server-key.png)

## Usage

```dart
import 'package:fcm_push_node_interop/fcm_push_node_interop.dart';

final String _serverKey = "";
final String _token = "";

Future<int> main() async {
  final fcm = FCM(_serverKey);
  final messageID = await fcm.send(
    data: {'key': 'value'},
    text: 'Hello, world!',
    title: 'Message title',
    to: _token,
  );
}
```

## Links

- [Send messages to specific devices](https://firebase.google.com/docs/cloud-messaging/send-message#send_messages_to_specific_devices)

## License

Copyright (c) 2019, Alexandr Priezzhev <a@priezz.net>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
either express or implied. See the License for the specific language
governing permissions and limitations under the License.
