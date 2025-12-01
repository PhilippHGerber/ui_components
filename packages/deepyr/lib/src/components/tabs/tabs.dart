import 'package:jaspr/jaspr.dart' show BuildContext, Component, Key, Styles;

import '../../base/style_type.dart';
import '../../base/styling.dart' show Styling;
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'tab_style.dart';
import 'tabs_style.dart';

/// A container for a set of [Tab] components, allowing users to switch between
/// different views or sections of content.
///
/// The `styles` list accepts [TabsStyling] (the interface) instances,
/// which includes specific tabs container styles (like [Tabs.border], [Tabs.lifted])
/// and general utility classes.
/// It should typically render as an HTML `<div>` with `role="tablist"`.
class Tabs extends UiComponent {
  /// Creates a Tabs container component.
  ///
  /// - [children]: A list of [Tab] components, or for radio-tab patterns,
  ///   a sequence of input/TabContent pairs.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [TabsStyling] (the interface) instances.
  /// - [ariaLabel]: An accessible name for the tab list (e.g., "Content sections").
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
  String get baseClass => 'tabs'; // DaisyUI base class

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    attributes.addRole('tablist');
    if (ariaLabel != null && ariaLabel!.isNotEmpty) {
      attributes.addAria('label', ariaLabel!);
    }

    // Determine orientation based on modifiers if needed, though default is horizontal
    // bool isBottom = modifiers?.any((m) => m is TabsStyleModifier && m.cssClass == Tabs.bottom.cssClass) ?? false;
    // attributes.addAria('orientation', isBottom ? 'vertical' : 'horizontal'); // Simplified, check DaisyUI actual behavior for orientation based on bottom
    attributes.addAria('orientation', 'horizontal'); // Default for tabs
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
  // --- Static Tabs Modifiers ---

  /// Bottom border style for tabs. `tabs-border`
  static const TabsStyle border = TabsStyle(
    'tabs-border',
    type: StyleType.style,
  );

  /// Lifted tabs style. `tabs-lift`
  static const TabsStyle lift = TabsStyle(
    'tabs-lift',
    type: StyleType.style,
  );

  /// Boxed tabs style. `tabs-box`
  static const TabsStyle box = TabsStyle(
    'tabs-box',
    type: StyleType.style,
  );

  // Placement
  /// Puts tab buttons on top of the tab-content (default). `tabs-top`
  static const TabsStyle top = TabsStyle(
    'tabs-top',
    type: StyleType.layout,
  );

  /// Puts tabs under the tab-content. `tabs-bottom`
  static const TabsStyle bottom = TabsStyle(
    'tabs-bottom',
    type: StyleType.layout,
  );

  // Sizes
  /// Extra small tabs size. `tabs-xs`
  static const TabsStyle xs = TabsStyle(
    'tabs-xs',
    type: StyleType.sizing,
  );

  /// Small tabs size. `tabs-sm`
  static const TabsStyle sm = TabsStyle(
    'tabs-sm',
    type: StyleType.sizing,
  );

  /// Medium tabs size (default). `tabs-md`
  static const TabsStyle md = TabsStyle(
    'tabs-md',
    type: StyleType.sizing,
  );

  /// Large tabs size. `tabs-lg`
  static const TabsStyle lg = TabsStyle(
    'tabs-lg',
    type: StyleType.sizing,
  );

  /// Extra large tabs size. `tabs-xl`
  static const TabsStyle xl = TabsStyle(
    'tabs-xl',
    type: StyleType.sizing,
  );
}

/// Represents an individual tab item within a [Tabs] container.
///
/// It typically renders as an HTML `<a>` or `<button>` element with `role="tab"`.
/// The `modifiers` list accepts [TabStyling] (the interface) instances.
/// An active tab should have the `Tab.active` modifier or `isActive` set to true.
class Tab extends UiComponent {
  /// Creates a Tab component.
  ///
  /// - [children] or [child]: The label or content of the tab. For radio input tabs,
  ///   this is usually null, and `ariaLabel` is used for the visible text.
  /// - [tag]: The HTML tag, defaults to 'button'. Can be 'a' for links, or 'input' for radio tabs.
  /// - [isActive]: If true, this tab is marked as active (applies `Tab.active` modifier and `aria-selected`).
  /// - [isDisabled]: If true, this tab is marked as disabled (applies `Tab.disabled` modifier and `aria-disabled`).
  /// - [controlsPanelId]: The ID of the tab panel this tab controls (for `aria-controls`).
  /// - [styles]: A list of [TabStyling] (the interface) instances.
  /// - [customStyles]: A Jaspr [Styles] object for applying raw CSS, primarily for
  ///   custom properties (variables) like `--tab-bg` to override theme colors.
  /// - [onClick]: Callback for when the tab is clicked.
  /// - For radio input tabs (`tag == 'input'`):
  ///   - `name`: The name for the radio group.
  ///   - `ariaLabel`: The visible label for the radio tab.
  ///   - `isChecked`: If this radio tab is checked.
  /// - Other parameters are inherited from [UiComponent].
  const Tab(
    super.children, {
    super.tag = 'button',
    this.isActive = false,
    this.isDisabled = false,
    this.controlsPanelId,
    List<TabStyling>? styles,
    this.customStyles,
    this.name,
    this.ariaLabel,
    this.isChecked,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.onClick,
    super.child,
    super.key,
  }) : _initialModifiers = styles,
       super(style: styles);

  /// Whether this tab is currently active.
  final bool isActive;

  /// Whether this tab is disabled.
  final bool isDisabled;

  /// The ID of the tab panel element that this tab controls.
  final String? controlsPanelId;

  /// A Jaspr [Styles] object for applying raw CSS properties.
  /// This is the recommended way to apply DaisyUI CSS custom properties
  /// (variables) like `--tab-bg` or `--tab-border-color` to override the
  /// theme for a specific tab.
  ///
  /// Example:
  /// ```dart
  /// Tab(
  ///   [text('Custom Tab')],
  ///   isActive: true,
  ///   customStyles: Styles(raw: {
  ///     '--tab-bg': 'orange',
  ///     '--tab-border-color': 'red',
  ///   }),
  /// )
  /// ```
  final Styles? customStyles;

  /// The HTML `name` attribute, used when `tag` is 'input' (e.g., for radio button groups).
  final String? name;

  /// The `aria-label` attribute. For radio tabs, this is used by DaisyUI as the visible label.
  final String? ariaLabel;

  /// For radio tabs (`tag == 'input'`, `type == 'radio'`), determines if it's checked.
  final bool? isChecked;

  final List<TabStyling>? _initialModifiers;

  @override
  String get baseClass => 'tab';

  @override
  String get combinedClasses {
    final effectiveClasses = <String>[baseClass];

    if (_initialModifiers != null) {
      for (final modifier in _initialModifiers) {
        effectiveClasses.add(modifier.toString());
      }
    }

    if (isActive) {
      effectiveClasses.add(Tab.active.toString());
    }
    if (isDisabled) {
      effectiveClasses.add(Tab.disabled.toString());
    }

    if (classes != null && classes!.isNotEmpty) {
      effectiveClasses.add(classes!);
    }
    return effectiveClasses.where((c) => c.isNotEmpty).join(' ');
  }

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);

    if (tag == 'input') {
      attributes.add(
        'type',
        'radio',
      ); // Assuming 'input' tag for Tab means radio for now
      if (name != null) {
        attributes.add('name', name!);
      }
      if (ariaLabel != null) {
        attributes.addAria('label', ariaLabel!);
      }
      if (isChecked ?? false) {
        attributes.add('checked', 'checked');
      }
      // For radio inputs acting as tabs, role="tab" might not be appropriate on the input itself.
      // The label wrapping it, or the visual representation, might get the role.
      // DaisyUI applies .tab class to the input. ARIA role="tab" is on the input in their examples.
      attributes.addRole('tab');
    } else {
      // For button, a, etc.
      attributes
        ..addRole('tab')
        ..addAria('selected', isActive.toString());
      if (isDisabled) {
        attributes.addAria('disabled', 'true');
        // For non-button elements acting as tabs, tabindex might need explicit management
        // if native 'disabled' attribute isn't applicable.
        if (tag != 'button') {
          attributes.add('tabindex', '-1');
        }
      } else {
        attributes.add('tabindex', isActive ? '0' : '-1');
      }
    }

    if (controlsPanelId != null) {
      attributes.addAria('controls', controlsPanelId!);
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
    // Add customStyles to the copyWith method
    Styles? customStyles,
  }) {
    return Tab(
      children,
      tag: tag,
      isActive: isActive,
      isDisabled: isDisabled,
      controlsPanelId: controlsPanelId,
      styles: style as List<TabStyling>?,
      customStyles: customStyles ?? this.customStyles,
      name: name,
      ariaLabel: ariaLabel,
      isChecked: isChecked,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      onClick: onClick,
      child: child,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      // Combine base `css` with `customStyles`. `customStyles` will take precedence.
      styles: Styles.combine([
        if (css != null) css!,
        if (customStyles != null) customStyles!,
      ]),
      attributes: componentAttributes,
      events: eventMap,
      children: children ?? [?child],
    );
  }

  // --- Static Tab Modifiers ---

  /// Marks the tab as active. `tab-active`
  static const TabStyle active = TabStyle(
    'tab-active',
    type: StyleType.state,
  );

  /// Marks the tab as disabled. `tab-disabled`
  static const TabStyle disabled = TabStyle(
    'tab-disabled',
    type: StyleType.state,
  );
}

/// Represents the content area associated with a tab.
/// Typically renders as an HTML `<div>` with the 'tab-content' class.
class TabContent extends UiComponent {
  /// Creates a TabContent component.
  ///
  /// - [children] or [child]: The content of the tab panel.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of general [Styling] instances for styling.
  /// - [id]: The ID of this panel, to be referenced by a `Tab`'s `aria-controls`.
  /// - [labelledByTabId]: The ID of the `Tab` that labels this panel (for `aria-labelledby`).
  /// - Other parameters are inherited from [UiComponent].
  const TabContent(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    this.labelledByTabId,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  });

  /// The ID of the tab that labels this panel.
  final String? labelledByTabId;

  @override
  String get baseClass => 'tab-content';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    attributes.addRole('tabpanel');
    if (labelledByTabId != null) {
      attributes.addAria('labelledby', labelledByTabId!);
    }
    // `aria-hidden` or `hidden` attribute would be managed by user/state to show/hide content.
    // attributes.add('tabindex', '0'); // Make panel focusable if it contains interactive content
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
      labelledByTabId: labelledByTabId,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }
}
