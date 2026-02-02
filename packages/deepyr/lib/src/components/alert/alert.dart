import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart' show Key;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'alert_style.dart';

/// A component to inform users about important events, rendering a `<div>` with `role="alert"`.
///
/// The `Alert` component is a flexible container. Its children can be any combination
/// of `Icon`, `span`, `div`, or `Button` components to create the desired layout.
///
/// Example Usage:
/// ```dart
/// Alert(
///   style: [Alert.success, Alert.soft],
///   [
///     Icon('check_circle'), // Assumes deepyr Icon component
///     span([text('Your purchase has been confirmed!')]),
///     div([
///       Button([text('View Receipt')], style: [Button.sm]),
///     ])
///   ],
/// )
/// ```
class Alert extends UiComponent {
  /// Creates an Alert component.
  ///
  /// - [children]: The content of the alert, typically including an icon,
  ///   text, and optional action buttons.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [AlertStyling] instances to control the color,
  ///   style, and layout.
  /// - Other parameters are inherited from [UiComponent].
  const Alert(
    super.children, {
    super.tag = 'div',
    List<AlertStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'alert';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // The 'alert' role is crucial for accessibility, making screen readers
    // announce the message dynamically.
    if (!userProvidedAttributes.containsKey('role')) {
      attributes.addRole('alert');
    }
  }

  @override
  Alert copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Alert(
      children,
      tag: tag,
      style: style as List<AlertStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  // Styles
  /// Outline style. `alert-outline`
  static const AlertStyle outline = AlertStyle('alert-outline', type: StyleType.border);

  /// Dash outline style. `alert-dash`
  static const AlertStyle dash = AlertStyle('alert-dash', type: StyleType.border);

  /// Soft style with a light background color. `alert-soft`
  static const AlertStyle soft = AlertStyle('alert-soft', type: StyleType.style);

  // Colors
  /// Info color, for neutral informative messages. `alert-info`
  static const AlertStyle info = AlertStyle('alert-info', type: StyleType.style);

  /// Success color, for positive confirmation messages. `alert-success`
  static const AlertStyle success = AlertStyle('alert-success', type: StyleType.style);

  /// Warning color, for potentially harmful actions. `alert-warning`
  static const AlertStyle warning = AlertStyle('alert-warning', type: StyleType.style);

  /// Error color, for failed actions or errors. `alert-error`
  static const AlertStyle error = AlertStyle('alert-error', type: StyleType.style);

  // Direction
  /// Vertical layout, stacking items top-to-bottom. Good for mobile. `alert-vertical`
  static const AlertStyle vertical = AlertStyle('alert-vertical', type: StyleType.layout);

  /// Horizontal layout, placing items side-by-side. Good for desktop. `alert-horizontal`
  static const AlertStyle horizontal = AlertStyle('alert-horizontal', type: StyleType.layout);
}
