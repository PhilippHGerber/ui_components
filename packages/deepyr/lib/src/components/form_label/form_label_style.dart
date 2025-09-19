import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'form_label.dart';

/// A marker interface for any utility that can be passed to a [FormLabel]'s
/// `style` list.
///
/// This allows for type-safe application of styles. While `FormLabel` currently
/// has no specific modifiers of its own, this interface supports architectural
/// consistency and allows general utilities to be applied.
abstract class FormLabelStyling implements Styling {}

/// Defines specific styling options for a [FormLabel] component.
///
/// This is the concrete implementation class for form label-specific modifiers.
/// It implements the [FormLabelStyling] interface. Currently, there are no
/// predefined static modifiers for `FormLabel`.
class FormLabelStyle extends ComponentStyle<FormLabelStyle>
    with Breakpoints<FormLabelStyle>
    implements FormLabelStyling {
  /// Constructs a [FormLabelStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier.
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const FormLabelStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [FormLabelStyle] with the provided modifiers.
  @override
  FormLabelStyle create(List<PrefixModifier> modifiers) {
    return FormLabelStyle(cssClass, type: type, modifiers: modifiers);
  }
}
