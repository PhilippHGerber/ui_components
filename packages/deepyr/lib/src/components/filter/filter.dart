import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' show Event, HTMLInputElement;

import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../button/button_style.dart';
import '../join/join.dart';
import 'filter_style.dart';

/// Defines the underlying HTML structure and reset mechanism for a [Filter] component.
enum FilterMethod {
  /// Renders the `Filter` container as a `<form>` element.
  ///
  /// This method automatically includes an `<input type="reset">` button,
  /// providing a native, accessible way to clear the filter selection.
  /// This is the recommended method.
  form,

  /// Renders the `Filter` container as a `<div>` element.
  ///
  /// With this method, one of the `FilterItem`s must have `isResetItem: true`.
  /// This designated item will act as the "All" or reset option, controlled by CSS.
  div,
}

/// A "smart container" that groups `FilterItem` components to create a visually
/// connected set of filter buttons.
///
/// `Filter` is a **controlled component**. Its state must be managed by a parent
/// stateful component. The parent provides the currently selected `groupValue` and
/// an `onValueChanged` callback to handle state updates.
///
/// The component ensures its `FilterItem` children function as a single,
/// mutually exclusive radio group and automatically wraps them in a `Join` component
/// for correct visual styling.
///
/// ### Example Usage:
/// ```dart
/// class MyFilterExample extends StatefulComponent {
///   String _selectedValue = 'Svelte';
///
///   @override
///   State<MyFilterExample> createState() => _MyFilterExampleState();
/// }
///
/// class _MyFilterExampleState extends State<MyFilterExample> {
///   @override
///   Component build(BuildContext context) {
///     return Filter<String>(
///       name: 'frameworks',
///       groupValue: _selectedValue,
///       onValueChanged: (newValue) {
///         setState(() => _selectedValue = newValue);
///       },
///       [
///         FilterItem(value: 'Svelte', label: 'Svelte'),
///         FilterItem(value: 'Vue', label: 'Vue'),
///         FilterItem(value: 'React', label: 'React'),
///       ],
///     );
///   }
/// }
/// ```
class Filter<T> extends UiComponent {
  /// Creates a `Filter` container.
  ///
  /// - [children]: A list of `FilterItem<T>` components that represent the filter options.
  /// - [groupValue]: The currently selected value of type `T?` for the filter group.
  /// - [onValueChanged]: A callback that fires when the user selects a new item.
  /// - [name]: The HTML `name` attribute, which must be the same for all items in the group.
  /// - [method]: The underlying HTML structure and reset mechanism to use. Defaults to [FilterMethod.form].
  /// - [onReset]: A callback for the form's `onreset` event. This is only applicable
  ///   when `method` is [FilterMethod.form].
  /// - [style]: A list of general styling utilities to apply to the container.
  Filter(
    List<FilterItem<T>> super.children, {
    required this.groupValue,
    required this.onValueChanged,
    required this.name,
    this.method = FilterMethod.form,
    this.onReset,
    List<FilterStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : assert(children.isNotEmpty, 'Filter must have at least one FilterItem child.'),
       super(
         // Correctly pass the tag to the super constructor based on the method.
         tag: method == FilterMethod.form ? 'form' : 'div',
         style: style,
       );

  /// The currently selected value for the entire filter group.
  ///
  /// This property is nullable to represent the state where no
  /// filter is selected (e.g., after a reset).
  final T? groupValue;

  /// A callback invoked with the new value when a different `FilterItem` is selected.
  final ValueChanged<T> onValueChanged;

  /// The name for the underlying radio button group, ensuring mutual exclusion.
  final String name;

  /// The HTML structure and reset mechanism to use.
  final FilterMethod method;

  /// A callback that fires when the reset button is clicked in `FilterMethod.form`.
  final VoidCallback? onReset;

  @override
  String get baseClass => 'filter';

  @override
  Filter<T> copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
    T? groupValue,
    ValueChanged<T>? onValueChanged,
    String? name,
    FilterMethod? method,
    VoidCallback? onReset,
  }) {
    return Filter<T>(
      (children ?? []) as List<FilterItem<T>>,
      groupValue: groupValue ?? this.groupValue,
      onValueChanged: onValueChanged ?? this.onValueChanged,
      name: name ?? this.name,
      method: method ?? this.method,
      onReset: onReset ?? this.onReset,
      style: style as List<FilterStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    final effectiveChildren = <Component>[];

    // If using the form method, prepend the native reset button.
    if (method == FilterMethod.form) {
      effectiveChildren.add(
        input(
          type: InputType.reset,
          value: '×',
          // The Join component will automatically add `join-item`.
          classes: 'btn btn-square',
        ),
      );
    }

    // Inject the necessary props into each FilterItem child.
    if (children != null) {
      for (final child in children!) {
        final item = child as FilterItem<T>;
        effectiveChildren.add(
          item.copyWith(
            name: name,
            groupValue: groupValue,
            onSelect: onValueChanged,
          ),
        );
      }
    }

    // Add the onReset event handler if applicable.
    final eventMap = Map<String, EventCallback>.from(this.events);
    if (method == FilterMethod.form && onReset != null) {
      eventMap['reset'] = (_) => onReset!();
    }

    return Component.element(
      tag: tag, // The tag is correctly set by the constructor.
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: eventMap.isNotEmpty ? eventMap : null,
      // The `Join` component visually groups the filter items.
      // Its "smart" logic will apply `join-item` to all direct `UiComponent` children.
      children: [Join(effectiveChildren)],
    );
  }
}

/// Represents a single selectable option within a [Filter] container.
///
/// It renders as an `<input type="radio">` but is styled to look like a `Button`.
/// This is a controlled component whose state is managed by its parent `Filter`.
class FilterItem<T> extends UiComponent {
  /// Creates a single filter option.
  ///
  /// - [value]: The unique value of type `T` that this item represents.
  /// - [label]: The text to be displayed on the button, which is set as the `aria-label`.
  /// - [style]: A list of `ButtonStyling` utilities to customize its appearance
  ///   (e.g., `Button.primary`, `Button.sm`).
  /// - [isResetItem]: If `true` and the parent `Filter` uses `FilterMethod.div`,
  ///   this item will act as the "All" or reset option.
  /// - The `name`, `groupValue`, and `onSelect` properties are typically injected
  ///   by the parent `Filter` container and should not be set manually.
  const FilterItem({
    required this.value,
    required this.label,
    List<ButtonStyling>? style,
    this.isResetItem = false,
    // Props injected by the parent `Filter` container.
    this.name,
    this.groupValue,
    this.onSelect,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(null, tag: 'input', style: style);

  /// The unique value this radio button represents within its group.
  final T value;

  /// The visible text label for the button.
  final String label;

  /// If `true`, this item will be styled as the reset option when used in a
  /// `Filter` with `method: FilterMethod.div`.
  final bool isResetItem;

  // --- Injected Properties ---

  /// The name for the radio button group, injected by the parent `Filter`.
  final String? name;

  /// The currently selected value for the group, injected by the parent `Filter`.
  final T? groupValue;

  /// The callback to invoke when this item is selected, injected by the parent `Filter`.
  final ValueChanged<T>? onSelect;

  /// Internally computed checked state.
  bool get isChecked => value == groupValue;

  @override
  String get baseClass => 'btn';

  @override
  String get combinedClasses {
    var classes = super.combinedClasses;
    if (isResetItem) {
      classes = '$classes filter-reset';
    }
    return classes;
  }

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    attributes
      ..add('type', 'radio')
      ..add('aria-label', label);
    if (name != null) {
      attributes.add('name', name!);
    }
    if (isChecked) {
      attributes.add('checked', '');
    }
  }

  @override
  FilterItem<T> copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
    // Additional properties for injection
    String? name,
    T? groupValue,
    ValueChanged<T>? onSelect,
  }) {
    return FilterItem<T>(
      value: value,
      label: label,
      style: style as List<ButtonStyling>?,
      isResetItem: isResetItem,
      name: name ?? this.name,
      groupValue: groupValue ?? this.groupValue,
      onSelect: onSelect ?? this.onSelect,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    final eventMap = Map<String, EventCallback>.from(this.events);

    // The 'change' event fires when a radio button is selected.
    if (onSelect != null) {
      eventMap['change'] = (dynamic event) {
        if (kIsWeb) {
          final target = (event as Event).target! as HTMLInputElement;
          if (target.checked) {
            onSelect!(value);
          }
        }
      };
    }

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: eventMap.isNotEmpty ? eventMap : null,
    );
  }
}
