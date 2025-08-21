import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'button.dart';

/// Marker interface for any utility that can be passed to a [Button]'s `modifiers` list.
abstract class ButtonStyling implements Styling {}

/// Represents component-specific utility classes for the [Button] component.
///
/// These modifiers control the appearance and state of the button, such as its
/// color, size, shape (e.g., square, circle), and operational state (e.g., disabled).
class ButtonStyle extends ComponentStyle<ButtonStyle>
    with Breakpoints<ButtonStyle>
    implements ButtonStyling {
  /// Constructs a [ButtonStyle].
  ///
  /// [cssClass]: The core CSS class string for this modifier (e.g., "btn-primary").
  /// [type]: The [StyleType] categorizing this modifier.
  /// [modifiers]: An optional list of [PrefixModifier]s already applied to this modifier.
  const ButtonStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  @override
  ButtonStyle create(List<PrefixModifier> modifiers) {
    return ButtonStyle(
      cssClass,
      type: type,
      modifiers: modifiers,
    );
  }
}
