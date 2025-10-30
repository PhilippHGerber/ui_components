import 'package:jaspr/jaspr.dart';

import '../../../deepyr.dart';
import '../../base/style_type.dart';
import 'collapse_style.dart';

/// Defines the activation mechanism for a [Collapse] component.
enum CollapseMethod {
  /// The component opens when it receives focus and closes when it loses focus.
  /// Renders a `<div>` with `tabindex="0"`. No state management needed.
  focus,

  /// The component's open/closed state is controlled by a parent component.
  /// This method is now a **controlled component**.
  checkbox,

  /// Uses the native HTML `<details>` and `<summary>` elements.
  /// No state management needed for basic open/close.
  details,
}

/// A component for showing and hiding content in a collapsible panel.
///
/// It can be activated by focus, a parent-controlled state (checkbox method),
/// or by using the native `<details>` element, controlled by the [method] property.
///
/// ### State Management:
/// - **`focus` & `details` methods:** Are self-contained and do not require state management.
/// - **`checkbox` method:** This is now a **controlled component**. You must manage its
///   state in a parent `StatefulComponent` using the `isOpen` and `onToggle` properties.
///
/// ### Example (Checkbox Method):
/// ```dart
/// class MyCollapsible extends StatefulComponent {
///   @override
///   State<MyCollapsible> createState() => _MyCollapsibleState();
/// }
///
/// class _MyCollapsibleState extends State<MyCollapsible> {
///   bool _isPanelOpen = false;
///
///   @override
///   Component build(BuildContext context) {
///     return Collapse(
///       method: CollapseMethod.checkbox,
///       isOpen: _isPanelOpen,
///       onToggle: () {
///         setState(() => _isPanelOpen = !_isPanelOpen);
///       },
///       title: text('Click me'),
///       content: text('Content'),
///     );
///   }
/// }
/// ```
class Collapse extends UiComponent {
  /// Creates a Collapse component.
  ///
  /// - [title]: The component for the always-visible title area.
  /// - [content]: The component for the collapsible content area.
  /// - [method]: The activation mechanism to use. Defaults to [CollapseMethod.focus].
  /// - For `checkbox` method:
  ///   - [isOpen]: The current open state of the component.
  ///   - [onToggle]: A callback that fires when the title is clicked.
  /// - For `details` method:
  ///   - [initiallyOpen]: If `true`, the component will be open on first render.
  /// - [style]: A list of [CollapseStyling] modifiers.
  const Collapse({
    required this.title,
    required this.content,
    this.method = CollapseMethod.focus,
    // Properties for controlled (checkbox) method
    this.isOpen = false,
    this.onToggle,
    // Property for uncontrolled (details) method
    this.initiallyOpen = false,
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, tag: 'div');

  /// The content for the visible, clickable title bar.
  final Component title;

  /// The content that is shown or hidden when the component is toggled.
  final Component content;

  /// The activation method determining the underlying HTML structure and behavior.
  final CollapseMethod method;

  /// **For `checkbox` method:** The current open state of the component.
  final bool isOpen;

  /// **For `checkbox` method:** A callback invoked when the title is clicked.
  final VoidCallback? onToggle;

  /// **For `details` method:** Determines if the component is open by default.
  final bool initiallyOpen;

  @override
  String get baseClass => 'collapse';

  @override
  String get combinedClasses {
    var classes = super.combinedClasses;
    // For the controlled checkbox method, conditionally apply the open class.
    if (method == CollapseMethod.checkbox && isOpen) {
      classes = '$classes collapse-open';
    }
    return classes;
  }

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);

    switch (method) {
      case CollapseMethod.focus:
        if (!userProvidedAttributes.containsKey('tabindex')) {
          attributes.add('tabindex', '0');
        }
        attributes.addAria('expanded', 'false'); // CSS handles visual state
      case CollapseMethod.details:
        if (initiallyOpen) {
          attributes.add('open', '');
        }
      case CollapseMethod.checkbox:
        attributes.addAria('expanded', isOpen.toString());
    }
  }

  @override
  Collapse copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    // Add new properties to copyWith
    bool? isOpen,
    VoidCallback? onToggle,
  }) {
    return Collapse(
      title: title,
      content: content,
      method: method,
      isOpen: isOpen ?? this.isOpen,
      onToggle: onToggle ?? this.onToggle,
      initiallyOpen: initiallyOpen,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    var effectiveTag = 'div';
    final List<Component> children;

    final contentComponent = div(classes: 'collapse-content text-sm', [content]);

    switch (method) {
      case CollapseMethod.focus:
        final titleComponent = div(classes: 'collapse-title font-semibold', [title]);
        children = [titleComponent, contentComponent];

      case CollapseMethod.checkbox:
        // The title now has the click handler, and there is no hidden input.
        final titleComponent = div(
          classes: 'collapse-title font-semibold',
          events: onToggle != null ? {'click': (_) => onToggle!()} : null,
          [title],
        );
        children = [titleComponent, contentComponent];

      case CollapseMethod.details:
        effectiveTag = 'details';
        // The title is wrapped in a <summary> for the native details element.
        final titleComponent = summary(classes: 'collapse-title font-semibold', [title]);
        children = [titleComponent, contentComponent];
    }

    return Component.element(
      tag: effectiveTag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: children,
    );
  }

  // --- Static Style Modifiers ---
  /// Adds an arrow icon to the collapse component.
  static const CollapseStyle arrow = CollapseStyle('collapse-arrow', type: StyleType.additional);

  /// Adds a plus/minus icon to the collapse component.
  static const CollapseStyle plus = CollapseStyle('collapse-plus', type: StyleType.additional);

  /// Forces the component to be visually open, overriding its current state.
  /// Note: This does not work for the `details` method.
  static const CollapseStyle open = CollapseStyle('collapse-open', type: StyleType.state);

  /// Forces the component to be visually closed, overriding its current state.
  /// Note: This does not work for the `details` method.
  static const CollapseStyle close = CollapseStyle('collapse-close', type: StyleType.state);
}
