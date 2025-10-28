import '../../base/styling.dart';
import 'browser_mockup.dart';
import 'browser_mockup_toolbar.dart';

/// A marker interface for any utility that can be passed to a [BrowserMockup]'s
/// `style` list.
///
/// This allows for type-safe application of styles. `BrowserMockup` has no
/// component-specific modifiers; this interface is used to allow general utilities
/// (like `BgUtil`, `BorderUtil`, `Effects`, etc.) to be applied to the main
/// component frame.
abstract class BrowserMockupStyling implements Styling {}

/// A marker interface for any utility that can be passed to a [BrowserToolbar]'s
/// `style` list.
///
/// This allows for type-safe application of styles. `BrowserToolbar` has no
/// component-specific modifiers, so this interface is used for applying general utilities.
abstract class BrowserToolbarStyling implements Styling {}
