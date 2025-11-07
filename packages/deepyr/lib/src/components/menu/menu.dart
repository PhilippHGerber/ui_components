import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/styling_extensions.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'menu_style.dart';

/// A container for a list of navigation links, which can be arranged vertically or horizontally.
///
/// The `Menu` component renders a `<ul>` element and is the main container for
/// [MenuItem], [MenuTitle], and submenu components like [MenuSubmenu]. It applies the necessary
/// base class and ARIA roles for accessibility.
@immutable
class Menu extends UiComponent {
  /// Creates a Menu component.
  ///
  /// - [children]: The content of the menu, which should be a list of
  ///   [MenuItem], [MenuTitle], or submenu components.
  /// - [tag]: The HTML tag for the root element, defaults to 'ul'.
  /// - [style]: A list of [MenuStyling] instances to control size and direction.
  /// - [ariaLabel]: An accessible name for the menu, crucial for screen readers.
  /// - Other parameters are inherited from [UiComponent].
  const Menu(
    super.children, {
    super.tag = 'ul',
    List<MenuStyling>? style,
    this.ariaLabel,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  /// An accessible name for the menu container. This is highly recommended for
  /// accessibility, as it describes the purpose of the navigation block to
  /// users of assistive technologies (e.g., "Main navigation", "User settings").
  final String? ariaLabel;

  @override
  String get baseClass => 'menu';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    final isHorizontal =
        style?.any((m) => m is MenuStyle && m.cssClass == Menu.horizontal.cssClass) ?? false;
    if (isHorizontal) {
      attributes
        ..addRole('menubar')
        ..addAria('orientation', 'horizontal');
    } else {
      attributes
        ..addRole('menu')
        ..addAria('orientation', 'vertical');
    }
    if (ariaLabel != null && ariaLabel!.isNotEmpty) {
      attributes.addAria('label', ariaLabel!);
    }
  }

  @override
  Menu copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Menu(
      children,
      tag: tag,
      style: style as List<MenuStyling>?,
      ariaLabel: ariaLabel,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }

  /// Extra small menu size. `menu-xs`
  static const MenuStyle xs = MenuStyle('menu-xs', type: StyleType.sizing);

  /// Small menu size. `menu-sm`
  static const MenuStyle sm = MenuStyle('menu-sm', type: StyleType.sizing);

  /// Medium menu size (default). `menu-md`
  static const MenuStyle md = MenuStyle('menu-md', type: StyleType.sizing);

  /// Large menu size. `menu-lg`
  static const MenuStyle lg = MenuStyle('menu-lg', type: StyleType.sizing);

  /// Extra large menu size. `menu-xl`
  static const MenuStyle xl = MenuStyle('menu-xl', type: StyleType.sizing);

  /// Vertical menu layout (default). `menu-vertical`
  static const MenuStyle vertical = MenuStyle('menu-vertical', type: StyleType.layout);

  /// Horizontal menu layout. `menu-horizontal`
  static const MenuStyle horizontal = MenuStyle('menu-horizontal', type: StyleType.layout);
}

/// A non-interactive title or heading within a [Menu].
///
/// Renders a styled `<li>` element to act as a separator or category header.
@immutable
class MenuTitle extends UiComponent {
  /// Creates a MenuTitle component.
  ///
  /// - [children]: The text content of the title.
  const MenuTitle(
    super.children, {
    super.tag = 'li',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  });

  @override
  String get baseClass => 'menu-title';

  @override
  MenuTitle copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return MenuTitle(
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

/// An interactive item within a [Menu].
///
/// This component abstracts the common `<li><a>...</a></li>` structure. It renders
/// an `<a>` tag by default, which is styled correctly by the parent `Menu`, and
/// automatically wraps it in an `<li>`. Use `onClick` for button-like behavior.
@immutable
class MenuItem extends UiComponent {
  /// Creates an interactive menu item.
  ///
  /// - [children]: The content of the item, like text and icons.
  /// - [href]: If provided, the item will be a standard anchor link.
  /// - [isActive]: If true, applies active styling to the item.
  /// - [isDisabled]: If true, applies disabled styling and semantics.
  /// - [onClick]: Callback for when the item is clicked.
  const MenuItem(
    super.children, {
    this.href,
    this.isActive = false,
    this.isDisabled = false,
    super.onClick,
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(tag: 'a');

  /// The URL the item links to. Renders an `href` attribute.
  final String? href;

  /// Whether the item should be styled as active.
  final bool isActive;

  /// Whether the item should be styled as disabled and non-interactive.
  final bool isDisabled;

  @override
  String get baseClass => ''; // The `<a>` tag has no base class.

  @override
  String get combinedClasses {
    final effectiveClasses = <String>[];
    if (isActive) effectiveClasses.add('menu-active');
    if (classes != null) effectiveClasses.add(classes!);
    return effectiveClasses.join(' ');
  }

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    if (href != null) attributes.add('href', href!);
    attributes.addRole('menuitem');
  }

  @override
  Component build(BuildContext context) {
    return li(
      classes: isDisabled ? 'menu-disabled' : null,
      attributes: {'role': 'presentation'},
      [super.build(context)],
    );
  }

  @override
  MenuItem copyWith({
    String? href,
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return MenuItem(
      children,
      href: href,
      isActive: isActive,
      isDisabled: isDisabled,
      onClick: onClick,
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

/// A collapsible submenu using `<details>` and `<summary>`.
///
/// This component abstracts the `<li><details>...</details></li>` structure for
/// creating native, accessible submenus.
@immutable
class MenuSubmenu extends UiComponent {
  /// Creates a collapsible submenu.
  ///
  /// - [label]: The visible part of the submenu that acts as the trigger.
  /// - [children]: A list of `MenuItem`s to show when the submenu is open.
  /// - [initiallyOpen]: Whether the submenu is open by default.
  /// - [ulStyle]: A list of Deepyr styling utilities to apply to the inner `<ul>` element.
  ///   This is used to control background, padding, width, etc., of the dropdown panel.
  const MenuSubmenu({
    required List<Component> children,
    required this.label,
    this.initiallyOpen = false,
    this.ulStyle,
    super.id,
    super.classes,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(children, tag: 'details');

  /// The content of the `<summary>` element that users click to toggle the submenu.
  final Component label;

  /// If true, the submenu will be open when first rendered.
  final bool initiallyOpen;

  /// Styling for the inner `<ul>` element of the submenu.
  final List<Styling>? ulStyle;

  @override
  String get baseClass => '';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    if (initiallyOpen) attributes.add('open', '');
  }

  @override
  Component build(BuildContext context) {
    return li(
      attributes: {'role': 'presentation'},
      [
        Component.element(
          tag: tag, // Renders <details>
          id: id,
          classes: combinedClasses,
          attributes: componentAttributes,
          children: [
            summary([label]),
            ul(
              children ?? [?child],
              // Apply the ulStyle classes to the <ul> element.
              classes: ulStyle?.toClasses(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  MenuSubmenu copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    // This copyWith implementation might need ulStyle if it were to be modified by a parent.
    // For now, it preserves the original instance's properties.
    return MenuSubmenu(
      children: children ?? [],
      label: label,
      initiallyOpen: initiallyOpen,
      ulStyle: ulStyle,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}

/// A hoverable submenu that expands on mouseover, used in horizontal menus.
@immutable
class MenuHoverSubmenu extends UiComponent {
  /// Creates a hoverable submenu.
  ///
  /// - [label]: The visible part of the submenu trigger.
  /// - [children]: A list of `MenuItem`s to show on hover.
  /// - [ulStyle]: A list of Deepyr styling utilities to apply to the inner `<ul>` element.
  const MenuHoverSubmenu({
    required List<Component> children,
    required this.label,
    this.ulStyle,
    super.id,
    super.classes,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(children, tag: 'li');

  final Component label;

  /// Styling for the inner `<ul>` element of the submenu.
  final List<Styling>? ulStyle;

  @override
  String get baseClass => '';

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: tag, // Renders the `<li>`
      id: id,
      classes: combinedClasses,
      attributes: componentAttributes,
      children: [
        a([label], href: '#'), // The trigger is now a proper anchor
        ul(
          children ?? [?child],
          // Apply the ulStyle classes to the <ul> element.
          classes: ulStyle?.toClasses(),
        ),
      ],
    );
  }

  @override
  MenuHoverSubmenu copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return MenuHoverSubmenu(
      children: children ?? [],
      label: label,
      ulStyle: ulStyle,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}

/// The trigger element for a JavaScript-controlled collapsible submenu.
@immutable
class MenuDropdownToggle extends UiComponent {
  /// Creates a toggle for a JS-controlled dropdown menu.
  const MenuDropdownToggle(
    super.children, {
    super.tag = 'span',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
    super.onClick,
  }) : super();

  @override
  String get baseClass => 'menu-dropdown-toggle';

  @override
  MenuDropdownToggle copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return MenuDropdownToggle(
      children,
      tag: tag,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      onClick: onClick,
      key: key ?? this.key,
    );
  }
}

/// The content element for a JavaScript-controlled collapsible submenu.
@immutable
class MenuDropdownContent extends UiComponent {
  /// Creates the content container for a JS-controlled dropdown menu.
  const MenuDropdownContent(
    super.children, {
    super.tag = 'ul',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super();

  @override
  String get baseClass => 'menu-dropdown';

  @override
  MenuDropdownContent copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return MenuDropdownContent(
      children,
      tag: tag,
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
