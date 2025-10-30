import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// A utility class for applying CSS transition and animation properties.
class Transition extends CommonStyle<Transition> {
  const Transition(super.cssClass, {super.modifiers}) : super(type: StyleType.animation);

  @override
  Transition create(List<PrefixModifier> modifiers) {
    return Transition(cssClass, modifiers: modifiers);
  }

  // --- Transition Property ---
  /// `transition-property: none;`
  static const Transition none = Transition('transition-none');

  /// `transition-property: all;`
  static const Transition all = Transition('transition');

  /// `transition-property: color, background-color, border-color, text-decoration-color, fill, stroke;`
  static const Transition colors = Transition('transition-colors');

  /// `transition-property: opacity;`
  static const Transition opacity = Transition('transition-opacity');

  /// `transition-property: box-shadow, filter, backdrop-filter;`
  static const Transition shadow = Transition('transition-shadow');

  /// `transition-property: transform;`
  static const Transition transform = Transition('transition-transform');

  // --- Transition Duration ---
  /// `transition-duration: 75ms;`
  static const Transition duration75 = Transition('duration-75');

  /// `transition-duration: 100ms;`
  static const Transition duration100 = Transition('duration-100');

  /// `transition-duration: 150ms;`
  static const Transition duration150 = Transition('duration-150');

  /// `transition-duration: 200ms;`
  static const Transition duration200 = Transition('duration-200');

  /// `transition-duration: 300ms;`
  static const Transition duration300 = Transition('duration-300');

  /// `transition-duration: 500ms;`
  static const Transition duration500 = Transition('duration-500');

  /// `transition-duration: 700ms;`
  static const Transition duration700 = Transition('duration-700');

  /// `transition-duration: 1000ms;`
  static const Transition duration1000 = Transition('duration-1000');

  // --- Transition Timing Function (Easing) ---
  /// `transition-timing-function: linear;`
  static const Transition easeLinear = Transition('ease-linear');

  /// `transition-timing-function: cubic-bezier(0.4, 0, 1, 1);`
  static const Transition easeIn = Transition('ease-in');

  /// `transition-timing-function: cubic-bezier(0, 0, 0.2, 1);`
  static const Transition easeOut = Transition('ease-out');

  /// `transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);`
  static const Transition easeInOut = Transition('ease-in-out');

  // --- Transition Delay ---
  /// `transition-delay: 75ms;`
  static const Transition delay75 = Transition('delay-75');

  /// `transition-delay: 100ms;`
  static const Transition delay100 = Transition('delay-100');

  /// `transition-delay: 150ms;`
  static const Transition delay150 = Transition('delay-150');

  /// `transition-delay: 200ms;`
  static const Transition delay200 = Transition('delay-200');

  /// `transition-delay: 300ms;`
  static const Transition delay300 = Transition('delay-300');

  /// `transition-delay: 500ms;`
  static const Transition delay500 = Transition('delay-500');

  /// `transition-delay: 700ms;`
  static const Transition delay700 = Transition('delay-700');

  /// `transition-delay: 1000ms;`
  static const Transition delay1000 = Transition('delay-1000');
}
