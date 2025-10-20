import 'package:jaspr/jaspr.dart';

import '../../base/common_style.dart';
import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'join_style.dart';

/// A "smart" container for grouping multiple items like buttons or inputs.
///
/// The `Join` component automatically applies the necessary `join-item` class
/// to its direct `UiComponent` children. This creates a seamless, connected group
/// by applying the correct border radius to the first and last items.
///
/// Place your `deepyr` components like
/// `Button`, `Input`, or `Select` directly inside the `Join` component.
///
/// Example:
/// ```dart
/// Join([
///   Button([text('Button 1')]), // Automatically becomes a join-item
///   Button([text('Button 2')]), // Automatically becomes a join-item
/// ])
/// ```
class Join extends UiComponent {
  /// Creates a "smart" Join container component.
  ///
  /// - [children] or [child]: A list of components to be joined. The `Join`
  ///   component will automatically apply the `join-item` class to any direct
  ///   child that is a `deepyr` `UiComponent`.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [JoinStyling] instances to control direction
  ///   (e.g., `Join.vertical`).
  /// - Other parameters are inherited from [UiComponent].
  const Join(
    super.children, {
    super.tag = 'div',
    List<JoinStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'join';

  @override
  Join copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Join(
      children,
      tag: tag,
      style: style as List<JoinStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
      child: child,
    );
  }

  // --- Static Join Style Modifiers ---

  /// Arranges the items vertically. `join-vertical`
  static const JoinStyle vertical = JoinStyle(
    'join-vertical',
    type: StyleType.layout,
  );

  /// Arranges the items horizontally (default behavior). `join-horizontal`
  static const JoinStyle horizontal = JoinStyle(
    'join-horizontal',
    type: StyleType.layout,
  );

  static const item = MultiUsedStyle('join-item', type: StyleType.layout);
}
