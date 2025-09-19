import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'footer.dart';

/// A marker interface for any utility that can be passed to a [Footer]'s
/// `style` list.
///
/// This allows for type-safe application of styles.
abstract class FooterStyling implements Styling {}

/// Defines specific styling options for a [Footer] component.
///
/// This is the concrete implementation class for footer-specific modifiers.
/// It implements the [FooterStyling] interface, making it a valid type for the
/// `style` property of a [Footer] component.
class FooterStyle extends ComponentStyle<FooterStyle>
    with Breakpoints<FooterStyle>
    implements FooterStyling {
  /// Constructs a [FooterStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier.
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const FooterStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [FooterStyle] with the provided modifiers.
  @override
  FooterStyle create(List<PrefixModifier> modifiers) {
    return FooterStyle(cssClass, type: type, modifiers: modifiers);
  }
}
