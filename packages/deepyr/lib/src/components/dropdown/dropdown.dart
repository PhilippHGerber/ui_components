import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import 'dropdown_content_style.dart';
import 'dropdown_style.dart';

/// Defines the underlying HTML/CSS mechanism for a [Dropdown] component.
enum DropdownMethod {
  /// **(Recommended for Accessibility)** Uses the semantic `<details>` and `<summary>` elements.
  ///
  /// The `Dropdown` component will intelligently render the provided `trigger`
  /// component as a styled `<summary>` tag, preserving its appearance and content.
  /// This method is highly accessible and works without JavaScript.
  details,

  /// Uses the CSS `:focus` pseudo-class with a focusable `<div>`.
  ///
  /// This method opens the dropdown when the trigger is clicked or focused and
  /// closes it when focus is lost. It is ideal for hover effects and animations.
  focus,
}

/// A generic container that displays content when a trigger element is activated.
///
/// The `Dropdown` is a pure layout and behavior primitive. It separates the
/// interactive `trigger` from the `content` it displays, allowing for flexible
/// and composable UIs. It can display a navigational `Menu`, a `Card`, a form,
/// or any other component.
///
/// The component intelligently adapts its HTML structure based on the chosen [method],
/// ensuring a consistent and high-level API for the developer.
///
/// Example:
/// ```dart
/// // This works for both `details` and `focus` methods.
/// Dropdown(
///   trigger: Button([text('Show Menu')]),
///   content: DropdownContent(
///     [ MenuItem([text('Item 1')]) ],
///     tag: 'ul',
///     style: [DropdownContent.menu],
///     classes: 'p-2 shadow bg-base-100 rounded-box w-52',
///   ),
/// )
/// ```
class Dropdown extends UiComponent {
  /// Creates a Dropdown component.
  ///
  /// - [trigger]: The component the user interacts with (e.g., a `Button`).
  /// - [content]: The component to display when the dropdown is open.
  /// - [method]: The activation mechanism to use. Defaults to [DropdownMethod.details].
  /// - [style]: A list of [DropdownStyling] instances for placement and behavior.
  const Dropdown({
    required this.trigger,
    required this.content,
    this.method = DropdownMethod.details,
    List<DropdownStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(
         null, // Children are managed via trigger/content.
         tag: method == DropdownMethod.details ? 'details' : 'div',
         style: style,
       );

  /// The component that the user interacts with to open the dropdown.
  final Component trigger;

  /// The component that is shown when the dropdown is open.
  final Component content;

  /// The underlying HTML/CSS method to use for the dropdown behavior.
  final DropdownMethod method;

  @override
  String get baseClass => 'dropdown';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // For the focus method, the container itself should NOT be focusable.
    // Instead, the trigger and content elements inside it should be.
    // This was the source of the bug. The `Button` trigger is inherently
    // focusable, and `DropdownContent` adds its own tabindex.
  }

  @override
  Component build(BuildContext context) {
    final List<Component> effectiveChildren;

    if (method == DropdownMethod.details) {
      // For the `details` method, we intelligently construct a <summary> element
      // that inherits the visual properties of the provided trigger.
      Component summaryTrigger;
      if (trigger is UiComponent) {
        // If the trigger is a deepyr component, we can extract its classes,
        // children, and other properties to create a perfectly styled summary.
        final triggerComponent = trigger as UiComponent;
        summaryTrigger = Component.element(
          tag: 'summary',
          // Inherit all visual classes from the trigger button.
          classes: triggerComponent.combinedClasses,
          // Inherit other DOM properties.
          id: triggerComponent.id,
          styles: triggerComponent.css,
          attributes: triggerComponent.componentAttributes,
          events: triggerComponent.events,
          children: triggerComponent.children ?? [?triggerComponent.child],
        );
      } else {
        // If the trigger is a primitive (like `text()`), wrap it in a basic summary.
        summaryTrigger = summary([trigger]);
      }
      effectiveChildren = [summaryTrigger, content];
    } else {
      // For the `focus` method, the trigger and content are direct siblings.
      effectiveChildren = [trigger, content];
    }

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: effectiveChildren,
    );
  }

  @override
  Dropdown copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Dropdown(
      trigger: trigger,
      content: content,
      method: method,
      style: style as List<DropdownStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }

  // --- Static Dropdown Modifiers (Placement & Behavior) ---

  /// Aligns dropdown menu horizontally to the start of the button (default for LTR). `dropdown-start`
  static const DropdownStyle start = DropdownStyle('dropdown-start', type: StyleType.layout);

  /// Aligns dropdown menu horizontally to the center of the button. `dropdown-center`
  static const DropdownStyle center = DropdownStyle('dropdown-center', type: StyleType.layout);

  /// Aligns dropdown menu horizontally to the end of the button (right for LTR, left for RTL). `dropdown-end`
  static const DropdownStyle end = DropdownStyle('dropdown-end', type: StyleType.layout);

  /// Opens dropdown menu upwards. `dropdown-top`
  static const DropdownStyle top = DropdownStyle('dropdown-top', type: StyleType.layout);

  /// Opens dropdown menu downwards (default). `dropdown-bottom`
  static const DropdownStyle bottom = DropdownStyle('dropdown-bottom', type: StyleType.layout);

  /// Opens dropdown menu to the left. `dropdown-left`
  static const DropdownStyle left = DropdownStyle('dropdown-left', type: StyleType.layout);

  /// Opens dropdown menu to the right. `dropdown-right`
  static const DropdownStyle right = DropdownStyle('dropdown-right', type: StyleType.layout);

  /// Opens dropdown menu on hover instead of click (for CSS focus method). `dropdown-hover`
  static const DropdownStyle hover = DropdownStyle('dropdown-hover', type: StyleType.state);

  /// Forces the dropdown menu to be always open (CSS only). `dropdown-open`
  /// Note: For `<details>` method, use the `open` attribute on the `<details>` tag.
  static const DropdownStyle open = DropdownStyle('dropdown-open', type: StyleType.state);
}

/// The content area of a [Dropdown] that appears when the dropdown is triggered.
///
/// Typically renders as an HTML `<ul>` (for menus) or `<div>` (for cards or other content).
/// For CSS focus method, `applyDefaultTabIndex: true` (default) adds `tabindex="0"` to make
/// the content focusable.
///
/// The `modifiers` list accepts [DropdownContentStyling] (the interface), including
/// specific styles like [DropdownContent.menu] or [DropdownContent.card] (which apply general
/// DaisyUI classes), and other general Deepyr utilities.
class DropdownContent extends UiComponent {
  /// Creates a DropdownContent component.
  ///
  /// - [children]: The items or content to display within the dropdown.
  /// - [tag]: The HTML tag, defaults to 'ul' (suitable for menus). Change to 'div' for card-like content.
  /// - [style]: A list of [DropdownContentStyling] (the interface) instances.
  /// - [applyDefaultTabIndex]: If true (default), applies `tabindex="0"` to make the content
  ///   focusable. This is common for DaisyUI's CSS focus-based dropdowns.
  ///   Set to false if `tabindex` is managed manually or not needed (e.g., for `<details>` content).
  /// - [role]: An optional ARIA role for the content (e.g., "menu", "listbox").
  /// - Other parameters from [UiComponent].
  const DropdownContent(
    super.children, {
    super.tag = 'div',
    List<DropdownContentStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'dropdown-content';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // Add tabindex for focus method; this has no effect on the details method.
    if (!userProvidedAttributes.containsKey('tabindex')) {
      attributes.add('tabindex', '0');
    }
  }

  @override
  DropdownContent copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return DropdownContent(
      children,
      tag: tag,
      style: style as List<DropdownContentStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }

  // --- Static DropdownContent Style Modifiers ---
  // These are convenience modifiers for applying common DaisyUI classes to the content element.

  /// Adds the 'menu' class, typically used with `tag: 'ul'`.
  static const DropdownContentStyle menu = DropdownContentStyle('menu', type: StyleType.style);

  /// Adds the 'card' class, typically used with `tag: 'div'`.
  static const DropdownContentStyle card = DropdownContentStyle('card', type: StyleType.style);
}
