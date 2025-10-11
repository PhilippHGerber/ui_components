import 'package:jaspr/jaspr.dart'
    show
        BuildContext,
        Component,
        EventCallback,
        InputType,
        Key,
        Styles,
        ValueChanged,
        div,
        input,
        kIsWeb;
import 'package:universal_web/web.dart' show Event, HTMLInputElement;

import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/styling_extensions.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../mask/mask_style.dart'; // Import to check for MaskStyling
import 'rating_style.dart';

/// An interactive or read-only component for capturing and displaying user ratings.
///
/// This component can function in two modes, controlled by the `isReadOnly` property:
///
/// 1.  **Interactive (default):** Renders a group of styled radio inputs. It is a
///     **controlled component**, meaning its state must be managed by a parent.
///     You must provide the current `value` and handle state changes via the
///     `onValueChanged` callback.
///
/// 2.  **Read-Only:** Renders a series of `<div>` elements to visually represent a
///     rating without allowing user interaction. This is useful for displaying
///     existing scores.
///
/// It intelligently generates the necessary HTML structure for full-star, half-star,
/// and clearable ratings based on its properties.
///
/// ### Interactive Example:
/// ```dart
/// class MyReviewForm extends StatefulComponent {
///   double _currentRating = 2.5;
///
///   @override
///   State<MyReviewForm> createState() => _MyReviewFormState();
/// }
///
/// class _MyReviewFormState extends State<MyReviewForm> {
///   @override
///   Component build(BuildContext context) {
///     return Rating(
///       name: 'review-rating', // A unique name is required for interactive mode
///       value: _currentRating,
///       onValueChanged: (newValue) {
///         setState(() => _currentRating = newValue);
///       },
///       allowHalf: true,
///       style: [Rating.lg],
///       itemStyle: [Mask.star2, BgUtil.warning],
///     );
///   }
/// }
/// ```
class Rating extends UiComponent {
  /// Creates a Rating component.
  ///
  /// - [name]: A unique name for the underlying radio button group. **Required**
  ///   for interactive mode (`isReadOnly: false`).
  /// - [value]: The current rating value. Defaults to `0`.
  /// - [onValueChanged]: A callback that fires when the user selects a new rating
  ///   in interactive mode.
  /// - [max]: The total number of shapes to display. Defaults to `5`.
  /// - [isReadOnly]: If `true`, renders a non-interactive display. Defaults to `false`.
  /// - [allowHalf]: If `true`, enables half-star selection and rendering.
  /// - [allowClear]: If `true` (and in interactive mode), allows the user to
  ///   clear their rating by clicking the already selected star.
  /// - [style]: A list of [RatingStyling] instances for the container (e.g., `Rating.lg`).
  /// - [itemStyle]: A list of `Styling` utilities (e.g., `Mask.star2`, `BgUtil.warning`)
  ///   to be applied to each individual item. The component will automatically add the
  ///   base `mask` class if a `MaskStyling` is provided.
  /// - [groupAriaLabel]: An accessible label for the entire rating group, providing
  ///   context for screen readers (e.g., "Product score").
  /// - Other parameters are inherited from [UiComponent].
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
  String get baseClass => 'rating';

  @override
  String get combinedClasses {
    // Start with the classes from the base implementation.
    final base = super.combinedClasses;
    // Ergonomic improvement: Automatically add the 'rating-half' class if allowHalf is true.
    if (allowHalf) {
      // Create a set to avoid duplicates if the user also adds it manually.
      final classesSet = base.split(' ').toSet();
      classesSet.add('rating-half');
      return classesSet.join(' ');
    }
    return base;
  }

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    if (groupAriaLabel != null) {
      // Use 'radiogroup' for interactive mode and a simple 'img' role for read-only
      // to convey that it's a graphical representation of a value.
      attributes.addRole(isReadOnly ? 'img' : 'radiogroup');
      attributes.addAria('label', groupAriaLabel!);
    }
  }

  /// This getter intelligently adds the base `mask` class if any `MaskStyling`
  /// is present in the `itemStyle` list, fixing the visibility bug.
  String get _itemClasses {
    if (itemStyle == null || itemStyle!.isEmpty) {
      return '';
    }
    // Check if any of the provided styles is a mask shape.
    final isMasked = itemStyle!.any((s) => s is MaskStyling);
    final classesString = itemStyle!.toClasses();

    // If it's a mask, prepend the base 'mask' class.
    return isMasked ? 'mask $classesString' : classesString;
  }

  @override
  Component build(BuildContext context) {
    final items = isReadOnly ? _buildReadOnlyItems() : _buildInteractiveItems();

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      events: events,
      children: items,
    );
  }

  /// Builds the list of components for an interactive rating (`<input type="radio">`).
  List<Component> _buildInteractiveItems() {
    final inputs = <Component>[];
    final resolvedItemClasses = _itemClasses;

    if (allowClear) {
      inputs.add(
        _buildRadioInput(
          value: 0,
          isChecked: value == 0,
          ariaLabel: 'clear rating',
          extraClasses: 'rating-hidden',
        ),
      );
    }

    // Generate the radio inputs for each star.
    for (var i = 1; i <= max; i++) {
      if (allowHalf) {
        // For half stars, create two inputs per star.
        final halfValue = i - 0.5;
        // First half
        inputs
          ..add(
            _buildRadioInput(
              value: halfValue,
              isChecked: value == halfValue,
              ariaLabel: '$halfValue stars',
              extraClasses: '$resolvedItemClasses mask-half-1',
            ),
          )
          // Second half
          ..add(
            _buildRadioInput(
              value: i,
              isChecked: value == i,
              ariaLabel: '$i stars',
              extraClasses: '$resolvedItemClasses mask-half-2',
            ),
          );
      } else {
        // For full stars, create one input per star.
        inputs.add(
          _buildRadioInput(
            value: i,
            isChecked: value == i,
            ariaLabel: '$i stars',
            extraClasses: resolvedItemClasses,
          ),
        );
      }
    }
    return inputs;
  }

  /// Builds the list of components for a read-only rating (`<div>`).
  List<Component> _buildReadOnlyItems() {
    final divs = <Component>[];
    final resolvedItemClasses = _itemClasses;

    for (var i = 1; i <= max; i++) {
      if (allowHalf) {
        final halfValue = i - 0.5;
        // First half
        divs
          ..add(
            _buildReadOnlyDiv(
              isSelected: value >= halfValue,
              ariaLabel: '$halfValue stars',
              extraClasses: '$resolvedItemClasses mask-half-1',
            ),
          )
          // Second half
          ..add(
            _buildReadOnlyDiv(
              isSelected: value >= i,
              ariaLabel: '$i stars',
              extraClasses: '$resolvedItemClasses mask-half-2',
            ),
          );
      } else {
        divs.add(
          _buildReadOnlyDiv(
            isSelected: value >= i,
            ariaLabel: '$i stars',
            extraClasses: resolvedItemClasses,
          ),
        );
      }
    }
    return divs;
  }

  /// A private helper method to construct a single radio input for the rating.
  Component _buildRadioInput({
    required num value,
    required bool isChecked,
    required String ariaLabel,
    String? extraClasses,
  }) {
    return input(
      type: InputType.radio,
      name: name,
      classes: extraClasses,
      attributes: {
        'value': value.toString(),
        if (isChecked) 'checked': '',
        'aria-label': ariaLabel,
      },
      events: onValueChanged != null
          ? {
              'change': (dynamic rawEvent) {
                if (kIsWeb) {
                  final target = (rawEvent as Event).target! as HTMLInputElement;
                  final selectedValue = num.tryParse(target.value);
                  if (selectedValue != null) {
                    onValueChanged!(selectedValue);
                  }
                }
              },
            }
          : null,
    );
  }

  /// A private helper method to construct a single `div` for a read-only rating.
  Component _buildReadOnlyDiv({
    required bool isSelected,
    required String ariaLabel,
    String? extraClasses,
  }) {
    // DaisyUI uses the `checked` attribute on the hidden radio to style the visible mask.
    // For read-only, we must simulate this. We can use a data-attribute that we target with CSS,
    // or rely on a different mechanism. The simplest is to ensure the background color is applied.
    // In DaisyUI, the `.rating input:checked` is what applies the color. For read-only, we must handle this.
    // Let's assume for now that the provided `itemStyle` includes a `BgUtil` color that will be applied.
    // The `aria-current` attribute is for accessibility.
    return div(
      [],
      classes: extraClasses,
      attributes: {
        'aria-label': ariaLabel,
        // Use aria-current to indicate the selected item for accessibility.
        if (isSelected) 'aria-current': 'true',
      },
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
