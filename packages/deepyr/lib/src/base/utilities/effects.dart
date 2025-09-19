import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

class Effects extends CommonStyle<Effects> {
  const Effects(super.cssClass, {super.modifiers}) : super(type: StyleType.effect);

  @override
  Effects create(List<PrefixModifier> modifiers) {
    return Effects(cssClass, modifiers: modifiers);
  }

  // --- DaisyUI Specific Effects ---
  /// Glassmorphism effect. `glass` (This is a DaisyUI utility)
  static const Effects glass = Effects('glass');

  // --- Shadow ---
  static const Effects shadowXs = Effects('shadow-xs');
  static const Effects shadowSm = Effects('shadow-sm');
  static const Effects shadow = Effects('shadow');
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

  // --- Border Radius (All Corners) ---
  static const Effects roundedNone = Effects('rounded-none');
  static const Effects roundedSm = Effects('rounded-sm');
  static const Effects rounded = Effects('rounded');
  static const Effects roundedMd = Effects('rounded-md');
  static const Effects roundedLg = Effects('rounded-lg');
  static const Effects roundedXl = Effects('rounded-xl');
  static const Effects rounded2xl = Effects('rounded-2xl');
  static const Effects rounded3xl = Effects('rounded-3xl');
  static const Effects roundedFull = Effects('rounded-full');

  /// A common DaisyUI radius variable. `rounded-box`
  static const Effects roundedBox = Effects('rounded-box');

  // --- Border Radius (Physical Sides) ---
  // Top
  static const Effects roundedTNone = Effects('rounded-t-none');
  static const Effects roundedTSm = Effects('rounded-t-sm');
  static const Effects roundedT = Effects('rounded-t');
  static const Effects roundedTMd = Effects('rounded-t-md');
  static const Effects roundedTLg = Effects('rounded-t-lg');
  static const Effects roundedTXl = Effects('rounded-t-xl');
  static const Effects roundedT2xl = Effects('rounded-t-2xl');
  static const Effects roundedT3xl = Effects('rounded-t-3xl');
  static const Effects roundedTFull = Effects('rounded-t-full');
  // Bottom
  static const Effects roundedBNone = Effects('rounded-b-none');
  static const Effects roundedBSm = Effects('rounded-b-sm');
  static const Effects roundedB = Effects('rounded-b');
  static const Effects roundedBMd = Effects('rounded-b-md');
  static const Effects roundedBLg = Effects('rounded-b-lg');
  static const Effects roundedBXl = Effects('rounded-b-xl');
  static const Effects roundedB2xl = Effects('rounded-b-2xl');
  static const Effects roundedB3xl = Effects('rounded-b-3xl');
  static const Effects roundedBFull = Effects('rounded-b-full');
  // Left
  static const Effects roundedLNone = Effects('rounded-l-none');
  static const Effects roundedLSm = Effects('rounded-l-sm');
  static const Effects roundedL = Effects('rounded-l');
  static const Effects roundedLMd = Effects('rounded-l-md');
  static const Effects roundedLLg = Effects('rounded-l-lg');
  static const Effects roundedLXl = Effects('rounded-l-xl');
  static const Effects roundedL2xl = Effects('rounded-l-2xl');
  static const Effects roundedL3xl = Effects('rounded-l-3xl');
  static const Effects roundedLFull = Effects('rounded-l-full');
  // Right
  static const Effects roundedRNone = Effects('rounded-r-none');
  static const Effects roundedRSm = Effects('rounded-r-sm');
  static const Effects roundedR = Effects('rounded-r');
  static const Effects roundedRMd = Effects('rounded-r-md');
  static const Effects roundedRLg = Effects('rounded-r-lg');
  static const Effects roundedRXl = Effects('rounded-r-xl');
  static const Effects roundedR2xl = Effects('rounded-r-2xl');
  static const Effects roundedR3xl = Effects('rounded-r-3xl');
  static const Effects roundedRFull = Effects('rounded-r-full');

  // --- Border Radius (Logical Sides - LTR/RTL aware) ---
  // Start (Left in LTR)
  static const Effects roundedSNone = Effects('rounded-s-none');
  static const Effects roundedSSm = Effects('rounded-s-sm');
  static const Effects roundedS = Effects('rounded-s');
  static const Effects roundedSMd = Effects('rounded-s-md');
  static const Effects roundedSLg = Effects('rounded-s-lg');
  static const Effects roundedSXl = Effects('rounded-s-xl');
  static const Effects roundedS2xl = Effects('rounded-s-2xl');
  static const Effects roundedS3xl = Effects('rounded-s-3xl');
  static const Effects roundedSFull = Effects('rounded-s-full');
  // End (Right in LTR)
  static const Effects roundedENone = Effects('rounded-e-none');
  static const Effects roundedESm = Effects('rounded-e-sm');
  static const Effects roundedE = Effects('rounded-e');
  static const Effects roundedEMd = Effects('rounded-e-md');
  static const Effects roundedELg = Effects('rounded-e-lg');
  static const Effects roundedEXl = Effects('rounded-e-xl');
  static const Effects roundedE2xl = Effects('rounded-e-2xl');
  static const Effects roundedE3xl = Effects('rounded-e-3xl');
  static const Effects roundedEFull = Effects('rounded-e-full');

  // --- Border Radius (Individual Physical Corners) ---
  // Top-Left
  static const Effects roundedTlNone = Effects('rounded-tl-none');
  static const Effects roundedTlSm = Effects('rounded-tl-sm');
  static const Effects roundedTl = Effects('rounded-tl');
  static const Effects roundedTlMd = Effects('rounded-tl-md');
  static const Effects roundedTlLg = Effects('rounded-tl-lg');
  static const Effects roundedTlXl = Effects('rounded-tl-xl');
  static const Effects roundedTl2xl = Effects('rounded-tl-2xl');
  static const Effects roundedTl3xl = Effects('rounded-tl-3xl');
  static const Effects roundedTlFull = Effects('rounded-tl-full');
  // Top-Right
  static const Effects roundedTrNone = Effects('rounded-tr-none');
  static const Effects roundedTrSm = Effects('rounded-tr-sm');
  static const Effects roundedTr = Effects('rounded-tr');
  static const Effects roundedTrMd = Effects('rounded-tr-md');
  static const Effects roundedTrLg = Effects('rounded-tr-lg');
  static const Effects roundedTrXl = Effects('rounded-tr-xl');
  static const Effects roundedTr2xl = Effects('rounded-tr-2xl');
  static const Effects roundedTr3xl = Effects('rounded-tr-3xl');
  static const Effects roundedTrFull = Effects('rounded-tr-full');
  // Bottom-Right
  static const Effects roundedBrNone = Effects('rounded-br-none');
  static const Effects roundedBrSm = Effects('rounded-br-sm');
  static const Effects roundedBr = Effects('rounded-br');
  static const Effects roundedBrMd = Effects('rounded-br-md');
  static const Effects roundedBrLg = Effects('rounded-br-lg');
  static const Effects roundedBrXl = Effects('rounded-br-xl');
  static const Effects roundedBr2xl = Effects('rounded-br-2xl');
  static const Effects roundedBr3xl = Effects('rounded-br-3xl');
  static const Effects roundedBrFull = Effects('rounded-br-full');
  // Bottom-Left
  static const Effects roundedBlNone = Effects('rounded-bl-none');
  static const Effects roundedBlSm = Effects('rounded-bl-sm');
  static const Effects roundedBl = Effects('rounded-bl');
  static const Effects roundedBlMd = Effects('rounded-bl-md');
  static const Effects roundedBlLg = Effects('rounded-bl-lg');
  static const Effects roundedBlXl = Effects('rounded-bl-xl');
  static const Effects roundedBl2xl = Effects('rounded-bl-2xl');
  static const Effects roundedBl3xl = Effects('rounded-bl-3xl');
  static const Effects roundedBlFull = Effects('rounded-bl-full');

  // --- Border Radius (Individual Logical Corners) ---
  // Start-Start (Top-Left in LTR)
  static const Effects roundedSsNone = Effects('rounded-ss-none');
  static const Effects roundedSsSm = Effects('rounded-ss-sm');
  static const Effects roundedSs = Effects('rounded-ss');
  static const Effects roundedSsMd = Effects('rounded-ss-md');
  static const Effects roundedSsLg = Effects('rounded-ss-lg');
  static const Effects roundedSsXl = Effects('rounded-ss-xl');
  static const Effects roundedSs2xl = Effects('rounded-ss-2xl');
  static const Effects roundedSs3xl = Effects('rounded-ss-3xl');
  static const Effects roundedSsFull = Effects('rounded-ss-full');
  // Start-End (Top-Right in LTR)
  static const Effects roundedSeNone = Effects('rounded-se-none');
  static const Effects roundedSeSm = Effects('rounded-se-sm');
  static const Effects roundedSe = Effects('rounded-se');
  static const Effects roundedSeMd = Effects('rounded-se-md');
  static const Effects roundedSeLg = Effects('rounded-se-lg');
  static const Effects roundedSeXl = Effects('rounded-se-xl');
  static const Effects roundedSe2xl = Effects('rounded-se-2xl');
  static const Effects roundedSe3xl = Effects('rounded-se-3xl');
  static const Effects roundedSeFull = Effects('rounded-se-full');
  // End-End (Bottom-Right in LTR)
  static const Effects roundedEeNone = Effects('rounded-ee-none');
  static const Effects roundedEeSm = Effects('rounded-ee-sm');
  static const Effects roundedEe = Effects('rounded-ee');
  static const Effects roundedEeMd = Effects('rounded-ee-md');
  static const Effects roundedEeLg = Effects('rounded-ee-lg');
  static const Effects roundedEeXl = Effects('rounded-ee-xl');
  static const Effects roundedEe2xl = Effects('rounded-ee-2xl');
  static const Effects roundedEe3xl = Effects('rounded-ee-3xl');
  static const Effects roundedEeFull = Effects('rounded-ee-full');
  // End-Start (Bottom-Left in LTR)
  static const Effects roundedEsNone = Effects('rounded-es-none');
  static const Effects roundedEsSm = Effects('rounded-es-sm');
  static const Effects roundedEs = Effects('rounded-es');
  static const Effects roundedEsMd = Effects('rounded-es-md');
  static const Effects roundedEsLg = Effects('rounded-es-lg');
  static const Effects roundedEsXl = Effects('rounded-es-xl');
  static const Effects roundedEs2xl = Effects('rounded-es-2xl');
  static const Effects roundedEs3xl = Effects('rounded-es-3xl');
  static const Effects roundedEsFull = Effects('rounded-es-full');
}
