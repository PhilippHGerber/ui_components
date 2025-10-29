// This file defines the Accordion and AccordionItem components,
// which are used to create collapsible content sections.

import 'package:jaspr/jaspr.dart';

import '../../../deepyr.dart';
import '../../base/style_type.dart';
import 'accordion_style.dart';

/// A logical "smart container" that manages a group of [AccordionItem]s,
/// ensuring that only one can be open at a time.
///
/// This is a **controlled component**. Its state (which item is open) must be
/// managed by a parent `StatefulComponent`. The parent holds an `int?` representing
/// the index of the open item and passes it to the `openIndex` property.
///
/// The `Accordion` component itself does not render a DOM element; it processes
/// its children to inject the necessary properties (`isOpen` and `onToggle`)
/// for them to function as a coordinated group.
///
/// ### Example Usage (in a StatefulComponent):
///
/// ```dart
/// class MyAccordionPage extends StatefulComponent {
///   @override
///   State<MyAccordionPage> createState() => _MyAccordionPageState();
/// }
///
/// class _MyAccordionPageState extends State<MyAccordionPage> {
///   int? _openAccordionIndex; // State to hold the open item's index
///
///   @override
///   Component build(BuildContext context) {
///     return Accordion(
///       openIndex: _openAccordionIndex,
///       onToggle: (index) {
///         setState(() {
///           // Toggle behavior: close if the same item is clicked again.
///           _openAccordionIndex = _openAccordionIndex == index ? null : index;
///         });
///       },
///       [
///         AccordionItem(title: text('Item 1'), content: text('Content 1')),
///         AccordionItem(title: text('Item 2'), content: text('Content 2')),
///       ],
///     );
///   }
/// }
/// ```
class Accordion extends StatelessComponent {
  /// Creates a controlled Accordion group manager.
  ///
  /// - [children]: A list of components, expected to contain [AccordionItem]s.
  /// - [openIndex]: The index of the `AccordionItem` that should be open.
  ///   A value of `null` means all items are closed.
  /// - [onToggle]: A callback that fires when an `AccordionItem`'s title is
  ///   clicked. It provides the index of the clicked item.
  const Accordion(
    this.children, {
    this.openIndex,
    this.onToggle,
    super.key,
  });

  /// The list of child components, which should be exclusively [AccordionItem]s
  /// for the component to function correctly.
  final List<Component> children;

  /// The index of the currently open `AccordionItem`. If `null`, all items are closed.
  final int? openIndex;

  /// A callback invoked with the index of the `AccordionItem` that was clicked.
  final ValueChanged<int>? onToggle;

  @override
  Component build(BuildContext context) {
    final items = children.whereType<AccordionItem>().toList();

    return Component.fragment([
      for (var i = 0; i < items.length; i++)
        // Use `copyWith` to inject the calculated `isOpen` state and the
        // `onToggle` callback into each child item.
        items[i].copyWith(
          isOpen: i == openIndex,
          onToggle: () => onToggle?.call(i),
        ),
    ]);
  }
}

/// Represents a single collapsible item within an [Accordion].
///
/// This is a controlled component whose visibility is determined by the `isOpen`
/// property. It no longer manages its own state with a hidden input.
class AccordionItem extends UiComponent {
  /// Creates a single, controlled item for an Accordion.
  ///
  /// - [title]: The component to be displayed in the clickable title area.
  /// - [content]: The component to be displayed in the collapsible content area.
  /// - [isOpen]: If `true`, the item will be visually open. This is typically
  ///   controlled by the parent `Accordion`.
  /// - [onToggle]: A callback that fires when the title is clicked. This is
  ///   typically provided by the parent `Accordion`.
  /// - [style]: A list of [AccordionStyling] modifiers, like `AccordionItem.arrow`.
  const AccordionItem({
    required this.title,
    required this.content,
    this.isOpen = false,
    this.onToggle,
    super.style,
    super.tag = 'div',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null); // Children are managed internally.

  /// The content for the visible, clickable title bar.
  final Component title;

  /// The content that is shown or hidden.
  final Component content;

  /// Determines if this item is rendered in an open state.
  final bool isOpen;

  /// A callback invoked when the title of this item is clicked.
  final VoidCallback? onToggle;

  @override
  String get baseClass => 'collapse';

  @override
  String get combinedClasses {
    var classes = super.combinedClasses;
    // Conditionally apply the 'collapse-open' class based on the `isOpen` state.
    if (isOpen) {
      classes = '$classes collapse-open';
    }
    return classes;
  }

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // Add ARIA attributes for better accessibility.
    attributes.addAria('expanded', isOpen.toString());
  }

  @override
  AccordionItem copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    // Add the new controlled properties to `copyWith`.
    bool? isOpen,
    VoidCallback? onToggle,
  }) {
    return AccordionItem(
      title: title,
      content: content,
      isOpen: isOpen ?? this.isOpen,
      onToggle: onToggle ?? this.onToggle,
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
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: [
        div(
          classes: 'collapse-title font-semibold',
          // Attach the `onToggle` callback to the title's click event.
          events: onToggle != null ? {'click': (_) => onToggle!()} : null,
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
  static const AccordionStyle arrow = AccordionStyle('collapse-arrow', type: StyleType.additional);
  static const AccordionStyle plus = AccordionStyle('collapse-plus', type: StyleType.additional);
}
