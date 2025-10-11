import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'rating.dart';

/// A marker interface for any utility that can be passed to a [Rating]'s `style` list.
///
/// This allows for type-safe application of styles for size and behavior (like half-stars)
/// to the main rating container.
abstract class RatingStyling implements Styling {}

/// Defines specific styling options for a [Rating] container component.
///
/// This is the concrete implementation class for rating-specific modifiers.
/// It implements the [RatingStyling] interface, making it a valid type for the
/// `style` property of a [Rating] component.
class RatingStyle extends ComponentStyle<RatingStyle>
    with Breakpoints<RatingStyle>
    implements RatingStyling {
  /// Constructs a [RatingStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "rating-lg").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const RatingStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [RatingStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  RatingStyle create(List<PrefixModifier> modifiers) {
    return RatingStyle(cssClass, type: type, modifiers: modifiers);
  }
}
