import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import 'status_style.dart';

/// A small visual icon to show the current status of an element, like online,
/// offline, or an error state.
///
/// It renders as an empty `<span>` element with the necessary CSS classes.
/// Its color and size are controlled by applying the appropriate style modifiers.
///
/// Example Usage:
/// ```dart
/// Status(
///   style: [Status.success, Status.lg],
///   ariaLabel: 'Online',
/// )
/// ```
class Status extends UiComponent {
  /// Creates a Status component.
  ///
  /// - [style]: A list of [StatusStyling] instances to control the color and size.
  /// - [ariaLabel]: An accessible name for the status indicator. Defaults to "status".
  ///   It is highly recommended to provide a more descriptive label (e.g., "Online", "Error").
  /// - [tag]: The HTML tag for the root element, defaults to 'span'.
  /// - Other parameters are inherited from [UiComponent].
  const Status({
    List<StatusStyling>? style,
    this.ariaLabel,
    super.tag = 'span',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(null, style: style); // Status elements have no children.

  /// An accessible label for the status indicator, announced by screen readers.
  final String? ariaLabel;

  @override
  String get baseClass => 'status';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // Provide a default accessible name, which can be overridden by the user for more context.
    attributes.add('aria-label', ariaLabel ?? 'status');
  }

  @override
  Status copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Status(
      style: style as List<StatusStyling>?,
      ariaLabel: ariaLabel,
      tag: tag,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  // Colors
  /// Neutral color. `status-neutral`
  static const StatusStyle neutral = StatusStyle('status-neutral', type: StyleType.style);

  /// Primary color. `status-primary`
  static const StatusStyle primary = StatusStyle('status-primary', type: StyleType.style);

  /// Secondary color. `status-secondary`
  static const StatusStyle secondary = StatusStyle('status-secondary', type: StyleType.style);

  /// Accent color. `status-accent`
  static const StatusStyle accent = StatusStyle('status-accent', type: StyleType.style);

  /// Info color. `status-info`
  static const StatusStyle info = StatusStyle('status-info', type: StyleType.style);

  /// Success color. `status-success`
  static const StatusStyle success = StatusStyle('status-success', type: StyleType.style);

  /// Warning color. `status-warning`
  static const StatusStyle warning = StatusStyle('status-warning', type: StyleType.style);

  /// Error color. `status-error`
  static const StatusStyle error = StatusStyle('status-error', type: StyleType.style);

  // Sizes
  /// Extra-small size. `status-xs`
  static const StatusStyle xs = StatusStyle('status-xs', type: StyleType.sizing);

  /// Small size. `status-sm`
  static const StatusStyle sm = StatusStyle('status-sm', type: StyleType.sizing);

  /// Medium size (default). `status-md`
  static const StatusStyle md = StatusStyle('status-md', type: StyleType.sizing);

  /// Large size. `status-lg`
  static const StatusStyle lg = StatusStyle('status-lg', type: StyleType.sizing);

  /// Extra-large size. `status-xl`
  static const StatusStyle xl = StatusStyle('status-xl', type: StyleType.sizing);
}
