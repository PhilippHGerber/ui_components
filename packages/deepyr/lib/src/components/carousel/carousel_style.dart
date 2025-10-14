import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'carousel.dart';

/// A marker interface for any utility that can be passed to a [Carousel]'s `style` list.
///
/// This allows for type-safe application of styles for alignment and direction.
/// Both component-specific styles (like [CarouselStyle]) and applicable general
/// utilities can implement this interface.
abstract class CarouselStyling implements Styling {}

/// Defines specific styling options for a [Carousel] container component, such as
/// its alignment and orientation.
///
/// This is the concrete implementation class for carousel-specific modifiers. It
/// implements the [CarouselStyling] interface, making it a valid type for the
/// `style` property of a [Carousel] component.
class CarouselStyle extends ComponentStyle<CarouselStyle>
    with Breakpoints<CarouselStyle>
    implements CarouselStyling {
  /// Constructs a [CarouselStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "carousel-center").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const CarouselStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [CarouselStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  CarouselStyle create(List<PrefixModifier> modifiers) {
    return CarouselStyle(cssClass, type: type, modifiers: modifiers);
  }
}
