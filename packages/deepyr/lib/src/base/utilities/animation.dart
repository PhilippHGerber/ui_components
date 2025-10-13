import '../common_style.dart';
import '../style_type.dart';
import '../styling.dart';
import '../ui_prefix_modifier.dart';

/// A marker interface for any utility that can be passed to a component's `style` list.
abstract class AnimationStyling implements Styling {}

/// A utility class for applying animation styles.
class Animation extends CommonStyle<Animation> implements AnimationStyling {
  const Animation(super.cssClass, {super.modifiers}) : super(type: StyleType.animation);

  @override
  Animation create(List<PrefixModifier> modifiers) {
    return Animation(cssClass, modifiers: modifiers);
  }

  /// `animate-none`
  static const Animation none = Animation('animate-none');

  /// `animate-spin`
  static const Animation spin = Animation('animate-spin');

  /// `animate-ping`
  static const Animation ping = Animation('animate-ping');

  /// `animate-pulse`
  static const Animation pulse = Animation('animate-pulse');

  /// `animate-bounce`
  static const Animation bounce = Animation('animate-bounce');
}
