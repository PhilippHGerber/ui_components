import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'footer_style.dart';

/// A component for the bottom section of a site, typically containing links,
/// copyright notices, and other information.
///
/// The `Footer` component renders a `<footer>` element and acts as a container
/// for its content, which is structured using the dedicated [FooterAside],
/// [FooterNav], and [FooterTitle] sub-components.
///
/// Example Usage:
/// ```dart
/// Footer(
///   style: [Footer.horizontal.at(Breakpoint.sm), BgUtil.neutral, TextUtil.neutralContent, Spacing.p10],
///   [
///     FooterAside([
///       // ... logo and branding
///     ]),
///     FooterNav(
///       title: 'Services',
///       [
///         Link([text('Branding')], href: '#', style: [Link.hover]),
///         Link([text('Design')], href: '#', style: [Link.hover]),
///       ]
///     ),
///     FooterNav(
///       title: 'Company',
///       [
///         Link([text('About us')], href: '#', style: [Link.hover]),
///         Link([text('Contact')], href: '#', style: [Link.hover]),
///       ]
///     ),
///   ],
/// )
/// ```
class Footer extends UiComponent {
  /// Creates a Footer component.
  ///
  /// - [children]: The content of the footer, which should be composed of
  ///   [FooterAside] and [FooterNav] components.
  /// - [tag]: The HTML tag for the root element, defaults to 'footer'.
  /// - [style]: A list of [FooterStyling] instances. Use this for layout
  ///   modifiers like `Footer.horizontal` or `Footer.center`, and for general
  ///   utilities like background colors and padding.
  /// - Other parameters are inherited from [UiComponent].
  const Footer(
    super.children, {
    super.tag = 'footer',
    List<FooterStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'footer';

  @override
  Footer copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Footer(
      children,
      tag: tag,
      style: style as List<FooterStyling>?,
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

  /// Aligns footer content to the center. `footer-center`
  static const FooterStyle center = FooterStyle('footer-center', type: StyleType.layout);

  /// Stacks footer columns horizontally. `footer-horizontal`
  static const FooterStyle horizontal = FooterStyle('footer-horizontal', type: StyleType.layout);

  /// Stacks footer columns vertically (default behavior on small screens). `footer-vertical`
  static const FooterStyle vertical = FooterStyle('footer-vertical', type: StyleType.layout);
}

/// A title component for a section or column within a [Footer].
///
/// It renders an `<h6>` element with the `footer-title` class and is typically
/// used as the first child of a [FooterNav] component.
class FooterTitle extends UiComponent {
  /// Creates a FooterTitle component.
  ///
  /// - [children]: The text content of the title.
  /// - [tag]: The HTML tag for the root element, defaults to 'h6' for semantic correctness.
  /// - [style]: A list of general utilities for additional styling if needed.
  /// - Other parameters are inherited from [UiComponent].
  const FooterTitle(
    super.children, {
    super.tag = 'h6',
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
  String get baseClass => 'footer-title';

  @override
  FooterTitle copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return FooterTitle(
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

/// A semantic container for a navigation column within a [Footer].
///
/// This component renders a `<nav>` element and can optionally include a
/// [FooterTitle] by providing the `title` parameter.
class FooterNav extends UiComponent {
  /// Creates a navigation section for a [Footer].
  ///
  /// - [children]: A list of link components (e.g., `deepyr` `Link`).
  /// - [title]: An optional string that, if provided, creates a [FooterTitle]
  ///   as the first element inside the `<nav>`.
  /// - [tag]: The HTML tag for the root element, defaults to 'nav'.
  /// - Other parameters are inherited from [UiComponent].
  const FooterNav(
    super.children, {
    String? title,
    super.tag = 'nav',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : _title = title,
       super(style: null); // FooterNav itself does not take deepyr styles.

  final String? _title;

  @override
  String get baseClass => ''; // No base class on the <nav> itself.

  @override
  Component build(BuildContext context) {
    final navChildren = <Component>[];
    if (_title != null && _title.isNotEmpty) {
      navChildren.add(FooterTitle([text(_title)]));
    }
    if (children != null) {
      navChildren.addAll(children!);
    }

    // The build method of UiComponent will render the outer tag ('nav' by default).
    // We just need to provide the children.
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: navChildren,
    );
  }

  @override
  FooterNav copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return FooterNav(
      children,
      title: _title,
      tag: tag,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}

/// A semantic container for the branding section of a [Footer].
///
/// This component renders an `<aside>` element, which is the correct semantic
/// tag for content that is tangentially related to the main content, such as
/// a company logo and copyright notice in a footer.
class FooterAside extends UiComponent {
  /// Creates a branding section for a [Footer].
  ///
  /// - [children]: The content of the aside section, typically a logo and `p` tags.
  /// - [tag]: The HTML tag for the root element, defaults to 'aside'.
  /// - Other parameters are inherited from [UiComponent].
  const FooterAside(
    super.children, {
    super.tag = 'aside',
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
  String get baseClass => ''; // No base class on the <aside> itself.

  @override
  FooterAside copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return FooterAside(
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
