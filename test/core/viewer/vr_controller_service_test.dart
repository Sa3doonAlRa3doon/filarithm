import 'package:filarithm/core/viewer/vr_controller_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('normalizes Android gamepad axes and triggers', () {
    final event = VrControllerEvent.fromMessage({
      'type': 'axes',
      'leftX': 1.4,
      'leftY': -2,
      'rightX': 0.25,
      'rightY': -0.5,
      'hatX': 1,
      'hatY': -1,
      'leftTrigger': -0.2,
      'rightTrigger': 3,
    });

    expect(event?.type, VrControllerEventType.axes);
    expect(event?.leftX, 1);
    expect(event?.leftY, -1);
    expect(event?.rightX, 0.25);
    expect(event?.rightY, -0.5);
    expect(event?.leftTrigger, 0);
    expect(event?.rightTrigger, 1);
  });

  test('parses button state and rejects malformed events', () {
    final event = VrControllerEvent.fromMessage({
      'type': 'key',
      'keyCode': 96,
      'pressed': true,
    });

    expect(event?.type, VrControllerEventType.key);
    expect(event?.keyCode, 96);
    expect(event?.pressed, isTrue);
    expect(VrControllerEvent.fromMessage({'type': 'key'}), isNull);
    expect(VrControllerEvent.fromMessage('not a map'), isNull);
  });
}
