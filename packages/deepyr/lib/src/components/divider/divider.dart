import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'divider_style.dart';

/// A component used to separate content vertically or horizontally.
///
/// It renders as an HTML `<div>` with `role="separator"`. The divider can
/// either be a simple line (by passing an empty list of children) or contain
/// text in the middle.
///
/// Example Usage:
/// ```dart
/// div(classes: 'flex flex-col w-full', [
///   div(classes: 'card', [text('Content A')]),
///   Divider([text('OR')], style: [Divider.primary]),
///   div(classes: 'card', [text('Content B')]),
/// ])
/// ```
class Divider extends UiComponent {
  /// Creates a Divider component.
  ///
  /// - [children]: The content to display within the divider (e.g., `[text('OR')]`).
  ///   If an empty list or null is provided, a simple line without text is rendered.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [DividerStyling] instances to control the color,
  ///   direction, and text placement.
  /// - Other parameters are inherited from [UiComponent].
  const Divider(
    super.children, {
    super.tag = 'div',
    List<DividerStyling>? super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  });

  @override
  String get baseClass => 'divider';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // A divider is a separator, which is an important semantic role for accessibility.
    if (!userProvidedAttributes.containsKey('role')) {
      attributes.addRole('separator');
    }
  }

  @override
  Divider copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Divider(
      children,
      tag: tag,
      style: style as List<DividerStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  // Colors
  /// Neutral color. `divider-neutral`
  static const DividerStyle neutral = DividerStyle('divider-neutral', type: StyleType.style);

  /// Primary color. `divider-primary`
  static const DividerStyle primary = DividerStyle('divider-primary', type: StyleType.style);

  /// Secondary color. `divider-secondary`
  static const DividerStyle secondary = DividerStyle('divider-secondary', type: StyleType.style);

  /// Accent color. `divider-accent`
  static const DividerStyle accent = DividerStyle('divider-accent', type: StyleType.style);

  /// Success color. `divider-success`
  static const DividerStyle success = DividerStyle('divider-success', type: StyleType.style);

  /// Warning color. `divider-warning`
  static const DividerStyle warning = DividerStyle('divider-warning', type: StyleType.style);

  /// Info color. `divider-info`
  static const DividerStyle info = DividerStyle('divider-info', type: StyleType.style);

  /// Error color. `divider-error`
  static const DividerStyle error = DividerStyle('divider-error', type: StyleType.style);

  // Direction
  /// Renders the divider horizontally, to separate side-by-side content.
  /// The default is vertical. `divider-horizontal`
  static const DividerStyle horizontal = DividerStyle('divider-horizontal', type: StyleType.layout);

  // Placement
  /// Pushes the divider text to the start (left for horizontal, top for vertical). `divider-start`
  static const DividerStyle start = DividerStyle('divider-start', type: StyleType.layout);

  /// Pushes the divider text to the end (right for horizontal, bottom for vertical). `divider-end`
  static const DividerStyle end = DividerStyle('divider-end', type: StyleType.layout);
}
