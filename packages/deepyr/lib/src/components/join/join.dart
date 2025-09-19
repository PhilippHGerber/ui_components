import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
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
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'join';

  /// Overridden build method to intelligently apply the `join-item` class
  /// to all direct `UiComponent` children.
  @override
  Component build(BuildContext context) {
    Component? finalChild;
    List<Component>? finalChildren;

    // Process a list of children if provided.
    if (children != null) {
      finalChildren = children!.map((c) {
        if (c is UiComponent) {
          // Clone the child, merging the 'join-item' class.
          return c.copyWith(classes: 'join-item');
        }
        // Return non-UiComponent children (like text()) unmodified.
        return c;
      }).toList();
    }
    // Process a single child if provided.
    else if (child != null) {
      if (child is UiComponent) {
        finalChild = (child! as UiComponent).copyWith(classes: 'join-item');
      } else {
        finalChild = child;
      }
    }

    // return the final DomComponent with the transformed children.
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: finalChildren ?? [?finalChild],
    );
  }

  @override
  Join copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    // Note: The copyWith method creates a new Join component.
    // The new component's build method will then apply the join-item logic
    // to its children. We don't need to transform children here.
    return Join(
      children,
      tag: tag,
      style: style as List<JoinStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
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
}
