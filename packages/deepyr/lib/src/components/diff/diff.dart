import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../base/styling.dart' show Styling;
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import 'diff_style.dart';

/// A component for visually comparing two pieces of content ("before" and "after")
/// side-by-side, typically using a draggable resizer.
///
/// The `modifiers` list accepts instances of [DiffStyling] (the interface),
/// which includes specific diff styles like [Diff.roundedField]
/// and general utility classes (e.g., `Sizing.aspectRatio`).
class Diff extends UiComponent {
  /// Creates a Diff component.
  ///
  /// - [item1]: The [DiffItem1] component representing the "before" state.
  /// - [item2]: The [DiffItem2] component representing the "after" state.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'. Can be set to 'figure'.
  /// - [focusable]: If true, sets `tabindex="0"` on the main diff container, making it focusable.
  /// - [style]: A list of [DiffStyling] (the interface) instances.
  /// - Other parameters are inherited from [UiComponent].
  Diff({
    required this.item1,
    required this.item2,
    super.tag = 'div',
    this.focusable = false,
    List<DiffStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super([item1, item2, const DiffResizer()], style: style);

  /// The "before" item in the comparison.
  final DiffItem1 item1;

  /// The "after" item in the comparison.
  final DiffItem2 item2;

  /// If true, makes the main diff container focusable using `tabindex="0"`.
  final bool focusable;

  @override
  String get baseClass => 'diff';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    if (focusable) {
      attributes.add('tabindex', '0');
    }
    // ARIA attributes for the diff component itself might relate to it being a composite widget,
    // but this depends heavily on JavaScript-driven interactivity for the resizer.
    // For a CSS-only version, `role="group"` with a label might be suitable.
    // attributes.addRole('group');
    // attributes.addAria('label', 'Image comparison tool'); // User should provide this if needed
  }

  @override
  Diff copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Diff(
      item1: item1,
      item2: item2,
      tag: tag,
      focusable: focusable,
      style: style as List<DiffStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }
}

/// Represents the first item (typically "before" or "old") in a [Diff] comparison.
/// It renders as an HTML `<div>` with the 'diff-item-1' class.
class DiffItem1 extends UiComponent {
  /// Creates a DiffItem1 component.
  ///
  /// - [children] or [child]: The content of this diff item.
  /// - [tag]: The HTML tag, defaults to 'div'.
  /// - [role]: Optional ARIA role for the item (e.g., "img" if it contains an image).
  /// - [focusable]: If true, sets `tabindex="0"` on this item, making it focusable.
  /// - [modifiers]: General [Styling] instances for styling.
  /// - Other parameters from [UiComponent].
  const DiffItem1(
    super.children, {
    super.tag = 'div',
    this.role,
    this.focusable = false,
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  });

  final String? role;
  final bool focusable;

  @override
  String get baseClass => 'diff-item-1';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    if (role != null) {
      attributes.addRole(role!);
    }
    if (focusable) {
      attributes.add('tabindex', '0');
    }
  }

  @override
  DiffItem1 copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return DiffItem1(
      children,
      tag: tag,
      role: role,
      focusable: focusable,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }
}

/// Represents the second item (typically "after" or "new") in a [Diff] comparison.
/// It renders as an HTML `<div>` with the 'diff-item-2' class.
class DiffItem2 extends UiComponent {
  /// Creates a DiffItem2 component.
  ///
  /// - [children] or [child]: The content of this diff item.
  /// - [tag]: The HTML tag, defaults to 'div'.
  /// - [role]: Optional ARIA role for the item (e.g., "img" if it contains an image).
  /// - [modifiers]: General [Styling] instances for styling.
  /// - Other parameters from [UiComponent].
  const DiffItem2(
    super.children, {
    super.tag = 'div',
    this.role,
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  });

  final String? role;

  @override
  String get baseClass => 'diff-item-2';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    if (role != null) {
      attributes.addRole(role!);
    }
  }

  @override
  DiffItem2 copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return DiffItem2(
      children,
      tag: tag,
      role: role,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }
}

/// Represents the draggable resizer control within a [Diff] component.
/// It renders as an HTML `<div>` with the 'diff-resizer' class.
class DiffResizer extends UiComponent {
  /// Creates a DiffResizer component.
  /// This component typically does not have children.
  const DiffResizer({
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(null);

  @override
  String get baseClass => 'diff-resizer';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // For accessibility, if the resizer is made keyboard operable (usually via JS):
    // attributes.addRole('slider'); // Or 'separator' with more ARIA
    // attributes.addAria('orientation', 'vertical'); // Or 'horizontal'
    // attributes.addAria('valuenow', '50'); // Example, would need state
    // attributes.addAria('valuemin', '0');
    // attributes.addAria('valuemax', '100');
    // attributes.add('tabindex', '0'); // Make it focusable
  }

  @override
  DiffResizer copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return DiffResizer(
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }
}
