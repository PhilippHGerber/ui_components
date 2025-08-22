import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

class Effects extends CommonStyle<Effects> {
  const Effects(super.cssClass, {super.modifiers})
      : super(type: StyleType.effect); // Changed type to effect

  // --- Shadow ---
  static const Effects shadowXs = Effects('shadow-xs');
  static const Effects shadowSm = Effects('shadow-sm');
  static const Effects shadow = Effects('shadow'); // Often md by default in TW
  static const Effects shadowMd = Effects('shadow-md');
  static const Effects shadowLg = Effects('shadow-lg');
  static const Effects shadowXl = Effects('shadow-xl');
  static const Effects shadow2xl = Effects('shadow-2xl');
  static const Effects shadowInner = Effects('shadow-inner');
  static const Effects shadowNone = Effects('shadow-none');

  // --- Opacity ---
  static Effects opacity(int value) {
    // Value from 0 to 100, step 5
    assert(
      value >= 0 && value <= 100 && value % 5 == 0,
      'Opacity value must be between 0 and 100, in steps of 5.',
    );
    return Effects('opacity-$value');
  }

  static const Effects opacity0 = Effects('opacity-0');
  static const Effects opacity25 = Effects('opacity-25');
  static const Effects opacity50 = Effects('opacity-50');
  static const Effects opacity75 = Effects('opacity-75');
  static const Effects opacity100 = Effects('opacity-100');

  // --- Rounded Corners ---
  static const Effects rounded = Effects('rounded');
  static const Effects roundedNone = Effects('rounded-none');
  static const Effects roundedSm = Effects('rounded-sm');
  static const Effects roundedMd = Effects('rounded-md');
  static const Effects roundedLg = Effects('rounded-lg');
  static const Effects roundedXl = Effects('rounded-xl');
  static const Effects rounded2xl = Effects('rounded-2xl');
  static const Effects rounded3xl = Effects('rounded-3xl');
  static const Effects roundedFull = Effects('rounded-full');

  // rounded-box
  static const Effects roundedBox = Effects('rounded-box');

  // --- Blend Mode --- (mix-blend-*)
  // Example:
  // static const Effects mixBlendMultiply = Effects('mix-blend-multiply');
  // static const Effects mixBlendScreen = Effects('mix-blend-screen');
  // ... add others as needed

  // --- Background Blend Mode --- (bg-blend-*)
  // Example:
  // static const Effects bgBlendMultiply = Effects('bg-blend-multiply');
  // ... add others as needed

  // --- Box Shadow Color (Tailwind 3.3+) ---
  // Example: shadow-cyan-500
  // This would require a more complex builder or many constants.
  // For now, users can combine `Effects.shadow` with a `styles` Map for custom shadow colors.
  // Or, if DaisyUI provides specific shadow color classes, they could be added.

  // --- DaisyUI Specific Effects (like glass) ---
  /// Glassmorphism effect. `glass` (This is a DaisyUI utility)
  static const Effects glass = Effects('glass');

  // TODO: Add utilities for transitions, transforms, animations if they fit here
  // or in their own utility groups. The original had transition and transform here.
  // For now, keeping it focused on shadow and opacity.

  @override
  Effects create(List<PrefixModifier> modifiers) {
    return Effects(cssClass, modifiers: modifiers);
  }
}
