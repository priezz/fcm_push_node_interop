import 'package:test/test.dart';

import 'package:fcm_push_node_interop/src/message.dart';

main() {
  group('A group of tests', () {
    setUp(() {});

    test('> Message', () {
      final message = FCMMessage(to: 'Mike');
      expect('$message', '{"to":"Mike"}');
    }); // end of 'Message' test

    test('> Message with data', () {
      final message = FCMMessage(
        data: {'your_custom_data_key': 'your_custom_data_value'},
        to: 'Mike',
      );
      expect('$message',
          '{"to":"Mike","data":{"your_custom_data_key":"your_custom_data_value"}}');
    }); // end of 'Message with data' test
  });
}
