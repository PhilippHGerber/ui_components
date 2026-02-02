import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart' show Key;

import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'navbar_style.dart';

/// A navigation bar component, typically placed at the top of a page or section.
/// It provides a container for branding, navigation links, and actions.
///
/// Its direct children are usually [NavbarStart], [NavbarCenter], and [NavbarEnd]
/// to structure its content.
class Navbar extends UiComponent {
  /// Creates a Navbar component.
  ///
  /// - [children]: Typically a combination of [NavbarStart], [NavbarCenter],
  ///   and [NavbarEnd] components to structure the navbar content.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [NavbarStyle] (the interface) instances.
  ///   These are usually general utilities like `BgUtil.primary`, `Effects.shadowLg`.
  /// - [ariaLabel]: An accessible name for the navigation bar (e.g., "Main navigation").
  ///   **It's highly recommended to provide a specific and descriptive label.**
  /// - Other parameters are inherited from [UiComponent].
  const Navbar(
    super.children, {
    super.tag = 'div',
    List<NavbarStyling>? super.style,
    this.ariaLabel, // Default removed, encourage user to set it.
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  });

  /// An accessible name for the navigation bar. Important for assistive technologies.
  /// Example: "Main navigation", "Secondary navigation", "Site navigation".
  final String? ariaLabel;

  @override
  String get baseClass => 'navbar';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    attributes.addRole('navigation');
    if (ariaLabel != null && ariaLabel!.isNotEmpty) {
      attributes.addAria('label', ariaLabel!);
    } else {
      // Consider logging a warning if no ariaLabel is provided in dev mode.
      // print("Warning: Navbar created without an 'ariaLabel'. This is important for accessibility.");
    }
  }

  @override
  Navbar copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Navbar(
      children,
      tag: tag,
      style: style as List<NavbarStyling>?,
      ariaLabel: ariaLabel,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  // No static NavbarStyleModifiers are defined from navbar.txt as 'navbar' itself is the main class.
  // Other styles (colors, shadow) come from general utilities.
}

/// Represents the starting section (typically left-aligned or top for vertical) of a [Navbar].
/// Used for branding, logos, or hamburger menus.
/// Renders as an HTML `<div>` with the 'navbar-start' class.
class NavbarStart extends UiComponent {
  /// Creates a NavbarStart section.
  const NavbarStart(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  });

  @override
  String get baseClass => 'navbar-start';

  @override
  NavbarStart copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return NavbarStart(
      children,
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

/// Represents the center section of a [Navbar].
/// Used for primary navigation links or titles.
/// Renders as an HTML `<div>` with the 'navbar-center' class.
class NavbarCenter extends UiComponent {
  /// Creates a NavbarCenter section.
  const NavbarCenter(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  });

  @override
  String get baseClass => 'navbar-center';

  @override
  NavbarCenter copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return NavbarCenter(
      children,
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

/// Represents the ending section (typically right-aligned or bottom for vertical) of a [Navbar].
/// Used for action items, user profile, or secondary navigation.
/// Renders as an HTML `<div>` with the 'navbar-end' class.
class NavbarEnd extends UiComponent {
  /// Creates a NavbarEnd section.
  const NavbarEnd(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  });

  @override
  String get baseClass => 'navbar-end';

  @override
  NavbarEnd copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return NavbarEnd(
      children,
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
