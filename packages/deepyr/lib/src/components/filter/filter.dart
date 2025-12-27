import 'package:jaspr/dom.dart' show InputType, Styles, input;
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' show Event, HTMLInputElement;

import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import '../button/button_style.dart';
import 'filter_style.dart';

/// Defines the underlying HTML structure and reset mechanism for a [Filter] component.
enum FilterMethod {
  /// Renders the `Filter` container as a `<form>` element.
  ///
  /// This method automatically includes a native `<input type="reset">` button
  /// at the beginning of the group, styled as a square button with an "×".
  /// This allows for native form reset behavior.
  form,

  /// Renders the `Filter` container as a `<div>` element.
  ///
  /// Use this when you cannot use a form. You should designate one of the
  /// [FilterItem]s as the reset option by setting `isResetItem: true`.
  /// This applies the `.filter-reset` style to that item, typically making it
  /// appear as the "All" or default option.
  div,
}

/// A "smart container" that groups [FilterItem] components to create a visually
/// connected set of filter buttons.
///
/// `Filter` is a **controlled component**. Its state must be managed by a parent
/// stateful component. The parent provides the currently selected [groupValue] and
/// an [onValueChanged] callback to handle state updates.
///
/// The component ensures its [FilterItem] children function as a single,
/// mutually exclusive radio group.
///
/// ### Example (Form Method):
/// ```dart
/// Filter<String>(
///   name: 'frameworks',
///   groupValue: _selectedValue,
///   onValueChanged: (val) => setState(() => _selectedValue = val),
///   onReset: () => setState(() => _selectedValue = null),
///   children: [
///     FilterItem(value: 'Svelte', label: 'Svelte'),
///     FilterItem(value: 'Vue', label: 'Vue'),
///   ],
/// )
/// ```
///
/// ### Example (Div Method):
/// ```dart
/// Filter<String>(
///   name: 'frameworks',
///   method: FilterMethod.div,
///   groupValue: _selectedValue,
///   onValueChanged: (val) => setState(() => _selectedValue = val),
///   children: [
///     // The item marked as resetItem acts as the "All" or "Clear" option
///     FilterItem(value: 'All', label: 'All', isResetItem: true),
///     FilterItem(value: 'Svelte', label: 'Svelte'),
///   ],
/// )
/// ```
class Filter<T> extends UiComponent {
  /// Creates a `Filter` container.
  ///
  /// - [children]: A list of [FilterItem<T>] components that represent the filter options.
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
    super.eventHandlers,
    super.key,
  }) : assert(children.isNotEmpty, 'Filter must have at least one FilterItem child.'),
       super(
         // Dynamically set the tag based on the selected method.
         tag: method == FilterMethod.form ? 'form' : 'div',
         style: style,
       );

  /// The currently selected value for the entire filter group.
  ///
  /// This property is nullable to represent the state where no
  /// filter is selected (e.g., after a reset in form mode).
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
    Map<String, List<UiEventHandler>>? eventHandlers,
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
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    final effectiveChildren = <Component>[];

    // 1. Automatic Reset Button (Form Method Only)
    // If using a form, we prepend a native reset input. This matches the DaisyUI spec:
    // <input class="btn btn-square" type="reset" value="×"/>
    if (method == FilterMethod.form) {
      effectiveChildren.add(
        const input(
          type: InputType.reset,
          value: '×',
          classes: 'btn btn-square',
          // No click handler needed; the form 'reset' event handles the logic.
        ),
      );
    }

    // 2. Inject State into Children
    // We iterate over the provided children to inject the group name, selected state,
    // and callback into each `FilterItem`.
    if (children != null) {
      for (final child in children!) {
        if (child is FilterItem<T>) {
          effectiveChildren.add(
            child.copyWith(
              name: name,
              groupValue: groupValue,
              onSelect: onValueChanged,
            ),
          );
        } else {
          // Pass through non-FilterItem children if any exist (unlikely but safe).
          effectiveChildren.add(child);
        }
      }
    }

    // 3. Handle Form Reset Event
    final eventMap = Map<String, EventCallback>.from(this.eventMap);
    if (method == FilterMethod.form && onReset != null) {
      eventMap['reset'] = (_) => onReset!();
    }

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      events: eventMap.isNotEmpty ? eventMap : null,
      children: effectiveChildren,
    );
  }
}

/// Represents a single selectable option within a [Filter] container.
///
/// It renders as an `<input type="radio">` with the `btn` class. DaisyUI uses the
/// `aria-label` attribute to display the text content of the button.
///
/// This is a controlled component whose state is typically managed by its parent [Filter].
class FilterItem<T> extends UiComponent {
  /// Creates a single filter option.
  ///
  /// - [value]: The unique value of type `T` that this item represents.
  /// - [label]: The visible text displayed on the button (rendered as `aria-label`).
  /// - [style]: A list of [ButtonStyling] utilities to customize its appearance
  ///   (e.g., `Button.primary`, `Button.sm`).
  /// - [isResetItem]: If `true`, applies the `filter-reset` class. This is used in
  ///   `FilterMethod.div` to style the "All" or "Clear" option. It does NOT replace
  ///   the label text with an "X"; it displays the [label] text (e.g. "All").
  /// - The `name`, `groupValue`, and `onSelect` properties are injected
  ///   by the parent `Filter` container.
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
    super.eventHandlers,
    super.key,
  }) : super(null, tag: 'input', style: style);

  /// The unique value this radio button represents.
  final T value;

  /// The visible text label for the button.
  final String label;

  /// If `true`, applies the `filter-reset` CSS class.
  /// This is a styling hook for DaisyUI.
  final bool isResetItem;

  // --- Injected Properties ---

  /// The name for the radio button group.
  final String? name;

  /// The currently selected value for the group.
  final T? groupValue;

  /// The callback to invoke when this item is selected.
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
      ..add('aria-label', label)
      ..add('value', value.toString());
    if (name != null) {
      attributes.add('name', name!);
    }
    // Note: We don't set the 'checked' attribute here.
    // We bind the DOM property directly in build() to prevent race conditions.
  }

  @override
  FilterItem<T> copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
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
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    final eventMap = Map<String, EventCallback>.from(this.eventMap);

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

    // We must explicitly bind the `checked` parameter to the Dart state using the
    // `condition ? true : null` pattern. This ensures Jaspr reconciles the DOM
    // property correctly during re-renders, forcing the visual state to match
    // the logical state (`isChecked`).
    return input(
      type: InputType.radio,
      name: name,
      classes: combinedClasses,
      id: id,
      styles: css,
      attributes: componentAttributes,
      events: eventMap,
      // The source of truth for the state.
      checked: isChecked ? true : null,
    );
  }
}
