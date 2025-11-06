import 'package:jaspr/jaspr.dart';

import '../../../deepyr.dart';
import '../../base/style_type.dart';
import 'accordion_style.dart';

/// A "smart container" that manages a group of [AccordionItem]s, ensuring only
/// one can be open at a time.
///
/// `Accordion` is a **controlled component** and is generic over the type `T` of its
/// item identifiers. Its state (which item is open) must be managed by a parent
/// stateful component.
///
/// The parent component provides the currently selected `groupValue` (which corresponds
/// to the `value` of the open `AccordionItem`) and an `onValueChanged` callback
/// to handle state updates. The `Accordion` component then injects the necessary
/// properties into its `AccordionItem` children to make them function as a single,
/// mutually exclusive radio group.
///
/// ### Example Usage (in a StatefulComponent):
///
/// ```dart
/// class MyFaq extends StatefulComponent {
///   @override
///   State<MyFaq> createState() => _MyFaqState();
/// }
///
/// class _MyFaqState extends State<MyFaq> {
///   // The state variable holds the value of the currently open item.
///   String? _openItem = 'faq-1';
///
///   @override
///   Component build(BuildContext context) {
///     return Accordion<String>(
///       name: 'my-faq-accordion',
///       // 1. Pass the current state to the Accordion.
///       groupValue: _openItem,
///       // 2. Provide a callback to update the state when a new item is clicked.
///       onValueChanged: (newValue) {
///         setState(() {
///           // This logic allows toggling an item off by clicking it again.
///           _openItem = _openItem == newValue ? null : newValue;
///         });
///       },
///       [
///         AccordionItem(
///           value: 'faq-1', // Each item must have a unique value of type T.
///           title: text('How do I create an account?'),
///           content: text('...'),
///           style: [AccordionItem.arrow],
///         ),
///         AccordionItem(
///           value: 'faq-2',
///           title: text('I forgot my password.'),
///           content: text('...'),
///           style: [AccordionItem.arrow],
///         ),
///       ],
///     );
///   }
/// }
/// ```
class Accordion<T> extends StatelessComponent {
  /// Creates a controlled Accordion group manager.
  ///
  /// - [children]: A list of components, expected to contain [AccordionItem<T>]s.
  /// - [groupValue]: The `value` of the currently open `AccordionItem`. A `null`
  ///   value means all items are closed.
  /// - [onValueChanged]: A callback that fires when the user selects a new item,
  ///   providing the `value` of that item.
  /// - [name]: A unique name for the radio button group. If not provided, a unique
  ///   name is generated. It's recommended to provide a stable name for consistency.
  const Accordion(
    this.children, {
    required this.groupValue,
    required this.onValueChanged,
    this.name,
    super.key,
  });

  /// The list of child components, which should include [AccordionItem<T>]s.
  final List<Component> children;

  /// The `value` of the currently selected (open) `AccordionItem`.
  final T? groupValue;

  /// A callback invoked with the new value when a different `AccordionItem` is selected.
  final ValueChanged<T> onValueChanged;

  /// The name for the radio button group, essential for the accordion behavior.
  final String? name;

  @override
  Component build(BuildContext context) {
    final effectiveName = name ?? 'accordion-${key.hashCode}';

    // Iterate through children and inject the state-management props into each AccordionItem.
    return Component.fragment([
      for (final child in children)
        if (child is AccordionItem<T>)
          // Use copyWith to inject the managed props into each item.
          child.copyWith(
            name: effectiveName,
            groupValue: groupValue,
            onSelect: onValueChanged,
          )
        else
          // Pass through any non-AccordionItem children as-is.
          child,
    ]);
  }
}

/// Represents a single collapsible item within an [Accordion].
///
/// This is a **controlled component** that renders a `div.collapse` structure
/// with a hidden, controlled `<input type="radio">`. Its open/closed state is
/// determined entirely by comparing its `value` to the `groupValue` provided by
/// its parent `Accordion` container.
class AccordionItem<T> extends UiComponent {
  /// Creates a single, controlled item for an Accordion.
  ///
  /// - [value]: A unique identifier of type `T` for this accordion item.
  /// - [title]: The component to be displayed in the clickable title area.
  /// - [content]: The component to be displayed in the collapsible content area.
  /// - [style]: A list of [AccordionStyling] modifiers, like `AccordionItem.arrow`.
  /// - Internal properties `groupValue`, `onSelect`, and `name` are injected by
  ///   the parent `Accordion` and should not be set manually.
  const AccordionItem({
    required this.value,
    required this.title,
    required this.content,
    // --- Injected by Accordion ---
    this.groupValue,
    this.onSelect,
    this.name,
    // --- Standard UiComponent props ---
    super.style,
    super.tag = 'div',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null); // Children are managed internally.

  /// The unique value that identifies this item within the accordion group.
  final T value;

  /// The content for the visible, clickable title bar of the accordion item.
  final Component title;

  /// The content that is shown or hidden when the item is toggled.
  final Component content;

  // --- Injected Properties ---

  /// The currently selected value for the group, injected by the parent `Accordion`.
  final T? groupValue;

  /// The callback to invoke when this item is selected, injected by the parent `Accordion`.
  final ValueChanged<T>? onSelect;

  /// The shared name for the radio input group, injected by the parent `Accordion`.
  final String? name;

  /// Computes whether this item is the currently selected one.
  bool get isChecked => value == groupValue;

  @override
  String get baseClass => 'collapse';

  @override
  AccordionItem<T> copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    // --- AccordionItem specific ---
    T? value,
    Component? title,
    Component? content,
    // --- Injected by parent ---
    T? groupValue,
    ValueChanged<T>? onSelect,
    String? name,
  }) {
    // A null `groupValue` is a valid state (nothing selected), so we can't use `??`.
    // We check if the argument was passed by checking for nullability of the argument itself.
    final effectiveGroupValue = (groupValue != null || null is T) ? groupValue : this.groupValue;

    return AccordionItem<T>(
      value: value ?? this.value,
      title: title ?? this.title,
      content: content ?? this.content,
      groupValue: effectiveGroupValue,
      onSelect: onSelect ?? this.onSelect,
      name: name ?? this.name,
      style: style,
      tag: tag,
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
        // This is now a fully controlled input, solving the Jaspr v0.21.6 issue.
        input(
          type: InputType.radio,
          name: name,
          // Jaspr bug workaround: use `true`/`null` instead of `true`/`false`.
          checked: isChecked ? true : null,
          onChange: (_) {
            // Notifies the parent to update the state.
            if (kIsWeb) {
              onSelect?.call(value);
            }
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
