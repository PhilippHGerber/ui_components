import 'package:jaspr/dom.dart' show Styles, span;
import 'package:jaspr/jaspr.dart';

import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'countdown_style.dart';

/// A component that displays a numerical value with a countdown transition effect.
///
/// The `Countdown` component renders a `<span>` with the `countdown` class.
/// Its animation is triggered purely by CSS when its `value` property changes.
/// The parent component is responsible for updating the `value` over time.
///
/// The value should be an integer between 0 and 99.
///
/// Example of a stateful timer updating a Countdown:
/// ```dart
/// @client
/// class TickingCountdown extends StatefulComponent {
///   // ... state management with a Timer ...
///
///   @override
///   Component build(BuildContext context) {
///     // Pass the changing state value to the simple Countdown component.
///     return Countdown(value: _seconds);
///   }
/// }
/// ```
class Countdown extends UiComponent {
  /// Creates a Countdown component.
  ///
  /// - [value]: The integer value to display (0-99).
  /// - [style]: A list of [CountdownStyling] instances, typically used for
  ///   general utilities like `FontUtil` or `TextUtil` to style the text.
  /// - [tag]: The HTML tag for the root element, defaults to 'span'.
  /// - Other parameters are inherited from [UiComponent].
  const Countdown({
    required this.value,
    List<CountdownStyling>? style,
    super.tag = 'span',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style);

  /// The numerical value to display. Must be between 0 and 99.
  final int value;

  @override
  String get baseClass => 'countdown';


  @override
  Countdown copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    int? value,
  }) {
    return Countdown(
      value: value ?? this.value,
      style: style as List<CountdownStyling>?,
      tag: tag,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    // Clamp the value to be within DaisyUI's supported range (0-99).
    final clampedValue = value.clamp(0, 99);

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      children: [
        span(
          [Component.text(clampedValue.toString())],
          // The CSS variable `--value` is what drives the animation.
          styles: Styles(raw: {'--value': clampedValue.toString()}),
          // Accessibility attributes for screen readers.
          attributes: {
            'aria-live': 'polite',
            'aria-label': clampedValue.toString(),
          },
        ),
      ],
    );
  }
}
