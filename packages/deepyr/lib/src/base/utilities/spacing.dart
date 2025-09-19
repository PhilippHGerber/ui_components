import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// Utilities for controlling spacing (margin and padding).
///
/// This class provides both dynamic constructors for arbitrary values (e.g., `Spacing.m(2.5)`)
/// and a comprehensive set of static constants for the standard Tailwind CSS scale
/// (e.g., `Spacing.m4`, `Spacing.px6`, `Spacing.mb40`).
class Spacing extends CommonStyle<Spacing> {
  const Spacing(super.cssClass, {super.modifiers}) : super(type: StyleType.spacing);

  // --- DYNAMIC CONSTRUCTORS ---
  /// Margin on all sides. `m-{value}`
  Spacing.m(double value) : super('m-${_formatValue(value)}', type: StyleType.spacing);

  /// Margin on x-axis. `mx-{value}`
  Spacing.mx(double value) : super('mx-${_formatValue(value)}', type: StyleType.spacing);

  /// Margin on y-axis. `my-{value}`
  Spacing.my(double value) : super('my-${_formatValue(value)}', type: StyleType.spacing);

  /// Margin on top. `mt-{value}`
  Spacing.mt(double value) : super('mt-${_formatValue(value)}', type: StyleType.spacing);

  /// Margin on right. `mr-{value}` or `me-{value}` (end)
  Spacing.mr(double value) : super('mr-${_formatValue(value)}', type: StyleType.spacing);
  Spacing.me(double value) : super('me-${_formatValue(value)}', type: StyleType.spacing);

  /// Margin on bottom. `mb-{value}`
  Spacing.mb(double value) : super('mb-${_formatValue(value)}', type: StyleType.spacing);

  /// Margin on left. `ml-{value}` or `ms-{value}` (start)
  Spacing.ml(double value) : super('ml-${_formatValue(value)}', type: StyleType.spacing);
  Spacing.ms(double value) : super('ms-${_formatValue(value)}', type: StyleType.spacing);

  // --- Padding ---
  /// Padding on all sides. `p-{value}`
  Spacing.p(double value) : super('p-${_formatValue(value)}', type: StyleType.spacing);

  /// Padding on x-axis. `px-{value}`
  Spacing.px(double value) : super('px-${_formatValue(value)}', type: StyleType.spacing);

  /// Padding on y-axis. `py-{value}`
  Spacing.py(double value) : super('py-${_formatValue(value)}', type: StyleType.spacing);

  /// Padding on top. `pt-{value}`
  Spacing.pt(double value) : super('pt-${_formatValue(value)}', type: StyleType.spacing);

  /// Padding on right. `pr-{value}` or `pe-{value}` (end)
  Spacing.pr(double value) : super('pr-${_formatValue(value)}', type: StyleType.spacing);
  Spacing.pe(double value) : super('pe-${_formatValue(value)}', type: StyleType.spacing);

  /// Padding on bottom. `pb-{value}`
  Spacing.pb(double value) : super('pb-${_formatValue(value)}', type: StyleType.spacing);

  /// Padding on left. `pl-{value}` or `ps-{value}` (start)
  Spacing.pl(double value) : super('pl-${_formatValue(value)}', type: StyleType.spacing);
  Spacing.ps(double value) : super('ps-${_formatValue(value)}', type: StyleType.spacing);

  @override
  Spacing create(List<PrefixModifier> modifiers) {
    return Spacing(cssClass, modifiers: modifiers);
  }

  /// Helper to format value for Tailwind class (e.g., 2.5 -> 2.5, 2.0 -> 2)
  static String _formatValue(double value) {
    if (value == value.truncate()) {
      return value.truncate().toString();
    }
    return value.toString();
  }

  // --- STATIC PREDEFINED VALUES ---
  // Comprehensive list based on Tailwind's default spacing scale.

  // Margin (All directions)
  static const Spacing m0 = Spacing('m-0');
  static const Spacing m1 = Spacing('m-1');
  static const Spacing m2 = Spacing('m-2');
  static const Spacing m3 = Spacing('m-3');
  static const Spacing m4 = Spacing('m-4');
  static const Spacing m5 = Spacing('m-5');
  static const Spacing m6 = Spacing('m-6');
  static const Spacing m8 = Spacing('m-8');
  static const Spacing m10 = Spacing('m-10');
  static const Spacing m12 = Spacing('m-12');
  static const Spacing m16 = Spacing('m-16');
  static const Spacing m20 = Spacing('m-20');
  static const Spacing m24 = Spacing('m-24');
  static const Spacing m32 = Spacing('m-32');
  static const Spacing m40 = Spacing('m-40');
  static const Spacing m48 = Spacing('m-48');
  static const Spacing m56 = Spacing('m-56');
  static const Spacing m64 = Spacing('m-64');
  static const Spacing mAuto = Spacing('m-auto');

  // Margin (X-axis)
  static const Spacing mx0 = Spacing('mx-0');
  static const Spacing mx1 = Spacing('mx-1');
  static const Spacing mx2 = Spacing('mx-2');
  static const Spacing mx3 = Spacing('mx-3');
  static const Spacing mx4 = Spacing('mx-4');
  static const Spacing mx5 = Spacing('mx-5');
  static const Spacing mx6 = Spacing('mx-6');
  static const Spacing mx8 = Spacing('mx-8');
  static const Spacing mx10 = Spacing('mx-10');
  static const Spacing mx12 = Spacing('mx-12');
  static const Spacing mx16 = Spacing('mx-16');
  static const Spacing mxAuto = Spacing('mx-auto');

  // Margin (Y-axis)
  static const Spacing my0 = Spacing('my-0');
  static const Spacing my1 = Spacing('my-1');
  static const Spacing my2 = Spacing('my-2');
  static const Spacing my3 = Spacing('my-3');
  static const Spacing my4 = Spacing('my-4');
  static const Spacing my5 = Spacing('my-5');
  static const Spacing my6 = Spacing('my-6');
  static const Spacing my8 = Spacing('my-8');
  static const Spacing my10 = Spacing('my-10');
  static const Spacing my12 = Spacing('my-12');
  static const Spacing my16 = Spacing('my-16');
  static const Spacing myAuto = Spacing('my-auto');

  // Margin (Top)
  static const Spacing mt0 = Spacing('mt-0');
  static const Spacing mt1 = Spacing('mt-1');
  static const Spacing mt2 = Spacing('mt-2');
  static const Spacing mt3 = Spacing('mt-3');
  static const Spacing mt4 = Spacing('mt-4');
  static const Spacing mt5 = Spacing('mt-5');
  static const Spacing mt6 = Spacing('mt-6');
  static const Spacing mt8 = Spacing('mt-8');
  static const Spacing mt10 = Spacing('mt-10');
  static const Spacing mt12 = Spacing('mt-12');
  static const Spacing mt16 = Spacing('mt-16');
  static const Spacing mt20 = Spacing('mt-20');
  static const Spacing mt24 = Spacing('mt-24');
  static const Spacing mt32 = Spacing('mt-32');
  static const Spacing mt40 = Spacing('mt-40');
  static const Spacing mtAuto = Spacing('mt-auto');

  // Margin (Bottom)
  static const Spacing mb0 = Spacing('mb-0');
  static const Spacing mb1 = Spacing('mb-1');
  static const Spacing mb2 = Spacing('mb-2');
  static const Spacing mb3 = Spacing('mb-3');
  static const Spacing mb4 = Spacing('mb-4');
  static const Spacing mb5 = Spacing('mb-5');
  static const Spacing mb6 = Spacing('mb-6');
  static const Spacing mb8 = Spacing('mb-8');
  static const Spacing mb10 = Spacing('mb-10');
  static const Spacing mb12 = Spacing('mb-12');
  static const Spacing mb16 = Spacing('mb-16');
  static const Spacing mb20 = Spacing('mb-20');
  static const Spacing mb24 = Spacing('mb-24');
  static const Spacing mb32 = Spacing('mb-32');
  static const Spacing mb40 = Spacing('mb-40');
  static const Spacing mbAuto = Spacing('mb-auto');

  // Padding (All directions)
  static const Spacing p0 = Spacing('p-0');
  static const Spacing p1 = Spacing('p-1');
  static const Spacing p2 = Spacing('p-2');
  static const Spacing p3 = Spacing('p-3');
  static const Spacing p4 = Spacing('p-4');
  static const Spacing p5 = Spacing('p-5');
  static const Spacing p6 = Spacing('p-6');
  static const Spacing p8 = Spacing('p-8');
  static const Spacing p10 = Spacing('p-10');
  static const Spacing p12 = Spacing('p-12');
  static const Spacing p16 = Spacing('p-16');
  static const Spacing p20 = Spacing('p-20');

  // Padding (X-axis)
  static const Spacing px0 = Spacing('px-0');
  static const Spacing px1 = Spacing('px-1');
  static const Spacing px2 = Spacing('px-2');
  static const Spacing px3 = Spacing('px-3');
  static const Spacing px4 = Spacing('px-4');
  static const Spacing px5 = Spacing('px-5');
  static const Spacing px6 = Spacing('px-6');
  static const Spacing px8 = Spacing('px-8');
  static const Spacing px10 = Spacing('px-10');
  static const Spacing px12 = Spacing('px-12');
  static const Spacing px16 = Spacing('px-16');

  // Padding (Y-axis)
  static const Spacing py0 = Spacing('py-0');
  static const Spacing py1 = Spacing('py-1');
  static const Spacing py2 = Spacing('py-2');
  static const Spacing py3 = Spacing('py-3');
  static const Spacing py4 = Spacing('py-4');
  static const Spacing py5 = Spacing('py-5');
  static const Spacing py6 = Spacing('py-6');
  static const Spacing py8 = Spacing('py-8');
  static const Spacing py10 = Spacing('py-10');
  static const Spacing py12 = Spacing('py-12');
  static const Spacing py16 = Spacing('py-16');

  // Padding (Top)
  static const Spacing pt0 = Spacing('pt-0');
  static const Spacing pt1 = Spacing('pt-1');
  static const Spacing pt2 = Spacing('pt-2');
  static const Spacing pt4 = Spacing('pt-4');
  static const Spacing pt6 = Spacing('pt-6');
  static const Spacing pt8 = Spacing('pt-8');
  static const Spacing pt10 = Spacing('pt-10');

  // Padding (Bottom)
  static const Spacing pb0 = Spacing('pb-0');
  static const Spacing pb1 = Spacing('pb-1');
  static const Spacing pb2 = Spacing('pb-2');
  static const Spacing pb4 = Spacing('pb-4');
  static const Spacing pb6 = Spacing('pb-6');
  static const Spacing pb8 = Spacing('pb-8');
  static const Spacing pb10 = Spacing('pb-10');
}
