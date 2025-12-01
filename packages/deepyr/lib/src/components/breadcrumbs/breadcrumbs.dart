import 'package:jaspr/jaspr.dart';

import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'breadcrumbs_style.dart';

/// A component for showing the hierarchy of the current page in a navigation path.
///
/// The `Breadcrumbs` component acts as a "smart container". It renders a `<div>`
/// with a nested `<ul>` and automatically wraps each of its direct children
/// (typically `<a>` tags or `deepyr` `Link` components) in an `<li>` tag. This
/// provides a clean and semantic API for the developer.
///
/// DaisyUI automatically adds dividers (e.g., '/') between the list items.
///
/// Example Usage:
/// ```dart
/// Breadcrumbs(
///   style: [TextUtil.sm],
///   [
///     // Use Jaspr's primitive `a()` or deepyr's `Link` for items
///     a([text('Home')], href: '/'),
///     a([text('Documents')], href: '/documents'),
///     // The last item is typically not a link
///     span([text('Add Document')]),
///   ],
/// )
/// ```
class Breadcrumbs extends UiComponent {
  /// Creates a Breadcrumbs component.
  ///
  /// - [children]: A list of components to be displayed as breadcrumb links.
  ///   Each child will be automatically wrapped in an `<li>` element.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [BreadcrumbsStyling] instances. Use this for general
  ///   utilities like `TextUtil` to control the size of the breadcrumb text.
  /// - [ariaLabel]: An accessible name for the breadcrumb navigation. Defaults
  ///   to "Breadcrumb".
  /// - Other parameters are inherited from [UiComponent].
  const Breadcrumbs(
    super.children, {
    super.tag = 'div',
    List<BreadcrumbsStyling>? style,
    this.ariaLabel = 'Breadcrumb',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(style: style);

  /// An accessible name for the navigation region.
  final String? ariaLabel;

  @override
  String get baseClass => 'breadcrumbs';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // 'navigation' is a landmark role, making it easier for users of
    // assistive technologies to find and understand the component.
    attributes.addRole('navigation');
    if (ariaLabel != null && ariaLabel!.isNotEmpty) {
      attributes.addAria('label', ariaLabel!);
    }
  }

  /// Overridden build method to wrap children in `<li>` tags.
  @override
  Component build(BuildContext context) {
    // Automatically wrap each direct child in an `li` element.
    final listItems = children?.map((child) => li([child])).toList();

    // The main UiComponent build method will render the outer `div` with the
    // 'breadcrumbs' class. We provide the nested `ul` as its child.
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: eventMap,
      // DaisyUI structure is `div.breadcrumbs > ul > li > a`
      children: [ul(listItems ?? [])],
    );
  }

  @override
  Breadcrumbs copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Breadcrumbs(
      children,
      tag: tag,
      style: style as List<BreadcrumbsStyling>?,
      ariaLabel: ariaLabel,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}
