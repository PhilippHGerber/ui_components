import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart';

// Event handler type definitions
// These type definitions ensure that we use the same types everywhere
typedef UiMouseEventHandler = void Function(MouseEvent event);
typedef UiKeyboardEventHandler = void Function(KeyboardEvent event);
typedef UiInputEventHandler = void Function(String value);
typedef UiEventHandler = void Function(Event event);

/// Base class for event data
@immutable
class UiEventData {
  const UiEventData({required this.originalEvent, required this.target, this.detail = const <String, Object>{}});
  final Event originalEvent;
  final Object target;
  final Map<String, Object> detail;
}

@immutable
class UiMouseEventData extends UiEventData {
  const UiMouseEventData({
    required super.originalEvent,
    required super.target,
    required this.clientX,
    required this.clientY,
    required this.ctrlKey,
    required this.shiftKey,
    super.detail,
  });

  // Factory method with the proper property names
  factory UiMouseEventData.fromEvent(MouseEvent event, Object target) {
    return UiMouseEventData(
      originalEvent: event,
      target: target,
      clientX: event.clientX,
      clientY: event.clientY,
      ctrlKey: event.ctrlKey,
      shiftKey: event.shiftKey,
    );
  }
  final num clientX;
  final num clientY;
  final bool ctrlKey;
  final bool shiftKey;
}

@immutable
class UiKeyboardEventData extends UiEventData {
  const UiKeyboardEventData({
    required super.originalEvent,
    required super.target,
    required this.key,
    required this.ctrlKey,
    required this.shiftKey,
    super.detail,
  });

  // Factory method with the proper property names
  factory UiKeyboardEventData.fromEvent(KeyboardEvent event, Object target) {
    return UiKeyboardEventData(
      originalEvent: event,
      target: target,
      key: event.key,
      ctrlKey: event.ctrlKey,
      shiftKey: event.shiftKey,
    );
  }
  final String key;
  final bool ctrlKey;
  final bool shiftKey;
}

EventCallback createEventHandler(void Function(Event event) handler) {
  return (dynamic rawEvent) {
    final Event event = rawEvent as Event;
    handler(event);
  };
}

EventCallback createMouseEventHandler(void Function(MouseEvent event) handler) {
  return (dynamic rawEvent) {
    final MouseEvent event = rawEvent as MouseEvent;
    handler(event);
  };
}
