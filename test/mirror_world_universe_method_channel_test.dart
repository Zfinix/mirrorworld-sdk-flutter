/* import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mirror_world_flutter/mirror_world_flutter.dart';

void main() {
  MethodChannelMirrorWorldFlutter platform =
      MethodChannelMirrorWorldFlutter();
  const MethodChannel channel = MethodChannel('mirror_world_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.init(), '42');
  });
}
 */