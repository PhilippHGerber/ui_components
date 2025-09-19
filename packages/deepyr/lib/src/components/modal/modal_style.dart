import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'modal.dart';

/// Marker interface for any utility that can be passed to a [Modal]'s `modifiers` list.
abstract class ModalStyling implements Styling {}

/// Defines specific styling, positioning, and behavioral options for a [Modal] container component.
/// Implements the [ModalStyling] interface.
///
/// This class is used to create concrete instances of modal-specific modifiers.
/// The static definitions for these modifiers (e.g., `Modal.top`) are typically
/// located within the `Modal` component class itself for easier discovery.
class ModalStyle extends ComponentStyle<ModalStyle>
    with Breakpoints<ModalStyle>
    implements ModalStyling {
  /// Constructs a [ModalStyle].
  ///
  /// [cssClass]: The core CSS class string (e.g., "modal-top").
  /// [type]: The [StyleType] categorizing this modifier.
  /// [modifiers]: An optional list of [PrefixModifier]s already applied.
  const ModalStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  ModalStyle create(List<PrefixModifier> modifiers) {
    return ModalStyle(cssClass, type: type, modifiers: modifiers);
  }
}
