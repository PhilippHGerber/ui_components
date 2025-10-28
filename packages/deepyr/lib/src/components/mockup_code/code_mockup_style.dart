import '../../base/styling.dart';
import 'code_mockup.dart';

/// A marker interface for any utility that can be passed to a [MockupCode]'s
/// `style` list.
///
/// `MockupCode` has no component-specific modifiers of its own; this interface
/// is used to allow general-purpose utilities (like `BgUtil`, `TextUtil`, `Size`, etc.)
/// to be applied to the main container in a type-safe manner.
abstract class MockupCodeStyling implements Styling {}
