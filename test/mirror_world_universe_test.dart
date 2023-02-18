/* import 'package:flutter_test/flutter_test.dart';
import 'package:mirror_world_universe/mirror_world_universe.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMirrorworldUniversePlatform
    with MockPlatformInterfaceMixin
    implements MirrorworldUniversePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MirrorworldUniversePlatform initialPlatform =
      MirrorworldUniversePlatform.instance;

  test('$MethodChannelMirrorworldUniverse is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMirrorworldUniverse>());
  });

  test('getPlatformVersion', () async {
    MirrorworldUniverse mirrorWorldUniversePlugin = MirrorworldUniverse();
    MockMirrorworldUniversePlatform fakePlatform =
        MockMirrorworldUniversePlatform();
    MirrorworldUniversePlatform.instance = fakePlatform;

    expect(await mirrorWorldUniversePlugin.getPlatformVersion(), '42');
  });
}
 */