import 'package:jaspr/jaspr.dart' show BuildContext, Component, InputType, Key, Styles, input, text;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'tab_style.dart';
import 'tabs_style.dart';

/// A container for a set of [Tab] components, allowing users to switch between
/// different views or sections of content.
///
/// It renders as an HTML `<div>` with `role="tablist"` and applies layout modifiers.
///
/// ### Modes of Operation
///
/// 1.  **Navigation/Button Mode (Default):**
///     Standard tabs using `<a>` or `<button>` elements. Selection is handled
///     by your own routing or state management logic interacting with the `isActive` property.
///
/// 2.  **Radio Input Mode (DaisyUI "Lifted" / "Bordered" logic):**
///     Uses `<input type="radio">` elements. This enables DaisyUI's pure CSS content switching.
///     To use this mode safely in Jaspr, `Tab` components must be used as **Controlled Components**
///     by explicitly passing `isChecked` and `onChange`.
///
/// ### Example (Standard):
/// ```dart
/// Tabs(
///   style: [Tabs.lifted],
///   [
///     Tab([text('Home')], isActive: _index == 0, onClick: (_) => _setIndex(0)),
///     Tab([text('About')], isActive: _index == 1, onClick: (_) => _setIndex(1)),
///   ],
/// )
/// ```
///
/// ### Example (Radio Inputs):
/// ```dart
/// Tabs(
///   style: [Tabs.lifted],
///   [
///     Tab(tag: 'input', name: 'tabs', ariaLabel: 'Home', isChecked: _idx == 0, onChange: (_) => _setIndex(0)),
///     TabContent([text('Home Content')]),
///     Tab(tag: 'input', name: 'tabs', ariaLabel: 'About', isChecked: _idx == 1, onChange: (_) => _setIndex(1)),
///     TabContent([text('About Content')]),
///   ],
/// )
/// ```
class Tabs extends UiComponent {
  /// Creates a Tabs container.
  ///
  /// - [children]: A list of [Tab] and optionally [TabContent] components.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [TabsStyling] modifiers (e.g., `Tabs.lifted`, `Tabs.boxed`).
  /// - [ariaLabel]: An accessible name for the tab list (e.g., "Settings Navigation").
  /// - Other parameters are inherited from [UiComponent].
  const Tabs(
    super.children, {
    super.tag = 'div',
    List<TabsStyling>? style,
    this.ariaLabel,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  /// An accessible name for the tab list.
  final String? ariaLabel;

  @override
  String get baseClass => 'tabs';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);

    // Only add role="tablist" if it's not already present.
    if (!userProvidedAttributes.containsKey('role')) {
      attributes.addRole('tablist');
    }

    if (ariaLabel != null) {
      attributes.addAria('label', ariaLabel!);
    }
  }

  @override
  Tabs copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Tabs(
      children,
      tag: tag,
      style: style as List<TabsStyling>?,
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

  // --- Static Style Modifiers ---

  /// Applies the boxed style. `tabs-box`
  static const TabsStyle box = TabsStyle('tabs-box', type: StyleType.style);

  /// Applies the bottom border style. `tabs-border`
  static const TabsStyle border = TabsStyle('tabs-border', type: StyleType.style);

  /// Applies the lifted style (looks like file folder tabs). `tabs-lift`
  static const TabsStyle lift = TabsStyle('tabs-lift', type: StyleType.style);

  // Placement
  /// Puts tab buttons on top of the content (default). `tabs-top`
  static const TabsStyle top = TabsStyle('tabs-top', type: StyleType.layout);

  /// Puts tab buttons below the content. `tabs-bottom`
  static const TabsStyle bottom = TabsStyle('tabs-bottom', type: StyleType.layout);

  // Sizes
  /// Extra small size. `tabs-xs`
  static const TabsStyle xs = TabsStyle('tabs-xs', type: StyleType.sizing);

  /// Small size. `tabs-sm`
  static const TabsStyle sm = TabsStyle('tabs-sm', type: StyleType.sizing);

  /// Medium size (default). `tabs-md`
  static const TabsStyle md = TabsStyle('tabs-md', type: StyleType.sizing);

  /// Large size. `tabs-lg`
  static const TabsStyle lg = TabsStyle('tabs-lg', type: StyleType.sizing);

  /// Extra large size. `tabs-xl`
  static const TabsStyle xl = TabsStyle('tabs-xl', type: StyleType.sizing);
}

/// Represents a single tab item within a [Tabs] container.
///
/// It can render as:
/// 1.  A **Button/Link** (`tag: 'a'` or `'button'`) - Requires [isActive] prop for styling.
/// 2.  A **Radio Input** (`tag: 'input'`) - Requires [name], [isChecked], and [ariaLabel].
///
/// **Note on Radio Inputs:** When using `tag: 'input'`, this component acts as a
/// **controlled component**. You must provide [isChecked] to control the state
/// and prevent race conditions during rendering.
class Tab extends UiComponent {
  /// Creates a Tab component.
  ///
  /// - [children]: The content of the tab (text, icon). Ignored if `tag` is 'input' (use `ariaLabel` instead).
  /// - [tag]: Defaults to 'a'. Set to 'input' for radio-based tabs.
  /// - [isActive]: For non-input tabs, determines if the tab is visually active.
  /// - [isDisabled]: If true, applies disabled styling and attributes.
  /// - [isChecked]: For radio inputs, determines if the radio is checked. **Required** for controlled inputs.
  /// - [name]: The HTML `name` attribute, **required** for radio groups.
  /// - [ariaLabel]: The accessible label. For radio tabs in DaisyUI, this text is displayed visually.
  /// - [customStyles]: Optional [Styles] to apply raw CSS variables (e.g., `--tab-bg`) for overrides.
  /// - [onClick]: Callback when a button/link tab is clicked.
  /// - [onChange]: Callback when a radio tab is selected.
  /// - [style]: A list of [TabStyling] modifiers.
  const Tab(
    super.children, {
    super.tag = 'a',
    this.isActive = false,
    this.isDisabled = false,
    this.isChecked,
    this.name,
    this.ariaLabel,
    this.customStyles,
    List<TabStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.onClick,
    super.onChange, // Use for radio inputs
    super.child,
    super.key,
  }) : super(style: style);

  /// Whether this tab is currently active (visual state for buttons/links).
  final bool isActive;

  /// Whether this tab is disabled.
  final bool isDisabled;

  /// Whether this radio tab is checked. Only used when [tag] is 'input'.
  final bool? isChecked;

  /// The HTML name attribute. Required for radio groups to function mutually exclusively.
  final String? name;

  /// The accessible label. For radio tabs in DaisyUI, this string is displayed
  /// visually as the tab text via CSS.
  final String? ariaLabel;

  /// Additional raw styles, useful for CSS variables like `--tab-bg`.
  final Styles? customStyles;

  @override
  String get baseClass => 'tab';

  @override
  String get combinedClasses {
    var classes = super.combinedClasses;
    if (isActive) classes += ' tab-active';
    if (isDisabled) classes += ' tab-disabled';
    return classes;
  }

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);

    if (tag == 'input') {
      attributes.add('type', 'radio');
      if (name != null) attributes.add('name', name!);
      if (ariaLabel != null) attributes.add('aria-label', ariaLabel!);

      // IMPORTANT: We do NOT set the 'checked' attribute here manually.
      // It is controlled via the `checked` property in the `build` method
      // to ensure correct synchronization with the DOM.
    } else {
      // Standard ARIA roles for link/button tabs
      attributes.addRole('tab');
      if (isActive) attributes.addAria('selected', 'true');
    }

    if (isDisabled) {
      attributes.add('disabled', '');
    }
  }

  @override
  Tab copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    bool? isActive,
    bool? isDisabled,
    bool? isChecked,
    String? name,
    String? ariaLabel,
    Styles? customStyles,
  }) {
    return Tab(
      children,
      tag: tag,
      isActive: isActive ?? this.isActive,
      isDisabled: isDisabled ?? this.isDisabled,
      isChecked: isChecked ?? this.isChecked,
      name: name ?? this.name,
      ariaLabel: ariaLabel ?? this.ariaLabel,
      customStyles: customStyles ?? this.customStyles,
      style: style as List<TabStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      onClick: onClick,
      onChange: onChange,
      child: child,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    // Combine standard CSS with custom styles (e.g., variables for colors)
    final finalStyles = Styles.combine([
      if (css != null) css!,
      if (customStyles != null) customStyles!,
    ]);

    if (tag == 'input') {
      // Special handling for input to ensure event listeners and checked state
      // are bound correctly, resolving the Jaspr 0.21.6 race condition.
      return input(
        type: InputType.radio,
        name: name,
        id: id,
        classes: combinedClasses,
        styles: finalStyles,
        attributes: componentAttributes,

        // CRITICAL: Explicitly bind the checked property to the Dart state.
        // Using true/null ensures Jaspr enforces the state during reconciliation.
        checked: (isChecked ?? false) ? true : null,

        disabled: isDisabled,

        onChange: (val) {
          // Jaspr's onChange passes the value string, but for radio logic
          // we trigger the callback to let the parent update state.
          if (val is String) {
            onChange?.call(val);
          }
        },
      );
    }

    // Standard rendering for <a>, <button>, etc.
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: finalStyles,
      attributes: componentAttributes,
      events: eventMap,
      children: children ?? (ariaLabel != null ? [text(ariaLabel!)] : null),
    );
  }

  // --- Static Modifiers ---

  /// Marks the tab as active. `tab-active`
  static const TabStyle active = TabStyle('tab-active', type: StyleType.state);

  /// Marks the tab as disabled. `tab-disabled`
  static const TabStyle disabled = TabStyle('tab-disabled', type: StyleType.state);
}

/// Represents the content area associated with a [Tab] when using the radio input pattern.
///
/// It renders as a `div` with the `tab-content` class. In DaisyUI's CSS-only tabs,
/// this component must be placed immediately after its corresponding radio [Tab].
class TabContent extends UiComponent {
  /// Creates a TabContent container.
  const TabContent(
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
  });

  @override
  String get baseClass => 'tab-content';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    attributes.addRole('tabpanel');
  }

  @override
  TabContent copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return TabContent(
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
