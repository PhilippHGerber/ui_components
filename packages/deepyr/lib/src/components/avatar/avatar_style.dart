import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'avatar.dart';

/// A marker interface for any utility that can be passed to an [Avatar]'s
/// `style` list.
///
/// This allows for type-safe application of styles, ensuring only relevant
/// modifiers like presence indicators can be applied.
abstract class AvatarStyling implements Styling {}

/// Defines specific styling options for an [Avatar] component, such as its
/// online or offline status.
///
/// This is the concrete implementation class for avatar-specific modifiers. It
/// implements the [AvatarStyling] interface, making it a valid type for the
/// `style` property of an [Avatar] component.
class AvatarStyle extends ComponentStyle<AvatarStyle>
    with Breakpoints<AvatarStyle>
    implements AvatarStyling {
  /// Constructs an [AvatarStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "avatar-online").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const AvatarStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [AvatarStyle] with the provided modifiers.
  @override
  AvatarStyle create(List<PrefixModifier> modifiers) {
    return AvatarStyle(cssClass, type: type, modifiers: modifiers);
  }
}
