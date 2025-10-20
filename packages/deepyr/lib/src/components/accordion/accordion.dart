// This file defines the Accordion and AccordionItem components,
// which are used to create collapsible content sections where only one
// item can be open at a time.

import 'package:jaspr/jaspr.dart';

import '../../../deepyr.dart';
import '../../base/style_type.dart';
import 'accordion_style.dart';

/// A logical component that manages a group of [AccordionItem]s.
///
/// This component does not render its own HTML element. Instead, it processes its
/// [AccordionItem] children to ensure they all share the same `name` attribute,
/// allowing them to function as a single accordion group where only one item can be
/// open at a time.
///
/// Wrap this component in a styled `div` or `Container` for layout
/// and effects like `join`.
class Accordion extends StatelessComponent {
  /// Creates an Accordion group manager.
  ///
  /// - [children]: A list of components, expected to contain [AccordionItem]s.
  /// - [name]: A unique name for the radio button group. If not provided, a unique
  ///   name is generated. It's recommended to provide a stable name for consistency.
  const Accordion(
    this.children, {
    this.name,
    super.key,
  });

  /// A list of child components, which should include [AccordionItem]s.
  final List<Component> children;

  /// The name for the radio button group, essential for the accordion behavior.
  final String? name;

  @override
  Component build(BuildContext context) {
    // Generate a unique name for the radio group if one isn't provided.
    final effectiveName = name ?? 'accordion-${key.hashCode}';

    // Iterate through children and rebuild AccordionItems with the shared name.
    return Component.fragment([
      for (final child in children)
        if (child is AccordionItem)
          // return a new AccordionItem, injecting the managed 'name'.
          // All other properties are passed through from the original child.
          AccordionItem(
            title: child.title,
            content: child.content,
            name: effectiveName, // This is the key logic.
            initiallyOpen: child.initiallyOpen,
            style: child.style,
            classes: child.classes,
            tag: child.tag,
            id: child.id,
            key: child.key,
            attributes: child.userProvidedAttributes,
            css: child.css,
          )
        else
          // Pass through any non-AccordionItem children as-is.
          child,
    ]);
  }
}

/// Represents a single collapsible item within an [Accordion].
///
/// This component is based on the DaisyUI `collapse` component but is specifically
/// configured to work with a radio input for the accordion behavior.
class AccordionItem extends UiComponent {
  /// Creates a single item for an Accordion.
  ///
  /// - [title]: The component to be displayed in the clickable title area.
  /// - [content]: The component to be displayed in the collapsible content area.
  /// - [name]: The name of the radio button group. This is typically managed by the parent [Accordion] component.
  /// - [initiallyOpen]: If true, this item will be the one open by default in the accordion group.
  /// - [style]: A list of [AccordionStyling] modifiers, like [AccordionItem.arrow] or [AccordionItem.plus].
  const AccordionItem({
    required this.title,
    required this.content,
    required this.name,
    this.initiallyOpen = false,
    super.style,
    super.tag = 'div',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null); // Children are managed internally.

  /// The content for the visible, clickable title bar of the accordion item.
  final Component title;

  /// The content that is shown or hidden when the item is toggled.
  final Component content;

  /// The shared name for the radio input group, connecting all items in the accordion.
  final String name;

  /// Determines if this item is open by default when the accordion is first rendered.
  final bool initiallyOpen;

  @override
  String get baseClass => 'collapse';

  @override
  Map<String, String> get userProvidedAttributes => super.userProvidedAttributes;

  @override
  AccordionItem copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return AccordionItem(
      title: title,
      content: content,
      name: name,
      initiallyOpen: initiallyOpen,
      tag: tag,
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
    // The UiComponent's build method will render a single DomComponent.
    // We provide the specific internal structure of the accordion item as its children.
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: [
        input(
          type: InputType.radio,
          name: name,
          attributes: {
            if (initiallyOpen) 'checked': 'checked',
          },
        ),
        div(
          classes: 'collapse-title font-semibold',
          [title],
        ),
        div(
          classes: 'collapse-content text-sm',
          [content],
        ),
      ],
    );
  }

  // --- Static Style Modifiers ---

  /// Adds an arrow icon to the accordion item for visual feedback.
  static const AccordionStyle arrow = AccordionStyle(
    'collapse-arrow',
    type: StyleType.additional,
  );

  /// Adds a plus/minus icon to the accordion item for visual feedback.
  static const AccordionStyle plus = AccordionStyle(
    'collapse-plus',
    type: StyleType.additional,
  );

  /// Forces the item to be visually open. Useful for overriding radio state.
  static const AccordionStyle open = AccordionStyle(
    'collapse-open',
    type: StyleType.state,
  );

  /// Forces the item to be visually closed. Useful for overriding radio state.
  static const AccordionStyle close = AccordionStyle(
    'collapse-close',
    type: StyleType.state,
  );
}
