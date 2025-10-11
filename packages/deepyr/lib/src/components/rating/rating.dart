import 'package:jaspr/jaspr.dart'
    show
        BuildContext,
        Component,
        Key,
        Styles,
        ValueChanged,
        div,
        kIsWeb;
import 'package:universal_web/web.dart' show Event, HTMLInputElement;

import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/styling_extensions.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../mask/mask_style.dart'; // Import to check for MaskStyling
import 'rating_style.dart';

/// A single, stylable item within a `RatingContainer`, rendering an `<input type="radio">`.
///
/// This is a low-level building block that gives you per-item control over styling.
/// It is designed to be used as a direct child of `RatingContainer`, which
/// automatically injects the required `name` attribute for the radio group.
class RatingItem extends UiComponent {
  /// Creates a single, stylable rating item.
  ///
  /// - [value]: The numerical value this item represents (e.g., 1, 1.5, 2).
  /// - [style]: A list of `Styling` utilities for this specific item,
  ///   including a `MaskStyling` for the shape and a `BgUtil` for the color.
  /// - [isChecked]: Whether this item is the currently selected one.
  /// - [onSelect]: A callback invoked when this item is selected.
  /// - [name]: The radio group name. This is typically injected by `RatingContainer`.
  /// - [isHalf]: For half-star items, specifies which half ('first' or 'second').
  const RatingItem({
    required this.value,
    this.isChecked = false,
    this.onSelect,
    this.name,
    this.isHalf,
    List<Styling>? style,
    super.id,
    super.classes,
    super.key,
  }) : super(null, tag: 'input', style: style);

  final num value;
  final bool isChecked;
  final ValueChanged<num>? onSelect;
  final String? name;
  final String? isHalf; // Can be 'first' or 'second'

  @override
  String get baseClass =>
      // Intelligently add the base 'mask' class if any mask shape is used.
      (style?.any((s) => s is MaskStyling) ?? false) ? 'mask' : '';

  @override
  String get combinedClasses {
    final base = super.combinedClasses;
    if (isHalf == 'first') return '$base mask-half-1';
    if (isHalf == 'second') return '$base mask-half-2';
    return base;
  }

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    attributes
      ..add('type', 'radio')
      ..add('value', value.toString())
      ..addAria('label', '$value stars');
    if (name != null) attributes.add('name', name!);
    if (isChecked) attributes.add('checked', '');
  }

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      events: onSelect != null
          ? {
              'change': (dynamic rawEvent) {
                if (kIsWeb) {
                  final target = (rawEvent as Event).target! as HTMLInputElement;
                  final selectedValue = num.tryParse(target.value);
                  if (selectedValue != null) onSelect!(selectedValue);
                }
              },
            }
          : events,
    );
  }

  @override
  RatingItem copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
    num? value,
    bool? isChecked,
    ValueChanged<num>? onSelect,
    String? name,
    String? isHalf,
  }) {
    return RatingItem(
      value: value ?? this.value,
      isChecked: isChecked ?? this.isChecked,
      onSelect: onSelect ?? this.onSelect,
      name: name ?? this.name,
      isHalf: isHalf ?? this.isHalf,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      key: key ?? this.key,
    );
  }
}

/// A "smart" container for `RatingItem` components that renders `<div class="rating">`.
///
/// Its primary role is to group `RatingItem`s and ensure they all share the same
/// `name` attribute, making them function as a single, mutually exclusive radio group.
/// This is the recommended component for building custom or multi-colored ratings.
///
/// ### Example (Multi-Colored Rating):
/// ```dart
/// RatingContainer(
///   name: 'custom-rating',
///   [
///     RatingItem(value: 1, isChecked: _val==1, onSelect: _handleSelect, style: [Mask.heart, BgUtil.red]),
///     RatingItem(value: 2, isChecked: _val==2, onSelect: _handleSelect, style: [Mask.heart, BgUtil.orange]),
///     // ... and so on
///   ],
/// )
/// ```
class RatingContainer extends UiComponent {
  /// Creates a container for `RatingItem`s.
  ///
  /// - [name]: **Required.** The unique name for the radio button group.
  /// - [children]: The list of components, which should include `RatingItem`s.
  /// - [style]: Styles for the container, like `Rating.lg` or `Rating.half`.
  const RatingContainer(
    super.children, {
    required this.name,
    List<RatingStyling>? style,
    super.id,
    super.classes,
    super.key,
    super.attributes,
  }) : super(tag: 'div', style: style);

  final String name;

  @override
  String get baseClass => 'rating';

  @override
  Component build(BuildContext context) {
    // Inject the `name` into all direct RatingItem children.
    final processedChildren = children?.map((child) {
      if (child is RatingItem) {
        return child.copyWith(name: name);
      }
      return child;
    }).toList();

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      children: processedChildren,
    );
  }

  @override
  RatingContainer copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
    String? name,
  }) {
    return RatingContainer(
      children ?? [],
      name: name ?? this.name,
      style: style as List<RatingStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      key: key ?? this.key,
    );
  }
}

// #endregion

/// A high-level, controlled component for creating a uniform rating scale.
///
/// This component provides a simple API for the most common use cases where all
/// items in the rating share the same style. It programmatically generates the
/// necessary `RatingContainer` and `RatingItem`s internally.
///
/// For advanced use cases, like applying a different color to each star, use the
/// more flexible `RatingContainer` and `RatingItem` components directly.
class Rating extends UiComponent {
  /// Creates a high-level, uniform Rating component.
  ///
  /// - [name]: A unique name for the underlying radio button group. **Required**
  ///   for interactive mode.
  /// - [value]: The current rating value. Defaults to `0`.
  /// - [onValueChanged]: A callback that fires when the user selects a new rating.
  /// - [max]: The total number of stars to display. Defaults to `5`.
  /// - [isReadOnly]: If `true`, renders a non-interactive display. Defaults to `false`.
  /// - [allowHalf]: If `true`, enables half-star selection and rendering.
  /// - [allowClear]: If `true` (and interactive), allows the user to clear their rating.
  /// - [style]: Styles for the container (e.g., `Rating.lg`).
  /// - [itemStyle]: A list of `Styling` utilities (e.g., `Mask.star2`, `BgUtil.warning`)
  ///   applied uniformly to every item. The component will automatically add the
  ///   base `mask` class if a `MaskStyling` is provided.
  /// - [groupAriaLabel]: An accessible label for the entire rating group.
  const Rating({
    this.name,
    this.value = 0,
    this.onValueChanged,
    this.max = 5,
    this.isReadOnly = false,
    this.allowHalf = false,
    this.allowClear = false,
    this.groupAriaLabel,
    List<RatingStyling>? style,
    this.itemStyle,
    super.tag = 'div',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : assert(
         isReadOnly || name != null,
         'A unique `name` is required for an interactive Rating component (when `isReadOnly` is false).',
       ),
       super(null, style: style);

  /// A unique `name` attribute for the internal radio button group.
  /// Required for interactive ratings to function correctly.
  final String? name;

  /// The current rating value. Can be an `int` or `double`.
  final num value;

  /// Callback function invoked when the user selects a new rating.
  final ValueChanged<num>? onValueChanged;

  /// The maximum number of stars in the rating.
  final int max;

  /// If `true`, the component will render as a non-interactive `div` structure.
  final bool isReadOnly;

  /// If `true`, enables half-star selection logic.
  final bool allowHalf;

  /// If `true` and in interactive mode, allows the user to clear the current rating.
  final bool allowClear;

  /// An accessible label for the entire rating group, announced by screen readers.
  final String? groupAriaLabel;

  /// A list of styles to apply to each individual star (radio input or div).
  /// This is where you define the mask shape and color.
  /// Example: `[Mask.heart, BgUtil.error]`
  final List<Styling>? itemStyle;

  @override
  String get baseClass => ''; // Base class is handled by RatingContainer

  @override
  Component build(BuildContext context) {
    // Safely cast the inherited `style` property from `List<Styling>?`
    // to the more specific `List<RatingStyling>?` that the constructor guarantees.
    final typedContainerStyle = style as List<RatingStyling>?;

    // Automatically add Rating.half to the container styles if allowHalf is true.
    final effectiveContainerStyles = typedContainerStyle?.toList() ?? [];
    if (allowHalf && !effectiveContainerStyles.contains(Rating.half)) {
      effectiveContainerStyles.add(Rating.half);
    }

    if (isReadOnly) {
      final items = <Component>[];
      for (var i = 1; i <= max; i++) {
        if (allowHalf) {
          items.add(_buildReadOnlyDiv(i - 0.5));
          items.add(_buildReadOnlyDiv(i));
        } else {
          items.add(_buildReadOnlyDiv(i));
        }
      }
      return RatingContainer(
        items,
        name: name ?? '', // Name can be empty for read-only but is required by container
        style: effectiveContainerStyles,
        key: key,
        id: id,
        classes: classes,
        // Pass accessibility attributes to the container
        attributes: {'role': 'img', if (groupAriaLabel != null) 'aria-label': groupAriaLabel!},
      );
    }

    // Interactive Mode
    final items = <Component>[];
    if (allowClear) {
      items.add(
        RatingItem(
          value: 0,
          isChecked: value == 0,
          onSelect: onValueChanged,
          classes: 'rating-hidden',
        ),
      );
    }
    for (var i = 1; i <= max; i++) {
      if (allowHalf) {
        items.add(
          RatingItem(
            value: i - 0.5,
            isChecked: value == i - 0.5,
            onSelect: onValueChanged,
            style: itemStyle,
            isHalf: 'first',
          ),
        );
        items.add(
          RatingItem(
            value: i,
            isChecked: value == i,
            onSelect: onValueChanged,
            style: itemStyle,
            isHalf: 'second',
          ),
        );
      } else {
        items.add(
          RatingItem(
            value: i,
            isChecked: value == i,
            onSelect: onValueChanged,
            style: itemStyle,
          ),
        );
      }
    }

    return RatingContainer(
      items,
      name: name!,
      style: effectiveContainerStyles,
      key: key,
      id: id,
      classes: classes,
      // Pass accessibility attributes to the container
      attributes: {'role': 'radiogroup', if (groupAriaLabel != null) 'aria-label': groupAriaLabel!},
    );
  }

  // Helper for read-only div generation
  Component _buildReadOnlyDiv(num itemValue) {
    final isMasked = itemStyle?.any((s) => s is MaskStyling) ?? false;
    final itemClasses = isMasked ? 'mask ${itemStyle!.toClasses()}' : itemStyle?.toClasses() ?? '';

    final halfClass = allowHalf
        ? (itemValue.toString().endsWith('.5') ? 'mask-half-1' : 'mask-half-2')
        : '';

    return div(
      [],
      classes: '$itemClasses $halfClass',
      attributes: {
        'aria-label': '$itemValue stars',
        if (value >= itemValue) 'aria-current': 'true',
      },
      // For read-only, we must manually control the visibility/color.
      // We apply the item styles only if the value is met.
      // If not selected, we apply a transparent background to maintain the shape.
      styles: value >= itemValue
          ? css
          : const Styles(raw: {'background-color': 'var(--fallback-b2,oklch(var(--b2)/.2))'}),
    );
  }

  @override
  Rating copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
    String? name,
    num? value,
    ValueChanged<num>? onValueChanged,
    int? max,
    bool? isReadOnly,
    bool? allowHalf,
    bool? allowClear,
    String? groupAriaLabel,
    List<Styling>? itemStyle,
  }) {
    return Rating(
      name: name ?? this.name,
      value: value ?? this.value,
      onValueChanged: onValueChanged ?? this.onValueChanged,
      max: max ?? this.max,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      allowHalf: allowHalf ?? this.allowHalf,
      allowClear: allowClear ?? this.allowClear,
      groupAriaLabel: groupAriaLabel ?? this.groupAriaLabel,
      style: style as List<RatingStyling>?,
      itemStyle: itemStyle ?? this.itemStyle,
      tag: tag,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }
  // --- Static Style Modifiers (for the container) ---

  /// Renders half stars. This is automatically applied if `allowHalf: true`,
  /// but can also be added manually for consistency.
  static const RatingStyle half = RatingStyle('rating-half', type: StyleType.additional);

  /// Extra small size for the rating container. `rating-xs`
  static const RatingStyle xs = RatingStyle('rating-xs', type: StyleType.sizing);

  /// Small size for the rating container. `rating-sm`
  static const RatingStyle sm = RatingStyle('rating-sm', type: StyleType.sizing);

  /// Medium size for the rating container (default). `rating-md`
  static const RatingStyle md = RatingStyle('rating-md', type: StyleType.sizing);

  /// Large size for the rating container. `rating-lg`
  static const RatingStyle lg = RatingStyle('rating-lg', type: StyleType.sizing);

  /// Extra large size for the rating container. `rating-xl`
  static const RatingStyle xl = RatingStyle('rating-xl', type: StyleType.sizing);
}
