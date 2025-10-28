import '../../base/styling.dart';
import 'mockup_window.dart';

/// A marker interface for any utility that can be passed to a [MockupWindow]'s
/// `style` list.
///
/// `MockupWindow` has no component-specific modifiers of its own; this interface
/// is used to allow general-purpose utilities (like `BgUtil`, `BorderUtil`, `Size`, etc.)
/// to be applied to the main window frame in a type-safe manner.
abstract class MockupWindowStyling implements Styling {}
