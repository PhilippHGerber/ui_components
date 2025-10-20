import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'toast_style.dart';

/// A container for stacking notification elements, positioned on a corner of the page.
///
/// The `Toast` component is a structural layout utility. It renders a `<div>` that
/// is fixed to a position on the screen (e.g., top-end, bottom-center) and
/// vertically stacks its children.
///
/// Its children are typically `Alert` components, which represent the individual
/// toast messages.
///
/// **Important:** This component only provides the container. The dynamic logic for
/// adding and removing toasts after a delay must be handled by a client-side
/// state management solution or a dedicated service.
///
/// Example Usage (Static):
/// ```dart
/// Toast(
///   style: [Toast.top, Toast.end],
///   [
///     Alert([text('New message arrived.')], style: [Alert.info]),
///     Alert([text('Message sent successfully.')], style: [Alert.success]),
///   ],
/// )
/// ```
class Toast extends UiComponent {
  /// Creates a Toast container component.
  ///
  /// - [children]: The content of the component, which should be a list of
  ///   `Alert` components or other elements to be stacked.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [ToastStyling] instances to control the position on the screen.
  /// - Other parameters are inherited from [UiComponent].
  const Toast(
    super.children, {
    super.tag = 'div',
    List<ToastStyling>? super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  });

  @override
  String get baseClass => 'toast';

  @override
  Toast copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Toast(
      children,
      tag: tag,
      style: style as List<ToastStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Aligns the toast container horizontally to the start (left in LTR). `toast-start`
  static const ToastStyle start = ToastStyle('toast-start', type: StyleType.layout);

  /// Aligns the toast container horizontally to the center. `toast-center`
  static const ToastStyle center = ToastStyle('toast-center', type: StyleType.layout);

  /// Aligns the toast container horizontally to the end (right in LTR). `toast-end`
  static const ToastStyle end = ToastStyle('toast-end', type: StyleType.layout);

  /// Aligns the toast container vertically to the top. `toast-top`
  static const ToastStyle top = ToastStyle('toast-top', type: StyleType.layout);

  /// Aligns the toast container vertically to the middle. `toast-middle`
  static const ToastStyle middle = ToastStyle('toast-middle', type: StyleType.layout);

  /// Aligns the toast container vertically to the bottom. `toast-bottom`
  static const ToastStyle bottom = ToastStyle('toast-bottom', type: StyleType.layout);
}
