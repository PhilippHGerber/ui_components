import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart' show Breakpoints, PrefixModifier;
import 'badge.dart';

/// Marker interface for any utility that can be passed to a [Badge]'s `styles` list.
abstract class BadgeStyling implements Styling {}

/// Represents component-specific utility classes that can be applied to a [Badge] component.
///
/// These modifiers control the appearance of the badge, such as its color,
/// style (e.g., outline), and size.
class BadgeStyle extends ComponentStyle<BadgeStyle>
    with Breakpoints<BadgeStyle>
    implements BadgeStyling {
  /// Constructs a [BadgeStyling].
  ///
  /// [cssClass]: The core CSS class string for this modifier (e.g., "badge-primary").
  /// [type]: The [StyleType] categorizing this modifier.
  /// [modifiers]: An optional list of [PrefixModifier]s already applied to this modifier.
  const BadgeStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  BadgeStyle create(List<PrefixModifier> modifiers) {
    return BadgeStyle(cssClass, type: type, modifiers: modifiers);
  }
}
