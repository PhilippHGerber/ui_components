import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'radio.dart';

/// A marker interface for any utility that can be passed to a [Radio]'s `style` list.
///
/// This allows for type-safe application of styles for colors and sizes.
abstract class RadioStyling implements Styling {}

/// Defines specific styling options for a [Radio] component.
///
/// This is the concrete implementation class for radio-button-specific modifiers.
/// It implements the [RadioStyling] interface, making it a valid type for the
/// `style` property of a [Radio] component.
class RadioStyle extends ComponentStyle<RadioStyle>
    with Breakpoints<RadioStyle>
    implements RadioStyling {
  /// Constructs a [RadioStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "radio-primary").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const RadioStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [RadioStyle] with the provided modifiers.
  @override
  RadioStyle create(List<PrefixModifier> modifiers) {
    return RadioStyle(cssClass, type: type, modifiers: modifiers);
  }
}
