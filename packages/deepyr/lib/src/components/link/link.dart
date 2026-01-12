import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart' show Key;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'link_style.dart';

/// A component that styles an element to look like a hyperlink, typically adding an underline.
///
/// It renders as an `<a>` tag by default but can be changed using the `tag` property.
/// This is useful for styling buttons or other elements to look like links.
///
/// Example Usage:
/// ```dart
/// Link(
///   [text('Read more')],
///   href: '/about',
///   style: [Link.primary, Link.hover],
/// )
/// ```
class Link extends UiComponent {
  /// Creates a Link component.
  ///
  /// - [children]: The content of the link, typically text.
  /// - [href]: The URL that the hyperlink points to. Only applicable if the `tag` is 'a'.
  /// - [target]: Specifies where to open the linked document (e.g., '_blank', '_self').
  /// - [tag]: The HTML tag for the root element, defaults to 'a'.
  /// - [style]: A list of [LinkStyling] instances to control the color and hover behavior.
  /// - Other parameters are inherited from [UiComponent].
  const Link(
    super.children, {
    this.href,
    this.target,
    super.tag = 'a',
    List<LinkStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  /// The URL that the hyperlink points to.
  final String? href;

  /// Specifies where to open the linked document (e.g., `_blank`, `_self`).
  final String? target;

  @override
  String get baseClass => 'link';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    if (href != null) {
      attributes.add('href', href!);
    }
    if (target != null) {
      attributes.add('target', target!);
    }
  }

  @override
  Link copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Link(
      children,
      href: href,
      target: target,
      tag: tag,
      style: style as List<LinkStyling>?,
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

  /// Only shows the underline on hover. `link-hover`
  static const LinkStyle hover = LinkStyle('link-hover', type: StyleType.style);

  // Colors
  /// Neutral color. `link-neutral`
  static const LinkStyle neutral = LinkStyle('link-neutral', type: StyleType.style);

  /// Primary color. `link-primary`
  static const LinkStyle primary = LinkStyle('link-primary', type: StyleType.style);

  /// Secondary color. `link-secondary`
  static const LinkStyle secondary = LinkStyle('link-secondary', type: StyleType.style);

  /// Accent color. `link-accent`
  static const LinkStyle accent = LinkStyle('link-accent', type: StyleType.style);

  /// Success color. `link-success`
  static const LinkStyle success = LinkStyle('link-success', type: StyleType.style);

  /// Info color. `link-info`
  static const LinkStyle info = LinkStyle('link-info', type: StyleType.style);

  /// Warning color. `link-warning`
  static const LinkStyle warning = LinkStyle('link-warning', type: StyleType.style);

  /// Error color. `link-error`
  static const LinkStyle error = LinkStyle('link-error', type: StyleType.style);
}
