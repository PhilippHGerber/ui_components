import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' show Event, HTMLInputElement;

import '../../../deepyr.dart';
import '../../base/style_type.dart';
import 'collapse_style.dart';

/// Defines the activation mechanism for a [Collapse] component.
enum CollapseMethod {
  /// The component opens when it receives focus and closes when it loses focus (on blur).
  ///
  /// This method renders a `<div>` with `tabindex="0"`. It is suitable for simple,
  /// non-persistent content reveals.
  focus,

  /// The component toggles between open and closed states on each click.
  ///
  /// This method renders a hidden `<input type="checkbox">` internally to manage the state.
  /// The state persists until the component is clicked again.
  checkbox,

  /// The component uses the native HTML `<details>` and `<summary>` elements.
  ///
  /// This is a semantically correct and accessible method, but it does not support
  /// CSS transitions for the open/close animation. The state is managed by the browser.
  details,
}

/// A component for showing and hiding content in a collapsible panel.
///
/// It can be activated by focus, a checkbox, or by using the native `<details>` element,
/// controlled by the [method] property.
class Collapse extends UiComponent {
  /// Creates a Collapse component.
  ///
  /// - [title]: The component for the always-visible title area.
  /// - [content]: The component for the collapsible content area.
  /// - [method]: The activation mechanism to use. Defaults to [CollapseMethod.focus].
  /// - [initiallyOpen]: If `true`, the component will be open on first render.
  ///   This applies to the `checkbox` and `details` methods.
  /// - [onToggle]: A callback for the `checkbox` method that fires when the state
  ///   changes, providing the new open state (`true` for open, `false` for closed).
  /// - [style]: A list of [CollapseStyling] modifiers, such as [Collapse.arrow]
  ///   or [Collapse.plus], to customize the appearance.
  const Collapse({
    required this.title,
    required this.content,
    this.method = CollapseMethod.focus,
    this.initiallyOpen = false,
    this.onToggle,
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(null, tag: 'div');

  /// The content for the visible, clickable title bar.
  final Component title;

  /// The content that is shown or hidden when the component is toggled.
  final Component content;

  /// The activation method determining the underlying HTML structure and behavior.
  final CollapseMethod method;

  /// Determines if the component is open by default.
  ///
  /// For [CollapseMethod.checkbox], this sets the initial `checked` state.
  /// For [CollapseMethod.details], this adds the `open` attribute.
  /// This property has no effect on the `focus` method.
  final bool initiallyOpen;

  /// A callback that is invoked when the state of a `checkbox`-based collapse changes.
  ///
  /// This is only applicable when `method` is [CollapseMethod.checkbox].
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
        if (initiallyOpen) {
          attributes.add('open', '');
        }
      case CollapseMethod.checkbox:
        // No specific attributes needed on the root element for the checkbox method.
        break;
    }
  }

  @override
  Collapse copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Collapse(
      title: title,
      content: content,
      method: method,
      initiallyOpen: initiallyOpen,
      onToggle: onToggle,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    final titleComponent = div(classes: 'collapse-title font-semibold', [title]);
    final contentComponent = div(classes: 'collapse-content text-sm', [content]);

    final List<Component> children;
    var effectiveTag = 'div';

    switch (method) {
      case CollapseMethod.focus:
        children = [titleComponent, contentComponent];
      case CollapseMethod.checkbox:
        children = [
          input(
            type: InputType.checkbox,
            attributes: {
              if (initiallyOpen) 'checked': 'checked',
            },
            events: onToggle != null
                ? {
                    'change': (dynamic rawEvent) {
                      if (kIsWeb) {
                        final target = (rawEvent as Event).target! as HTMLInputElement;
                        onToggle!(target.checked);
                      }
                    },
                  }
                : null,
          ),
          titleComponent,
          contentComponent,
        ];
      case CollapseMethod.details:
        effectiveTag = 'details';
        children = [
          summary(classes: 'collapse-title font-semibold', [title]),
          contentComponent, // In <details>, content is a direct child
        ];
    }

    // return a single DomComponent with the determined tag and children.
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
  static const CollapseStyle arrow = CollapseStyle(
    'collapse-arrow',
    type: StyleType.additional,
  );

  /// Adds a plus/minus icon to the collapse component.
  static const CollapseStyle plus = CollapseStyle(
    'collapse-plus',
    type: StyleType.additional,
  );

  /// Forces the component to be visually open, overriding its current state.
  /// Note: This does not work for the `details` method.
  static const CollapseStyle open = CollapseStyle(
    'collapse-open',
    type: StyleType.state,
  );

  /// Forces the component to be visually closed, overriding its current state.
  /// Note: This does not work for the `details` method.
  static const CollapseStyle close = CollapseStyle(
    'collapse-close',
    type: StyleType.state,
  );
}
