/* import 'package:flutter_test/flutter_test.dart';
import 'package:mirror_world_flutter/mirror_world_flutter.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMirrorWorldFlutterPlatform
    with MockPlatformInterfaceMixin
    implements MirrorWorldFlutterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MirrorWorldFlutterPlatform initialPlatform =
      MirrorWorldFlutterPlatform.instance;

  test('$MethodChannelMirrorWorldFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMirrorWorldFlutter>());
  });

  test('getPlatformVersion', () async {
    MirrorWorldFlutter mirrorWorldUniversePlugin = MirrorWorldFlutter();
    MockMirrorWorldFlutterPlatform fakePlatform =
        MockMirrorWorldFlutterPlatform();
    MirrorWorldFlutterPlatform.instance = fakePlatform;

    expect(await mirrorWorldUniversePlugin.getPlatformVersion(), '42');
  });
}
 */