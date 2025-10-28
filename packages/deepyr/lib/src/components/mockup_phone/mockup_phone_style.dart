import '../../base/styling.dart';
import 'mockup_phone.dart';

/// A marker interface for any utility that can be passed to a [MockupPhone]'s
/// `style` list.
///
/// `MockupPhone` has no component-specific modifiers of its own; this interface
/// is used to allow general-purpose utilities (like `BorderUtil`, `Effects`, etc.)
/// to be applied to the main phone frame in a type-safe manner.
abstract class MockupPhoneStyling implements Styling {}
