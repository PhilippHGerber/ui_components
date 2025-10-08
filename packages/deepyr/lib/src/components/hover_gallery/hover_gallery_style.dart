import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'hover_gallery.dart';

/// A marker interface for any utility that can be passed to a [HoverGallery]'s `style` list.
///
/// `HoverGallery` has no component-specific modifiers of its own; this interface
/// is primarily used to allow general-purpose utilities (like `Size`, `Effects`,
/// and `Layout`) to be applied to the container in a type-safe manner.
abstract class HoverGalleryStyling implements Styling {}

/// Defines specific styling options for a [HoverGallery] component.
///
/// This is the concrete implementation class for hover-gallery-specific modifiers.
/// It implements the [HoverGalleryStyling] interface, making it a valid type for the
/// `style` property of a [HoverGallery] component.
///
/// Currently, there are no predefined static modifiers for `HoverGallery`,
/// but this class provides a consistent and extensible structure for the library.
class HoverGalleryStyle extends ComponentStyle<HoverGalleryStyle>
    with Breakpoints<HoverGalleryStyle>
    implements HoverGalleryStyling {
  /// Constructs a [HoverGalleryStyle].
  const HoverGalleryStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [HoverGalleryStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  HoverGalleryStyle create(List<PrefixModifier> modifiers) {
    return HoverGalleryStyle(cssClass, type: type, modifiers: modifiers);
  }
}
