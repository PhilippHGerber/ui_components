import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'diff.dart';

/// Marker interface for any utility that can be passed to a [Diff]'s `modifiers` list.
abstract class DiffStyling implements Styling {}

/// Defines specific styling options for a [Diff] component, if any are introduced in the future.
/// Currently, Diff styling is primarily through general utilities or child component styling.
/// Implements the [DiffStyling] interface to be usable in the Diff's `modifiers` list.
class DiffStyle extends ComponentStyle<DiffStyle>
    with Breakpoints<DiffStyle>
    implements DiffStyling {
  // Implements the DiffModifier INTERFACE
  const DiffStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  DiffStyle create(List<PrefixModifier> modifiers) {
    return DiffStyle(cssClass, type: type, modifiers: modifiers);
  }
}
