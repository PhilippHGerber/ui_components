import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'hero.dart';

/// A marker interface for any utility that can be passed to a [Hero]'s
/// `style` list.
///
/// This allows for type-safe application of styles. `Hero` has no specific
/// modifiers of its own; this interface is used to allow general utilities
/// (like `BgUtil`, `Size`, etc.) to be applied to it.
abstract class HeroStyling implements Styling {}

/// Defines specific styling options for a [Hero] component.
///
/// This is the concrete implementation class for hero-specific modifiers.
/// It implements the [HeroStyling] interface. Currently, there are no
/// predefined static modifiers for `Hero`, as its styling is compositional,
/// but this class provides a consistent and extensible structure.
class HeroStyle extends ComponentStyle<HeroStyle>
    with Breakpoints<HeroStyle>
    implements HeroStyling {
  /// Constructs a [HeroStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier.
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const HeroStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [HeroStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  HeroStyle create(List<PrefixModifier> modifiers) {
    return HeroStyle(cssClass, type: type, modifiers: modifiers);
  }
}
