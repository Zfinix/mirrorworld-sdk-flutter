/* import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mirror_world_universe/mirror_world_universe.dart';

void main() {
  MethodChannelMirrorworldUniverse platform =
      MethodChannelMirrorworldUniverse();
  const MethodChannel channel = MethodChannel('mirror_world_universe');

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