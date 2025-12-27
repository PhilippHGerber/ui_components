import 'package:jaspr/dom.dart' show Styles, div;
import 'package:jaspr/jaspr.dart';

import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'mockup_phone_style.dart';

/// A component that renders a box styled to look like an Phone mockup.
///
/// This component is a smart container that automatically creates the phone frame,
/// the camera notch, and the display area. You only need to provide the content
/// that should appear on the screen.
///
/// Example Usage:
/// ```dart
/// MockupPhone(
///   style: [BorderUtil.primary],
///   content: Container(
///     [
///       img(src: '/images/wallpaper.jpg', alt: 'Wallpaper')
///     ],
///   ),
/// )
/// ```
class MockupPhone extends UiComponent {
  /// Creates a [MockupPhone] component.
  ///
  /// - [content]: The `Component` to display inside the phone's screen area.
  /// - [style]: A list of [MockupPhoneStyling] instances for applying
  ///   general utilities like borders or colors to the phone's frame.
  /// - Other parameters are inherited from [UiComponent].
  const MockupPhone({
    required this.content,
    List<MockupPhoneStyling>? style,
    super.tag = 'div',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style);

  /// The main content to be displayed on the phone's screen.
  final Component content;

  @override
  String get baseClass => 'mockup-phone';

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      events: eventMap,
      children: [
        // The camera notch is rendered automatically.
        const div(classes: 'mockup-phone-camera', []),
        // The display area wraps the user-provided content.
        div(classes: 'mockup-phone-display', [content]),
      ],
    );
  }

  @override
  MockupPhone copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    Component? content,
  }) {
    return MockupPhone(
      content: content ?? this.content,
      style: style as List<MockupPhoneStyling>?,
      tag: tag,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}
