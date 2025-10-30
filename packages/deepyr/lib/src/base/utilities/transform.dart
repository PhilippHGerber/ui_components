import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// A utility class for applying CSS transform properties.
class Transform extends CommonStyle<Transform> {
  const Transform(super.cssClass, {super.modifiers}) : super(type: StyleType.transform);

  // --- Rotate ---
  /// Creates a `rotate-{value}` or `-rotate-{value}` utility.
  factory Transform.rotate(int value, {bool negative = false}) =>
      Transform('${negative ? '-rotate-' : 'rotate-'}$value');

  @override
  Transform create(List<PrefixModifier> modifiers) {
    return Transform(cssClass, modifiers: modifiers);
  }

  // --- Base Transform ---
  /// `transform: ...;` (Enables transforms)
  static const Transform transform = Transform('transform');

  /// `transform: none;`
  static const Transform none = Transform('transform-none');

  // --- Transform Origin ---
  /// `transform-origin: center;`
  static const Transform originCenter = Transform('origin-center');

  /// `transform-origin: top;`
  static const Transform originTop = Transform('origin-top');

  /// `transform-origin: top right;`
  static const Transform originTopRight = Transform('origin-top-right');

  /// `transform-origin: right;`
  static const Transform originRight = Transform('origin-right');

  /// `transform-origin: bottom right;`
  static const Transform originBottomRight = Transform('origin-bottom-right');

  /// `transform-origin: bottom;`
  static const Transform originBottom = Transform('origin-bottom');

  /// `transform-origin: bottom left;`
  static const Transform originBottomLeft = Transform('origin-bottom-left');

  /// `transform-origin: left;`
  static const Transform originLeft = Transform('origin-left');

  /// `transform-origin: top left;`
  static const Transform originTopLeft = Transform('origin-top-left');

  // --- Scale ---
  /// `scale: 0;`
  static const Transform scale0 = Transform('scale-0');

  /// `scale: 0.5;`
  static const Transform scale50 = Transform('scale-50');

  /// `scale: 0.75;`
  static const Transform scale75 = Transform('scale-75');

  /// `scale: 0.9;`
  static const Transform scale90 = Transform('scale-90');

  /// `scale: 0.95;`
  static const Transform scale95 = Transform('scale-95');

  /// `scale: 1;`
  static const Transform scale100 = Transform('scale-100');

  /// `scale: 1.05;`
  static const Transform scale105 = Transform('scale-105');

  /// `scale: 1.1;`
  static const Transform scale110 = Transform('scale-110');

  /// `scale: 1.25;`
  static const Transform scale125 = Transform('scale-125');

  /// `scale: 1.5;`
  static const Transform scale150 = Transform('scale-150');

  /// `rotate: 0deg;`
  static const Transform rotate0 = Transform('rotate-0');

  /// `rotate: 1deg;`
  static const Transform rotate1 = Transform('rotate-1');

  /// `rotate: 2deg;`
  static const Transform rotate2 = Transform('rotate-2');

  /// `rotate: 3deg;`
  static const Transform rotate3 = Transform('rotate-3');

  /// `rotate: 6deg;`
  static const Transform rotate6 = Transform('rotate-6');

  /// `rotate: 12deg;`
  static const Transform rotate12 = Transform('rotate-12');

  /// `rotate: 45deg;`
  static const Transform rotate45 = Transform('rotate-45');

  /// `rotate: 90deg;`
  static const Transform rotate90 = Transform('rotate-90');

  /// `rotate: 180deg;`
  static const Transform rotate180 = Transform('rotate-180');

  /// `-rotate-180`
  static final Transform rotateNeg180 = Transform.rotate(180, negative: true);

  // --- Translate ---
  // (Partial implementation for brevity, can be expanded with the full rem/fraction scale)
  /// `translate-x: -50%;`
  static const Transform translateXHalfNeg = Transform('-translate-x-1/2');

  /// `translate-x: 50%;`
  static const Transform translateXHalf = Transform('translate-x-1/2');

  /// `translate-y: -50%;`
  static const Transform translateYHalfNeg = Transform('-translate-y-1/2');

  /// `translate-y: 50%;`
  static const Transform translateYHalf = Transform('translate-y-1/2');

  // --- Skew ---
  /// `skew-x: 0deg;`
  static const Transform skewX0 = Transform('skew-x-0');

  /// `skew-x: 1deg;`
  static const Transform skewX1 = Transform('skew-x-1');

  /// `skew-x: 2deg;`
  static const Transform skewX2 = Transform('skew-x-2');

  /// `skew-x: 3deg;`
  static const Transform skewX3 = Transform('skew-x-3');

  /// `skew-x: 6deg;`
  static const Transform skewX6 = Transform('skew-x-6');

  /// `skew-x: 12deg;`
  static const Transform skewX12 = Transform('skew-x-12');

  /// `skew-y: 0deg;`
  static const Transform skewY0 = Transform('skew-y-0');

  /// `skew-y: 1deg;`
  static const Transform skewY1 = Transform('skew-y-1');

  /// `skew-y: 2deg;`
  static const Transform skewY2 = Transform('skew-y-2');

  /// `skew-y: 3deg;`
  static const Transform skewY3 = Transform('skew-y-3');

  /// `skew-y: 6deg;`
  static const Transform skewY6 = Transform('skew-y-6');

  /// `skew-y: 12deg;`
  static const Transform skewY12 = Transform('skew-y-12');
}
