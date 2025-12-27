import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart';

import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'diff_style.dart';

/// A component for visually comparing two pieces of content ("before" and "after")
/// side-by-side.
///
/// This component is a "smart container" that expects exactly one [DiffItem1]
/// and one [DiffItem2] as its direct children. It renders a complete visual
/// structure that is interactive out of the box using pure CSS.
///
/// ### Interaction Model:
/// - **On Desktop:** A draggable vertical resizer allows for smooth comparison.
/// - **On Mobile (iOS/Touch):** Since CSS `resize` is not supported, users can
///   **tap** on either the left or right side to expand it, providing a robust
///   touch-friendly fallback.
///
/// This implementation is a stateless, declarative component that relies entirely
/// on CSS for its interactivity, ensuring maximum performance and cross-browser
/// compatibility without any client-side JavaScript.
///
/// ### Correct Usage:
/// ```dart
/// Diff(
///   [
///     DiffItem1([
///       // Your "before" content, e.g., an image or text block.
///       img(src: 'before.jpg', alt: 'Before'),
///     ]),
///     DiffItem2([
///       // Your "after" content.
///       img(src: 'after.jpg', alt: 'After'),
///     ]),
///   ],
///   ariaLabel: 'Before and after comparison of the new logo',
/// )
/// ```
class Diff extends UiComponent {
  /// Creates an interactive Diff component.
  ///
  /// - [children]: A list that **must** contain one [DiffItem1] and one [DiffItem2].
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [DiffStyling] instances to apply to the main container.
  /// - [ariaLabel]: An accessible name for the comparison group. Recommended for accessibility.
  /// - Other parameters like `id`, `classes`, and `css` are applied to the root element.
  const Diff(
    super.children, {
    super.tag = 'div',
    List<DiffStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    this.ariaLabel,
    super.key,
  }) : super(style: style);

  /// An accessible name for the comparison region, highly recommended for screen readers.
  final String? ariaLabel;

  @override
  String get baseClass => 'diff';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // Use the 'group' role to semantically group the related items for accessibility.
    attributes.addRole(userProvidedAttributes['role'] ?? 'group');
    if (ariaLabel != null) {
      attributes.addAria('label', ariaLabel!);
    }
  }

  @override
  Diff copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Diff(
      children,
      tag: tag,
      style: style as List<DiffStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      ariaLabel: ariaLabel,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    final item1 = children?.whereType<DiffItem1>().firstOrNull;
    final item2 = children?.whereType<DiffItem2>().firstOrNull;

    assert(
      item1 != null && item2 != null,
      'A Diff component must have exactly one DiffItem1 and one DiffItem2 as direct children.',
    );

    // The component now renders a simple, declarative structure. The interactivity
    // is handled entirely by DaisyUI's CSS.
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      children: [
        item1!,
        item2!,
        const DiffResizer(),
      ],
    );
  }
}

/// Represents the first item (typically "before" or "left") in a [Diff] comparison.
///
/// This component is designed to be a direct child of [Diff]. It automatically
/// includes `tabindex="0"` to make it focusable, which enables the tap-to-expand
/// interaction on touch devices like iOS.
class DiffItem1 extends UiComponent {
  /// Creates a DiffItem1 component.
  ///
  /// - [children]: The content of this diff item (e.g., an `img` or `Container`).
  const DiffItem1(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super();

  @override
  String get baseClass => 'diff-item-1';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // Add tabindex="0" to make this div focusable. This is the key to enabling
    // the tap-to-expand interaction on iOS and other touch devices.
    if (!userProvidedAttributes.containsKey('tabindex')) {
      attributes.add('tabindex', '0');
    }
  }

  @override
  DiffItem1 copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return DiffItem1(
      children,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }
}

/// Represents the second item (typically "after" or "right") in a [Diff] comparison.
///
/// This component is designed to be a direct child of [Diff]. It automatically
/// includes `tabindex="0"` to make it focusable, which enables the tap-to-expand
/// interaction on touch devices like iOS.
class DiffItem2 extends UiComponent {
  /// Creates a DiffItem2 component.
  ///
  /// - [children]: The content of this diff item (e.g., an `img` or `Container`).
  const DiffItem2(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super();

  @override
  String get baseClass => 'diff-item-2';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // Add tabindex="0" to make this div focusable. This is the key to enabling
    // the tap-to-expand interaction on iOS and other touch devices.
    if (!userProvidedAttributes.containsKey('tabindex')) {
      attributes.add('tabindex', '0');
    }
  }

  @override
  DiffItem2 copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return DiffItem2(
      children,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }
}

/// Represents the draggable resizer handle within a [Diff] component.
///
/// This is a purely visual element controlled by CSS `resize` on desktop browsers.
/// It has no interactive logic of its own.
class DiffResizer extends UiComponent {
  /// Creates a DiffResizer component. This component typically does not have children.
  const DiffResizer({
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null);

  @override
  String get baseClass => 'diff-resizer';

  @override
  DiffResizer copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return DiffResizer(
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}
