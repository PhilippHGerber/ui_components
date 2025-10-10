import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// A utility class for applying visual effects like shadows, opacity, and border-radius.
class Effects extends CommonStyle<Effects> {
  const Effects(super.cssClass, {super.modifiers}) : super(type: StyleType.effect);

  @override
  Effects create(List<PrefixModifier> modifiers) {
    return Effects(cssClass, modifiers: modifiers);
  }

  /// Glassmorphism effect. `glass` (This is a DaisyUI utility)
  static const Effects glass = Effects('glass');

  /// `box-shadow: xs`
  static const Effects shadowXs = Effects('shadow-xs');

  /// `box-shadow: sm`
  static const Effects shadowSm = Effects('shadow-sm');

  /// `box-shadow: default`
  static const Effects shadow = Effects('shadow');

  /// `box-shadow: md`
  static const Effects shadowMd = Effects('shadow-md');

  /// `box-shadow: lg`
  static const Effects shadowLg = Effects('shadow-lg');

  /// `box-shadow: xl`
  static const Effects shadowXl = Effects('shadow-xl');

  /// `box-shadow: 2xl`
  static const Effects shadow2xl = Effects('shadow-2xl');

  /// `box-shadow: inner`
  static const Effects shadowInner = Effects('shadow-inner');

  /// `box-shadow: none`
  static const Effects shadowNone = Effects('shadow-none');

  /// Creates an opacity utility. `opacity-{value}`
  ///
  /// [value]: The opacity percentage. Must be between 0 and 100,
  /// and a multiple of 5 (e.g., 0, 5, 10, ..., 95, 100).
  static Effects opacity(int value) {
    // Value from 0 to 100, step 5
    assert(
      value >= 0 && value <= 100 && value % 5 == 0,
      'Opacity value must be between 0 and 100, in steps of 5.',
    );
    return Effects('opacity-$value');
  }

  /// `opacity: 0`
  static const Effects opacity0 = Effects('opacity-0');

  /// `opacity: 0.25`
  static const Effects opacity25 = Effects('opacity-25');

  /// `opacity: 0.5`
  static const Effects opacity50 = Effects('opacity-50');

  /// `opacity: 0.75`
  static const Effects opacity75 = Effects('opacity-75');

  /// `opacity: 1`
  static const Effects opacity100 = Effects('opacity-100');

  /// `border-radius: 0`
  static const Effects roundedNone = Effects('rounded-none');

  /// `border-radius: sm`
  static const Effects roundedSm = Effects('rounded-sm');

  /// `border-radius: default`
  static const Effects rounded = Effects('rounded');

  /// `border-radius: md`
  static const Effects roundedMd = Effects('rounded-md');

  /// `border-radius: lg`
  static const Effects roundedLg = Effects('rounded-lg');

  /// `border-radius: xl`
  static const Effects roundedXl = Effects('rounded-xl');

  /// `border-radius: 2xl`
  static const Effects rounded2xl = Effects('rounded-2xl');

  /// `border-radius: 3xl`
  static const Effects rounded3xl = Effects('rounded-3xl');

  /// `border-radius: full`
  static const Effects roundedFull = Effects('rounded-full');

  /// A common DaisyUI radius variable. `rounded-box`
  static const Effects roundedBox = Effects('rounded-box');

  /// `border-top-left-radius: 0; border-top-right-radius: 0`
  static const Effects roundedTNone = Effects('rounded-t-none');

  /// `border-top-left-radius: sm; border-top-right-radius: sm`
  static const Effects roundedTSm = Effects('rounded-t-sm');

  /// `border-top-left-radius: default; border-top-right-radius: default`
  static const Effects roundedT = Effects('rounded-t');

  /// `border-top-left-radius: md; border-top-right-radius: md`
  static const Effects roundedTMd = Effects('rounded-t-md');

  /// `border-top-left-radius: lg; border-top-right-radius: lg`
  static const Effects roundedTLg = Effects('rounded-t-lg');

  /// `border-top-left-radius: xl; border-top-right-radius: xl`
  static const Effects roundedTXl = Effects('rounded-t-xl');

  /// `border-top-left-radius: 2xl; border-top-right-radius: 2xl`
  static const Effects roundedT2xl = Effects('rounded-t-2xl');

  /// `border-top-left-radius: 3xl; border-top-right-radius: 3xl`
  static const Effects roundedT3xl = Effects('rounded-t-3xl');

  /// `border-top-left-radius: full; border-top-right-radius: full`
  static const Effects roundedTFull = Effects('rounded-t-full');
  // Bottom
  /// `border-bottom-left-radius: 0; border-bottom-right-radius: 0`
  static const Effects roundedBNone = Effects('rounded-b-none');

  /// `border-bottom-left-radius: sm; border-bottom-right-radius: sm`
  static const Effects roundedBSm = Effects('rounded-b-sm');

  /// `border-bottom-left-radius: default; border-bottom-right-radius: default`
  static const Effects roundedB = Effects('rounded-b');

  /// `border-bottom-left-radius: md; border-bottom-right-radius: md`
  static const Effects roundedBMd = Effects('rounded-b-md');

  /// `border-bottom-left-radius: lg; border-bottom-right-radius: lg`
  static const Effects roundedBLg = Effects('rounded-b-lg');

  /// `border-bottom-left-radius: xl; border-bottom-right-radius: xl`
  static const Effects roundedBXl = Effects('rounded-b-xl');

  /// `border-bottom-left-radius: 2xl; border-bottom-right-radius: 2xl`
  static const Effects roundedB2xl = Effects('rounded-b-2xl');

  /// `border-bottom-left-radius: 3xl; border-bottom-right-radius: 3xl`
  static const Effects roundedB3xl = Effects('rounded-b-3xl');

  /// `border-bottom-left-radius: full; border-bottom-right-radius: full`
  static const Effects roundedBFull = Effects('rounded-b-full');
  // Left
  /// `border-top-left-radius: 0; border-bottom-left-radius: 0`
  static const Effects roundedLNone = Effects('rounded-l-none');

  /// `border-top-left-radius: sm; border-bottom-left-radius: sm`
  static const Effects roundedLSm = Effects('rounded-l-sm');

  /// `border-top-left-radius: default; border-bottom-left-radius: default`
  static const Effects roundedL = Effects('rounded-l');

  /// `border-top-left-radius: md; border-bottom-left-radius: md`
  static const Effects roundedLMd = Effects('rounded-l-md');

  /// `border-top-left-radius: lg; border-bottom-left-radius: lg`
  static const Effects roundedLLg = Effects('rounded-l-lg');

  /// `border-top-left-radius: xl; border-bottom-left-radius: xl`
  static const Effects roundedLXl = Effects('rounded-l-xl');

  /// `border-top-left-radius: 2xl; border-bottom-left-radius: 2xl`
  static const Effects roundedL2xl = Effects('rounded-l-2xl');

  /// `border-top-left-radius: 3xl; border-bottom-left-radius: 3xl`
  static const Effects roundedL3xl = Effects('rounded-l-3xl');

  /// `border-top-left-radius: full; border-bottom-left-radius: full`
  static const Effects roundedLFull = Effects('rounded-l-full');
  // Right
  /// `border-top-right-radius: 0; border-bottom-right-radius: 0`
  static const Effects roundedRNone = Effects('rounded-r-none');

  /// `border-top-right-radius: sm; border-bottom-right-radius: sm`
  static const Effects roundedRSm = Effects('rounded-r-sm');

  /// `border-top-right-radius: default; border-bottom-right-radius: default`
  static const Effects roundedR = Effects('rounded-r');

  /// `border-top-right-radius: md; border-bottom-right-radius: md`
  static const Effects roundedRMd = Effects('rounded-r-md');

  /// `border-top-right-radius: lg; border-bottom-right-radius: lg`
  static const Effects roundedRLg = Effects('rounded-r-lg');

  /// `border-top-right-radius: xl; border-bottom-right-radius: xl`
  static const Effects roundedRXl = Effects('rounded-r-xl');

  /// `border-top-right-radius: 2xl; border-bottom-right-radius: 2xl`
  static const Effects roundedR2xl = Effects('rounded-r-2xl');

  /// `border-top-right-radius: 3xl; border-bottom-right-radius: 3xl`
  static const Effects roundedR3xl = Effects('rounded-r-3xl');

  /// `border-top-right-radius: full; border-bottom-right-radius: full`
  static const Effects roundedRFull = Effects('rounded-r-full');

  // --- Border Radius (Logical Sides - LTR/RTL aware) ---
  // Start (Left in LTR)
  /// `border-start-start-radius: 0; border-end-start-radius: 0`
  static const Effects roundedSNone = Effects('rounded-s-none');

  /// `border-start-start-radius: sm; border-end-start-radius: sm`
  static const Effects roundedSSm = Effects('rounded-s-sm');

  /// `border-start-start-radius: default; border-end-start-radius: default`
  static const Effects roundedS = Effects('rounded-s');

  /// `border-start-start-radius: md; border-end-start-radius: md`
  static const Effects roundedSMd = Effects('rounded-s-md');

  /// `border-start-start-radius: lg; border-end-start-radius: lg`
  static const Effects roundedSLg = Effects('rounded-s-lg');

  /// `border-start-start-radius: xl; border-end-start-radius: xl`
  static const Effects roundedSXl = Effects('rounded-s-xl');

  /// `border-start-start-radius: 2xl; border-end-start-radius: 2xl`
  static const Effects roundedS2xl = Effects('rounded-s-2xl');

  /// `border-start-start-radius: 3xl; border-end-start-radius: 3xl`
  static const Effects roundedS3xl = Effects('rounded-s-3xl');

  /// `border-start-start-radius: full; border-end-start-radius: full`
  static const Effects roundedSFull = Effects('rounded-s-full');
  // End (Right in LTR)
  /// `border-start-end-radius: 0; border-end-end-radius: 0`
  static const Effects roundedENone = Effects('rounded-e-none');

  /// `border-start-end-radius: sm; border-end-end-radius: sm`
  static const Effects roundedESm = Effects('rounded-e-sm');

  /// `border-start-end-radius: default; border-end-end-radius: default`
  static const Effects roundedE = Effects('rounded-e');

  /// `border-start-end-radius: md; border-end-end-radius: md`
  static const Effects roundedEMd = Effects('rounded-e-md');

  /// `border-start-end-radius: lg; border-end-end-radius: lg`
  static const Effects roundedELg = Effects('rounded-e-lg');

  /// `border-start-end-radius: xl; border-end-end-radius: xl`
  static const Effects roundedEXl = Effects('rounded-e-xl');

  /// `border-start-end-radius: 2xl; border-end-end-radius: 2xl`
  static const Effects roundedE2xl = Effects('rounded-e-2xl');

  /// `border-start-end-radius: 3xl; border-end-end-radius: 3xl`
  static const Effects roundedE3xl = Effects('rounded-e-3xl');

  /// `border-start-end-radius: full; border-end-end-radius: full`
  static const Effects roundedEFull = Effects('rounded-e-full');

  // --- Border Radius (Individual Physical Corners) ---
  // Top-Left
  /// `border-top-left-radius: 0`
  static const Effects roundedTlNone = Effects('rounded-tl-none');

  /// `border-top-left-radius: sm`
  static const Effects roundedTlSm = Effects('rounded-tl-sm');

  /// `border-top-left-radius: default`
  static const Effects roundedTl = Effects('rounded-tl');

  /// `border-top-left-radius: md`
  static const Effects roundedTlMd = Effects('rounded-tl-md');

  /// `border-top-left-radius: lg`
  static const Effects roundedTlLg = Effects('rounded-tl-lg');

  /// `border-top-left-radius: xl`
  static const Effects roundedTlXl = Effects('rounded-tl-xl');

  /// `border-top-left-radius: 2xl`
  static const Effects roundedTl2xl = Effects('rounded-tl-2xl');

  /// `border-top-left-radius: 3xl`
  static const Effects roundedTl3xl = Effects('rounded-tl-3xl');

  /// `border-top-left-radius: full`
  static const Effects roundedTlFull = Effects('rounded-tl-full');
  // Top-Right
  /// `border-top-right-radius: 0`
  static const Effects roundedTrNone = Effects('rounded-tr-none');

  /// `border-top-right-radius: sm`
  static const Effects roundedTrSm = Effects('rounded-tr-sm');

  /// `border-top-right-radius: default`
  static const Effects roundedTr = Effects('rounded-tr');

  /// `border-top-right-radius: md`
  static const Effects roundedTrMd = Effects('rounded-tr-md');

  /// `border-top-right-radius: lg`
  static const Effects roundedTrLg = Effects('rounded-tr-lg');

  /// `border-top-right-radius: xl`
  static const Effects roundedTrXl = Effects('rounded-tr-xl');

  /// `border-top-right-radius: 2xl`
  static const Effects roundedTr2xl = Effects('rounded-tr-2xl');

  /// `border-top-right-radius: 3xl`
  static const Effects roundedTr3xl = Effects('rounded-tr-3xl');

  /// `border-top-right-radius: full`
  static const Effects roundedTrFull = Effects('rounded-tr-full');
  // Bottom-Right
  /// `border-bottom-right-radius: 0`
  static const Effects roundedBrNone = Effects('rounded-br-none');

  /// `border-bottom-right-radius: sm`
  static const Effects roundedBrSm = Effects('rounded-br-sm');

  /// `border-bottom-right-radius: default`
  static const Effects roundedBr = Effects('rounded-br');

  /// `border-bottom-right-radius: md`
  static const Effects roundedBrMd = Effects('rounded-br-md');

  /// `border-bottom-right-radius: lg`
  static const Effects roundedBrLg = Effects('rounded-br-lg');

  /// `border-bottom-right-radius: xl`
  static const Effects roundedBrXl = Effects('rounded-br-xl');

  /// `border-bottom-right-radius: 2xl`
  static const Effects roundedBr2xl = Effects('rounded-br-2xl');

  /// `border-bottom-right-radius: 3xl`
  static const Effects roundedBr3xl = Effects('rounded-br-3xl');

  /// `border-bottom-right-radius: full`
  static const Effects roundedBrFull = Effects('rounded-br-full');
  // Bottom-Left
  /// `border-bottom-left-radius: 0`
  static const Effects roundedBlNone = Effects('rounded-bl-none');

  /// `border-bottom-left-radius: sm`
  static const Effects roundedBlSm = Effects('rounded-bl-sm');

  /// `border-bottom-left-radius: default`
  static const Effects roundedBl = Effects('rounded-bl');

  /// `border-bottom-left-radius: md`
  static const Effects roundedBlMd = Effects('rounded-bl-md');

  /// `border-bottom-left-radius: lg`
  static const Effects roundedBlLg = Effects('rounded-bl-lg');

  /// `border-bottom-left-radius: xl`
  static const Effects roundedBlXl = Effects('rounded-bl-xl');

  /// `border-bottom-left-radius: 2xl`
  static const Effects roundedBl2xl = Effects('rounded-bl-2xl');

  /// `border-bottom-left-radius: 3xl`
  static const Effects roundedBl3xl = Effects('rounded-bl-3xl');

  /// `border-bottom-left-radius: full`
  static const Effects roundedBlFull = Effects('rounded-bl-full');

  // --- Border Radius (Individual Logical Corners) ---
  // Start-Start (Top-Left in LTR)
  /// `border-start-start-radius: 0`
  static const Effects roundedSsNone = Effects('rounded-ss-none');

  /// `border-start-start-radius: sm`
  static const Effects roundedSsSm = Effects('rounded-ss-sm');

  /// `border-start-start-radius: default`
  static const Effects roundedSs = Effects('rounded-ss');

  /// `border-start-start-radius: md`
  static const Effects roundedSsMd = Effects('rounded-ss-md');

  /// `border-start-start-radius: lg`
  static const Effects roundedSsLg = Effects('rounded-ss-lg');

  /// `border-start-start-radius: xl`
  static const Effects roundedSsXl = Effects('rounded-ss-xl');

  /// `border-start-start-radius: 2xl`
  static const Effects roundedSs2xl = Effects('rounded-ss-2xl');

  /// `border-start-start-radius: 3xl`
  static const Effects roundedSs3xl = Effects('rounded-ss-3xl');

  /// `border-start-start-radius: full`
  static const Effects roundedSsFull = Effects('rounded-ss-full');
  // Start-End (Top-Right in LTR)
  /// `border-start-end-radius: 0`
  static const Effects roundedSeNone = Effects('rounded-se-none');

  /// `border-start-end-radius: sm`
  static const Effects roundedSeSm = Effects('rounded-se-sm');

  /// `border-start-end-radius: default`
  static const Effects roundedSe = Effects('rounded-se');

  /// `border-start-end-radius: md`
  static const Effects roundedSeMd = Effects('rounded-se-md');

  /// `border-start-end-radius: lg`
  static const Effects roundedSeLg = Effects('rounded-se-lg');

  /// `border-start-end-radius: xl`
  static const Effects roundedSeXl = Effects('rounded-se-xl');

  /// `border-start-end-radius: 2xl`
  static const Effects roundedSe2xl = Effects('rounded-se-2xl');

  /// `border-start-end-radius: 3xl`
  static const Effects roundedSe3xl = Effects('rounded-se-3xl');

  /// `border-start-end-radius: full`
  static const Effects roundedSeFull = Effects('rounded-se-full');
  // End-End (Bottom-Right in LTR)
  /// `border-end-end-radius: 0`
  static const Effects roundedEeNone = Effects('rounded-ee-none');

  /// `border-end-end-radius: sm`
  static const Effects roundedEeSm = Effects('rounded-ee-sm');

  /// `border-end-end-radius: default`
  static const Effects roundedEe = Effects('rounded-ee');

  /// `border-end-end-radius: md`
  static const Effects roundedEeMd = Effects('rounded-ee-md');

  /// `border-end-end-radius: lg`
  static const Effects roundedEeLg = Effects('rounded-ee-lg');

  /// `border-end-end-radius: xl`
  static const Effects roundedEeXl = Effects('rounded-ee-xl');

  /// `border-end-end-radius: 2xl`
  static const Effects roundedEe2xl = Effects('rounded-ee-2xl');

  /// `border-end-end-radius: 3xl`
  static const Effects roundedEe3xl = Effects('rounded-ee-3xl');

  /// `border-end-end-radius: full`
  static const Effects roundedEeFull = Effects('rounded-ee-full');
  // End-Start (Bottom-Left in LTR)
  /// `border-end-start-radius: 0`
  static const Effects roundedEsNone = Effects('rounded-es-none');

  /// `border-end-start-radius: sm`
  static const Effects roundedEsSm = Effects('rounded-es-sm');

  /// `border-end-start-radius: default`
  static const Effects roundedEs = Effects('rounded-es');

  /// `border-end-start-radius: md`
  static const Effects roundedEsMd = Effects('rounded-es-md');

  /// `border-end-start-radius: lg`
  static const Effects roundedEsLg = Effects('rounded-es-lg');

  /// `border-end-start-radius: xl`
  static const Effects roundedEsXl = Effects('rounded-es-xl');

  /// `border-end-start-radius: 2xl`
  static const Effects roundedEs2xl = Effects('rounded-es-2xl');

  /// `border-end-start-radius: 3xl`
  static const Effects roundedEs3xl = Effects('rounded-es-3xl');

  /// `border-end-start-radius: full`
  static const Effects roundedEsFull = Effects('rounded-es-full');
}
