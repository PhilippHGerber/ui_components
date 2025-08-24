import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

class FontUtil extends CommonStyle<FontUtil> {
  const FontUtil(super.cssClass, {super.modifiers})
      : super(type: StyleType.typography);
  @override
  FontUtil create(List<PrefixModifier> modifiers) {
    return FontUtil(cssClass, modifiers: modifiers);
  }

  // --- Font Weight ---
  static const FontUtil thin = FontUtil('font-thin');
  static const FontUtil extralight = FontUtil('font-extralight');
  static const FontUtil light = FontUtil('font-light');
  static const FontUtil normal = FontUtil('font-normal');
  static const FontUtil medium = FontUtil('font-medium');
  static const FontUtil semibold = FontUtil('font-semibold');
  static const FontUtil bold = FontUtil('font-bold');
  static const FontUtil extrabold = FontUtil('font-extrabold');
  static const FontUtil black = FontUtil('font-black');

  // --- Font Style ---
  static const FontUtil italic = FontUtil('italic'); // War in TextUtil
  static const FontUtil notItalic = FontUtil('not-italic'); // War in TextUtil

  // --- Font Family (Beispiel, wenn du das anbieten willst) ---
  // static const FontUtil sans = FontUtil('font-sans');
  // static const FontUtil serif = FontUtil('font-serif');
  // static const FontUtil mono = FontUtil('font-mono');
}
