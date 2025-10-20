import 'package:jaspr/jaspr.dart';

import '../../../deepyr.dart' show Icon;
import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../icon/icon.dart' show Icon;
import 'dock_style.dart';

/// A container for a bottom navigation bar that sticks to the bottom of the screen.
///
/// The `Dock` component renders a `<div>` and should contain a list of [DockItem]
/// components. It is responsible for the overall layout and sizing of the navigation bar.
///
/// **Important for iOS:** For the dock to display correctly without being obscured
/// by home indicators on iOS, you must include the following meta tag in your main HTML document:
/// `<meta name="viewport" content="viewport-fit=cover">`
class Dock extends UiComponent {
  /// Creates a Dock container component.
  ///
  /// - [children]: The content of the dock, which should be a list of [DockItem] components.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [DockStyling] instances to control the size, background,
  ///   and other visual properties.
  /// - [ariaLabel]: An accessible name for the navigation bar (e.g., "Main navigation").
  ///   **It's highly recommended to provide a specific and descriptive label for accessibility.**
  /// - Other parameters are inherited from [UiComponent].
  const Dock(
    super.children, {
    super.tag = 'div',
    List<DockStyling>? style,
    this.ariaLabel,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(style: style);

  /// An accessible name for the navigation region. Crucial for screen readers.
  final String? ariaLabel;

  @override
  String get baseClass => 'dock';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // Use the 'navigation' landmark role for accessibility.
    attributes.addRole('navigation');
    if (ariaLabel != null && ariaLabel!.isNotEmpty) {
      attributes.addAria('label', ariaLabel!);
    }
  }

  @override
  Dock copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Dock(
      children,
      tag: tag,
      style: style as List<DockStyling>?,
      ariaLabel: ariaLabel,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Extra small size. Hides labels by default. `dock-xs`
  static const DockStyle xs = DockStyle('dock-xs', type: StyleType.sizing);

  /// Small size. Hides labels by default. `dock-sm`
  static const DockStyle sm = DockStyle('dock-sm', type: StyleType.sizing);

  /// Medium size (default). `dock-md`
  static const DockStyle md = DockStyle('dock-md', type: StyleType.sizing);

  /// Large size. `dock-lg`
  static const DockStyle lg = DockStyle('dock-lg', type: StyleType.sizing);

  /// Extra large size. `dock-xl`
  static const DockStyle xl = DockStyle('dock-xl', type: StyleType.sizing);
}

/// A single interactive item within a [Dock], typically a button.
///
/// This component follows a compositional API, accepting an [Icon] and an optional
/// [DockLabel] as children. Its active state is controlled by the `isActive` property.
class DockItem extends UiComponent {
  /// Creates a single item for a [Dock].
  ///
  /// - [children]: The content of the item, typically an [Icon] and a [DockLabel].
  /// - [isActive]: If true, applies the active state styling (`dock-active`).
  /// - [tag]: The HTML tag for the root element, defaults to 'button'.
  /// - [onClick]: Callback for when the item is clicked.
  /// - [style]: A list of [DockItemStyling] instances for applying general utilities.
  /// - Other parameters are inherited from [UiComponent].
  const DockItem(
    super.children, {
    this.isActive = false,
    super.tag = 'button',
    super.onClick,
    List<DockItemStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(style: style);

  /// If true, the item is styled as the currently active item.
  final bool isActive;

  @override
  String get baseClass => ''; // No base class for the item itself.

  @override
  String get combinedClasses {
    var combined = super.combinedClasses;
    if (isActive) {
      combined = 'dock-active $combined';
    }
    return combined.trim();
  }

  @override
  DockItem copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return DockItem(
      children,
      isActive: isActive,
      tag: tag,
      onClick: onClick,
      style: style as List<DockItemStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }
}

/// The text label for a [DockItem].
///
/// This component renders a `<span>` with the `dock-label` class and is
/// typically placed inside a `DockItem` after an `Icon`.
class DockLabel extends UiComponent {
  /// Creates a text label for a [DockItem].
  ///
  /// - [children]: The text to be displayed.
  /// - [tag]: The HTML tag for the root element, defaults to 'span'.
  /// - [style]: A list of [DockLabelStyling] for applying general utilities.
  /// - Other parameters are inherited from [UiComponent].
  const DockLabel(
    super.children, {
    super.tag = 'span',
    List<DockLabelStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'dock-label';

  @override
  DockLabel copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return DockLabel(
      children,
      tag: tag,
      style: style as List<DockLabelStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }
}
