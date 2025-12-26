import 'package:jaspr/dom.dart' show Styles, summary;
import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import '../button/button.dart' show Button;
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
    super.eventHandlers,
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
  Component build(BuildContext context) {
    final List<Component> effectiveChildren;

    // --- Method 1: <details> and <summary> ---
    // This method is highly accessible and works consistently across browsers.
    // We intelligently transform the provided `trigger` into a `<summary>` element,
    // preserving all its styling and attributes for a seamless developer experience.
    if (method == DropdownMethod.details) {
      Component summaryTrigger;
      if (trigger is UiComponent) {
        // If the trigger is a deepyr component, we can perfectly replicate its
        // appearance as a <summary> element by inheriting its properties.
        final triggerComponent = trigger as UiComponent;
        summaryTrigger = Component.element(
          tag: 'summary',
          classes: triggerComponent.combinedClasses,
          id: triggerComponent.id,
          styles: triggerComponent.css,
          attributes: triggerComponent.componentAttributes,
          events: triggerComponent.eventMap,
          children: triggerComponent.children ?? [?triggerComponent.child],
        );
      } else {
        // For primitive components (like text()), wrap them in a basic summary.
        summaryTrigger = summary([trigger]);
      }
      effectiveChildren = [summaryTrigger, content];
    }
    // --- Method 2: CSS :focus ---
    // This method is used for hover effects and animations. It requires a
    // focusable trigger to function correctly.
    else {
      var effectiveTrigger = trigger;

      // ** CRITICAL SAFARI WORKAROUND **
      // Safari has a long-standing CSS bug where a native <button> element does not
      // correctly trigger :focus-within selectors on its parent, which is what
      // DaisyUI uses for positioning the dropdown content.
      //
      // To ensure cross-browser compatibility, we detect if the trigger is a
      // deepyr `Button` that would render a `<button>` tag. If so, we transform
      // it into an accessible, focusable `<div>` that behaves identically but
      // avoids the Safari bug.
      if (trigger is Button && (trigger as Button).tag == 'button') {
        final button = trigger as Button;
        final userAttributes = button.userProvidedAttributes;

        effectiveTrigger = Component.element(
          tag: 'div',
          id: button.id,
          classes: button.combinedClasses,
          styles: button.css,
          events: button.eventMap,
          // Preserve user attributes, only adding defaults if not provided.
          // This allows developers to override the role (e.g., to 'menuitem')
          // or tabindex if they have a specific accessibility requirement.
          attributes: {
            ...userAttributes,
            'tabindex': userAttributes['tabindex'] ?? '0',
            'role': userAttributes['role'] ?? 'button',
          },
          children: button.children ?? [?button.child],
        );
      }
      // If the trigger is not a native <button>-based deepyr Button (e.g., it's
      // already a styled Container or an anchor tag), it is rendered as-is.

      effectiveChildren = [effectiveTrigger, content];
    }

    // Render the final dropdown container with the appropriate children.
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      events: eventMap,
      children: effectiveChildren,
    );
  }

  @override
  Dropdown copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
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
      eventHandlers: eventHandlers ?? this.eventHandlers,
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
  /// - [id]: An optional ID for the content element.
  /// - [classes]: Additional CSS classes to apply.
  /// - [css]: Custom CSS styles.
  /// - [attributes]: Additional HTML attributes to apply.
  /// - [eventHandlers]: Event handlers for user interactions.
  /// - [child]: An optional single child component.
  /// - [key]: An optional key for the component.
  const DropdownContent(
    super.children, {
    super.tag = 'div',
    List<DropdownContentStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
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
    Map<String, List<UiEventHandler>>? eventHandlers,
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
      eventHandlers: eventHandlers ?? this.eventHandlers,
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
