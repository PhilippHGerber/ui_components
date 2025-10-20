import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'mask_style.dart';

/// A component that crops its content to a specific shape.
///
/// It acts as a wrapper and applies a CSS mask to its children (e.g., an `img`).
/// The shape is determined by the `style` property, which accepts type-safe
/// `MaskStyling` modifiers like `Mask.squircle` or `Mask.heart`.
///
/// Example Usage:
/// ```dart
/// Mask(
///   [
///     img(src: 'path/to/image.jpg', alt: 'A masked image')
///   ],
///   style: [Mask.heart, Size.w(40), Size.h(40)],
/// )
/// ```
class Mask extends UiComponent {
  /// Creates a Mask component.
  ///
  /// - [children] or [child]: The content to be masked (e.g., an `img` or `div`).
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [MaskStyling] instances to define the shape and behavior.
  /// - Other parameters are inherited from [UiComponent].
  const Mask(
    super.children, {
    super.tag = 'div',
    List<MaskStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'mask';

  @override
  Mask copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Mask(
      children,
      tag: tag,
      style: style as List<MaskStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Applies a squircle shape. `mask-squircle`
  static const MaskStyle squircle = MaskStyle('mask-squircle', type: StyleType.style);

  /// Applies a heart shape. `mask-heart`
  static const MaskStyle heart = MaskStyle('mask-heart', type: StyleType.style);

  /// Applies a vertical hexagon shape. `mask-hexagon`
  static const MaskStyle hexagon = MaskStyle('mask-hexagon', type: StyleType.style);

  /// Applies a horizontal hexagon shape. `mask-hexagon-2`
  static const MaskStyle hexagon2 = MaskStyle('mask-hexagon-2', type: StyleType.style);

  /// Applies a decagon shape. `mask-decagon`
  static const MaskStyle decagon = MaskStyle('mask-decagon', type: StyleType.style);

  /// Applies a pentagon shape. `mask-pentagon`
  static const MaskStyle pentagon = MaskStyle('mask-pentagon', type: StyleType.style);

  /// Applies a diamond shape. `mask-diamond`
  static const MaskStyle diamond = MaskStyle('mask-diamond', type: StyleType.style);

  /// Applies a square shape. `mask-square`
  static const MaskStyle square = MaskStyle('mask-square', type: StyleType.style);

  /// Applies a circle shape. `mask-circle`
  static const MaskStyle circle = MaskStyle('mask-circle', type: StyleType.style);

  /// Applies a star shape. `mask-star`
  static const MaskStyle star = MaskStyle('mask-star', type: StyleType.style);

  /// Applies a bold star shape. `mask-star-2`
  static const MaskStyle star2 = MaskStyle('mask-star-2', type: StyleType.style);

  /// Applies a triangle shape pointing top. `mask-triangle`
  static const MaskStyle triangle = MaskStyle('mask-triangle', type: StyleType.style);

  /// Applies a triangle shape pointing down. `mask-triangle-2`
  static const MaskStyle triangle2 = MaskStyle('mask-triangle-2', type: StyleType.style);

  /// Applies a triangle shape pointing left. `mask-triangle-3`
  static const MaskStyle triangle3 = MaskStyle('mask-triangle-3', type: StyleType.style);

  /// Applies a triangle shape pointing right. `mask-triangle-4`
  static const MaskStyle triangle4 = MaskStyle('mask-triangle-4', type: StyleType.style);

  /// Crops only the first half of the mask. `mask-half-1`
  static const MaskStyle half1 = MaskStyle('mask-half-1', type: StyleType.additional);

  /// Crops only the second half of the mask. `mask-half-2`
  static const MaskStyle half2 = MaskStyle('mask-half-2', type: StyleType.additional);
}
