import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' show Event, HTMLDetailsElement;

import '../../../deepyr.dart';
import '../../base/style_type.dart';
import 'collapse_style.dart';

/// Defines the activation mechanism for a [Collapse] component.
enum CollapseMethod {
  /// The component opens on focus and closes on blur. This method is stateless
  /// and cannot be controlled programmatically via the `isOpen` property.
  focus,

  /// The component toggles on click, using a hidden checkbox. This is a fully
  /// controlled method managed by the `isOpen` and `onToggle` properties.
  checkbox,

  /// The component uses the native HTML `<details>` and `<summary>` elements.
  /// This is a fully controlled, accessible method, but it does not support
  /// CSS transitions for the open/close animation.
  details,
}

/// A component for showing and hiding content in a collapsible panel.
///
/// When using the `checkbox` or `details` methods, `Collapse` is a **controlled
/// component**. Its open/closed state must be managed by a parent stateful component
/// through the `isOpen` property and the `onToggle` callback.
///
/// The `focus` method is purely CSS-driven and stateless.
///
/// ### Example of Controlled Usage (`checkbox` method):
///
/// ```dart
/// class MyCollapsibleSection extends StatefulComponent {
///   @override
///   State<MyCollapsibleSection> createState() => _MyCollapsibleSectionState();
/// }
///
/// class _MyCollapsibleSectionState extends State<MyCollapsibleSection> {
///   bool _isPanelOpen = false;
///
///   @override
///   Component build(BuildContext context) {
///     return Collapse(
///       method: CollapseMethod.checkbox,
///       isOpen: _isPanelOpen,
///       onToggle: (newValue) {
///         setState(() => _isPanelOpen = newValue);
///       },
///       title: text('Click to toggle'),
///       content: p([text('This is the hidden content.')]),
///       style: [Collapse.arrow],
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
  /// - [isOpen]: The current open state of the component. This is the source of
  ///   truth for the `checkbox` and `details` methods. Defaults to `false`.
  /// - [onToggle]: A `ValueChanged<bool>` callback for the `checkbox` and `details` methods
  ///   that fires when the state changes.
  /// - [style]: A list of [CollapseStyling] modifiers, such as `Collapse.arrow`.
  const Collapse({
    required this.title,
    required this.content,
    this.method = CollapseMethod.focus,
    this.isOpen = false,
    this.onToggle,
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

  /// The current open state of the component.
  /// This is the single source of truth for the `checkbox` and `details` methods.
  final bool isOpen;

  /// A callback that is invoked when the state of a `checkbox` or `details`
  /// based collapse changes.
  final ValueChanged<bool>? onToggle;

  @override
  String get baseClass => 'collapse';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    switch (method) {
      case CollapseMethod.focus:
        // Make the div focusable to enable the :focus CSS pseudo-class.
        if (!userProvidedAttributes.containsKey('tabindex')) {
          attributes.add('tabindex', '0');
        }
      case CollapseMethod.details:
        // Set the initial open state for the <details> element.
        if (isOpen) {
          attributes.add('open', '');
        }
      case CollapseMethod.checkbox:
        // No specific attributes needed on the root element.
        break;
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
    Component? title,
    Component? content,
    CollapseMethod? method,
    bool? isOpen,
    ValueChanged<bool>? onToggle,
  }) {
    return Collapse(
      title: title ?? this.title,
      content: content ?? this.content,
      method: method ?? this.method,
      isOpen: isOpen ?? this.isOpen,
      onToggle: onToggle ?? this.onToggle,
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
    final titleComponent = div(classes: 'collapse-title font-semibold', [title]);
    final contentComponent = div(classes: 'collapse-content text-sm', [content]);

    var effectiveTag = 'div';
    final List<Component> children;
    final eventMap = Map<String, EventCallback>.from(this.eventMap);

    switch (method) {
      case CollapseMethod.focus:
        children = [titleComponent, contentComponent];
      case CollapseMethod.checkbox:
        children = [
          input(
            type: InputType.checkbox,
            // Jaspr bug workaround: use `true`/`null` instead of `true`/`false`.
            checked: isOpen ? true : null,
            onChange: (dynamic value) {
              // Jaspr's `input` `onChange` provides `dynamic`.
              if (onToggle != null && kIsWeb && value is bool) {
                onToggle!(value);
              }
            },
          ),
          titleComponent,
          contentComponent,
        ];
      case CollapseMethod.details:
        effectiveTag = 'details';
        if (onToggle != null) {
          eventMap['toggle'] = (dynamic rawEvent) {
            if (kIsWeb) {
              final target = (rawEvent as Event).target! as HTMLDetailsElement;
              onToggle!(target.open);
            }
          };
        }
        children = [
          summary(classes: 'collapse-title font-semibold', [title]),
          contentComponent,
        ];
    }

    return Component.element(
      tag: effectiveTag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: eventMap,
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
