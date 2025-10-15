import '../common_style.dart';
import '../style_type.dart' show StyleType;
import '../ui_prefix_modifier.dart';

/// A utility class for applying background styles, including colors and opacity.
class BgUtil extends CommonStyle<BgUtil> {
  const BgUtil(super.cssClass, {super.modifiers}) : super(type: StyleType.style);

  /// Creates a background opacity utility. `bg-opacity-{value}`
  ///
  /// [value]: The opacity percentage. Must be between 0 and 100,
  /// and a multiple of 5 (e.g., 0, 5, 10, ..., 95, 100).
  const BgUtil.opacity(int value)
    : assert(
        value >= 0 && value <= 100 && value % 5 == 0,
        'Opacity value must be between 0 and 100, in steps of 5.',
      ),
      super('bg-opacity-$value', type: StyleType.style);

  // --- Base Colors ---
  /// `background-color: base-100`
  static const BgUtil base100 = BgUtil('bg-base-100');

  /// `background-color: base-200`
  static const BgUtil base200 = BgUtil('bg-base-200');

  /// `background-color: base-300`
  static const BgUtil base300 = BgUtil('bg-base-300');

  // --- Theme Colors ---
  /// `background-color: primary`
  static const BgUtil primary = BgUtil('bg-primary');

  /// `background-color: secondary`
  static const BgUtil secondary = BgUtil('bg-secondary');

  /// `background-color: accent`
  static const BgUtil accent = BgUtil('bg-accent');

  /// `background-color: neutral`
  static const BgUtil neutral = BgUtil('bg-neutral');

  // --- State Colors ---
  /// `background-color: info`
  static const BgUtil info = BgUtil('bg-info');

  /// `background-color: success`
  static const BgUtil success = BgUtil('bg-success');

  /// `background-color: warning`
  static const BgUtil warning = BgUtil('bg-warning');

  /// `background-color: error`
  static const BgUtil error = BgUtil('bg-error');

  // --- Opacity ---
  /// `background-opacity: 0.75`
  static const BgUtil opacity75 = BgUtil('bg-opacity-75');

  /// `background-opacity: 0.60`
  static const BgUtil opacity60 = BgUtil('bg-opacity-60');

  /// `background-opacity: 0.50`
  static const BgUtil opacity50 = BgUtil('bg-opacity-50');

  /// `background-opacity: 0.25`
  static const BgUtil opacity25 = BgUtil('bg-opacity-25');

  /// `background-opacity: 0`
  static const BgUtil opacity0 = BgUtil('bg-opacity-0');

  // --- Attachment ---
  /// `background-attachment: fixed`
  static const BgUtil fixed = BgUtil('bg-fixed');

  /// `background-attachment: local`
  static const BgUtil local = BgUtil('bg-local');

  /// `background-color: transparent`
  static const BgUtil transparent = BgUtil('bg-transparent');

  /// `background-color: black`
  static const BgUtil black = BgUtil('bg-black');

  /// `background-color: white`
  static const BgUtil white = BgUtil('bg-white');

  // --- Slate ---
  /// `background-color: slate-50`
  static const BgUtil slate50 = BgUtil('bg-slate-50');
  /// `background-color: slate-100`
  static const BgUtil slate100 = BgUtil('bg-slate-100');
  /// `background-color: slate-200`
  static const BgUtil slate200 = BgUtil('bg-slate-200');
  /// `background-color: slate-300`
  static const BgUtil slate300 = BgUtil('bg-slate-300');
  /// `background-color: slate-400`
  static const BgUtil slate400 = BgUtil('bg-slate-400');
  /// `background-color: slate-500`
  static const BgUtil slate500 = BgUtil('bg-slate-500');
  /// `background-color: slate-600`
  static const BgUtil slate600 = BgUtil('bg-slate-600');
  /// `background-color: slate-700`
  static const BgUtil slate700 = BgUtil('bg-slate-700');
  /// `background-color: slate-800`
  static const BgUtil slate800 = BgUtil('bg-slate-800');
  /// `background-color: slate-900`
  static const BgUtil slate900 = BgUtil('bg-slate-900');
  /// `background-color: slate-950`
  static const BgUtil slate950 = BgUtil('bg-slate-950');

  // --- Gray ---
  /// `background-color: gray-50`
  static const BgUtil gray50 = BgUtil('bg-gray-50');
  /// `background-color: gray-100`
  static const BgUtil gray100 = BgUtil('bg-gray-100');
  /// `background-color: gray-200`
  static const BgUtil gray200 = BgUtil('bg-gray-200');
  /// `background-color: gray-300`
  static const BgUtil gray300 = BgUtil('bg-gray-300');
  /// `background-color: gray-400`
  static const BgUtil gray400 = BgUtil('bg-gray-400');
  /// `background-color: gray-500`
  static const BgUtil gray500 = BgUtil('bg-gray-500');
  /// `background-color: gray-600`
  static const BgUtil gray600 = BgUtil('bg-gray-600');
  /// `background-color: gray-700`
  static const BgUtil gray700 = BgUtil('bg-gray-700');
  /// `background-color: gray-800`
  static const BgUtil gray800 = BgUtil('bg-gray-800');
  /// `background-color: gray-900`
  static const BgUtil gray900 = BgUtil('bg-gray-900');
  /// `background-color: gray-950`
  static const BgUtil gray950 = BgUtil('bg-gray-950');

  // --- Zinc ---
  /// `background-color: zinc-50`
  static const BgUtil zinc50 = BgUtil('bg-zinc-50');
  /// `background-color: zinc-100`
  static const BgUtil zinc100 = BgUtil('bg-zinc-100');
  /// `background-color: zinc-200`
  static const BgUtil zinc200 = BgUtil('bg-zinc-200');
  /// `background-color: zinc-300`
  static const BgUtil zinc300 = BgUtil('bg-zinc-300');
  /// `background-color: zinc-400`
  static const BgUtil zinc400 = BgUtil('bg-zinc-400');
  /// `background-color: zinc-500`
  static const BgUtil zinc500 = BgUtil('bg-zinc-500');
  /// `background-color: zinc-600`
  static const BgUtil zinc600 = BgUtil('bg-zinc-600');
  /// `background-color: zinc-700`
  static const BgUtil zinc700 = BgUtil('bg-zinc-700');
  /// `background-color: zinc-800`
  static const BgUtil zinc800 = BgUtil('bg-zinc-800');
  /// `background-color: zinc-900`
  static const BgUtil zinc900 = BgUtil('bg-zinc-900');
  /// `background-color: zinc-950`
  static const BgUtil zinc950 = BgUtil('bg-zinc-950');

  // --- Neutral ---
  /// `background-color: neutral-50`
  static const BgUtil neutral50 = BgUtil('bg-neutral-50');
  /// `background-color: neutral-100`
  static const BgUtil neutral100 = BgUtil('bg-neutral-100');
  /// `background-color: neutral-200`
  static const BgUtil neutral200 = BgUtil('bg-neutral-200');
  /// `background-color: neutral-300`
  static const BgUtil neutral300 = BgUtil('bg-neutral-300');
  /// `background-color: neutral-400`
  static const BgUtil neutral400 = BgUtil('bg-neutral-400');
  /// `background-color: neutral-500`
  static const BgUtil neutral500 = BgUtil('bg-neutral-500');
  /// `background-color: neutral-600`
  static const BgUtil neutral600 = BgUtil('bg-neutral-600');
  /// `background-color: neutral-700`
  static const BgUtil neutral700 = BgUtil('bg-neutral-700');
  /// `background-color: neutral-800`
  static const BgUtil neutral800 = BgUtil('bg-neutral-800');
  /// `background-color: neutral-900`
  static const BgUtil neutral900 = BgUtil('bg-neutral-900');
  /// `background-color: neutral-950`
  static const BgUtil neutral950 = BgUtil('bg-neutral-950');

  // --- Stone ---
  /// `background-color: stone-50`
  static const BgUtil stone50 = BgUtil('bg-stone-50');
  /// `background-color: stone-100`
  static const BgUtil stone100 = BgUtil('bg-stone-100');
  /// `background-color: stone-200`
  static const BgUtil stone200 = BgUtil('bg-stone-200');
  /// `background-color: stone-300`
  static const BgUtil stone300 = BgUtil('bg-stone-300');
  /// `background-color: stone-400`
  static const BgUtil stone400 = BgUtil('bg-stone-400');
  /// `background-color: stone-500`
  static const BgUtil stone500 = BgUtil('bg-stone-500');
  /// `background-color: stone-600`
  static const BgUtil stone600 = BgUtil('bg-stone-600');
  /// `background-color: stone-700`
  static const BgUtil stone700 = BgUtil('bg-stone-700');
  /// `background-color: stone-800`
  static const BgUtil stone800 = BgUtil('bg-stone-800');
  /// `background-color: stone-900`
  static const BgUtil stone900 = BgUtil('bg-stone-900');
  /// `background-color: stone-950`
  static const BgUtil stone950 = BgUtil('bg-stone-950');

  // --- Red ---
  /// `background-color: red-50`
  static const BgUtil red50 = BgUtil('bg-red-50');
  /// `background-color: red-100`
  static const BgUtil red100 = BgUtil('bg-red-100');
  /// `background-color: red-200`
  static const BgUtil red200 = BgUtil('bg-red-200');
  /// `background-color: red-300`
  static const BgUtil red300 = BgUtil('bg-red-300');
  /// `background-color: red-400`
  static const BgUtil red400 = BgUtil('bg-red-400');
  /// `background-color: red-500`
  static const BgUtil red500 = BgUtil('bg-red-500');
  /// `background-color: red-600`
  static const BgUtil red600 = BgUtil('bg-red-600');
  /// `background-color: red-700`
  static const BgUtil red700 = BgUtil('bg-red-700');
  /// `background-color: red-800`
  static const BgUtil red800 = BgUtil('bg-red-800');
  /// `background-color: red-900`
  static const BgUtil red900 = BgUtil('bg-red-900');
  /// `background-color: red-950`
  static const BgUtil red950 = BgUtil('bg-red-950');

  // --- Orange ---
  /// `background-color: orange-50`
  static const BgUtil orange50 = BgUtil('bg-orange-50');
  /// `background-color: orange-100`
  static const BgUtil orange100 = BgUtil('bg-orange-100');
  /// `background-color: orange-200`
  static const BgUtil orange200 = BgUtil('bg-orange-200');
  /// `background-color: orange-300`
  static const BgUtil orange300 = BgUtil('bg-orange-300');
  /// `background-color: orange-400`
  static const BgUtil orange400 = BgUtil('bg-orange-400');
  /// `background-color: orange-500`
  static const BgUtil orange500 = BgUtil('bg-orange-500');
  /// `background-color: orange-600`
  static const BgUtil orange600 = BgUtil('bg-orange-600');
  /// `background-color: orange-700`
  static const BgUtil orange700 = BgUtil('bg-orange-700');
  /// `background-color: orange-800`
  static const BgUtil orange800 = BgUtil('bg-orange-800');
  /// `background-color: orange-900`
  static const BgUtil orange900 = BgUtil('bg-orange-900');
  /// `background-color: orange-950`
  static const BgUtil orange950 = BgUtil('bg-orange-950');

  // --- Amber ---
  /// `background-color: amber-50`
  static const BgUtil amber50 = BgUtil('bg-amber-50');
  /// `background-color: amber-100`
  static const BgUtil amber100 = BgUtil('bg-amber-100');
  /// `background-color: amber-200`
  static const BgUtil amber200 = BgUtil('bg-amber-200');
  /// `background-color: amber-300`
  static const BgUtil amber300 = BgUtil('bg-amber-300');
  /// `background-color: amber-400`
  static const BgUtil amber400 = BgUtil('bg-amber-400');
  /// `background-color: amber-500`
  static const BgUtil amber500 = BgUtil('bg-amber-500');
  /// `background-color: amber-600`
  static const BgUtil amber600 = BgUtil('bg-amber-600');
  /// `background-color: amber-700`
  static const BgUtil amber700 = BgUtil('bg-amber-700');
  /// `background-color: amber-800`
  static const BgUtil amber800 = BgUtil('bg-amber-800');
  /// `background-color: amber-900`
  static const BgUtil amber900 = BgUtil('bg-amber-900');
  /// `background-color: amber-950`
  static const BgUtil amber950 = BgUtil('bg-amber-950');

  // --- Yellow ---
  /// `background-color: yellow-50`
  static const BgUtil yellow50 = BgUtil('bg-yellow-50');
  /// `background-color: yellow-100`
  static const BgUtil yellow100 = BgUtil('bg-yellow-100');
  /// `background-color: yellow-200`
  static const BgUtil yellow200 = BgUtil('bg-yellow-200');
  /// `background-color: yellow-300`
  static const BgUtil yellow300 = BgUtil('bg-yellow-300');
  /// `background-color: yellow-400`
  static const BgUtil yellow400 = BgUtil('bg-yellow-400');
  /// `background-color: yellow-500`
  static const BgUtil yellow500 = BgUtil('bg-yellow-500');
  /// `background-color: yellow-600`
  static const BgUtil yellow600 = BgUtil('bg-yellow-600');
  /// `background-color: yellow-700`
  static const BgUtil yellow700 = BgUtil('bg-yellow-700');
  /// `background-color: yellow-800`
  static const BgUtil yellow800 = BgUtil('bg-yellow-800');
  /// `background-color: yellow-900`
  static const BgUtil yellow900 = BgUtil('bg-yellow-900');
  /// `background-color: yellow-950`
  static const BgUtil yellow950 = BgUtil('bg-yellow-950');

  // --- Lime ---
  /// `background-color: lime-50`
  static const BgUtil lime50 = BgUtil('bg-lime-50');
  /// `background-color: lime-100`
  static const BgUtil lime100 = BgUtil('bg-lime-100');
  /// `background-color: lime-200`
  static const BgUtil lime200 = BgUtil('bg-lime-200');
  /// `background-color: lime-300`
  static const BgUtil lime300 = BgUtil('bg-lime-300');
  /// `background-color: lime-400`
  static const BgUtil lime400 = BgUtil('bg-lime-400');
  /// `background-color: lime-500`
  static const BgUtil lime500 = BgUtil('bg-lime-500');
  /// `background-color: lime-600`
  static const BgUtil lime600 = BgUtil('bg-lime-600');
  /// `background-color: lime-700`
  static const BgUtil lime700 = BgUtil('bg-lime-700');
  /// `background-color: lime-800`
  static const BgUtil lime800 = BgUtil('bg-lime-800');
  /// `background-color: lime-900`
  static const BgUtil lime900 = BgUtil('bg-lime-900');
  /// `background-color: lime-950`
  static const BgUtil lime950 = BgUtil('bg-lime-950');

  // --- Green ---
  /// `background-color: green-50`
  static const BgUtil green50 = BgUtil('bg-green-50');
  /// `background-color: green-100`
  static const BgUtil green100 = BgUtil('bg-green-100');
  /// `background-color: green-200`
  static const BgUtil green200 = BgUtil('bg-green-200');
  /// `background-color: green-300`
  static const BgUtil green300 = BgUtil('bg-green-300');
  /// `background-color: green-400`
  static const BgUtil green400 = BgUtil('bg-green-400');
  /// `background-color: green-500`
  static const BgUtil green500 = BgUtil('bg-green-500');
  /// `background-color: green-600`
  static const BgUtil green600 = BgUtil('bg-green-600');
  /// `background-color: green-700`
  static const BgUtil green700 = BgUtil('bg-green-700');
  /// `background-color: green-800`
  static const BgUtil green800 = BgUtil('bg-green-800');
  /// `background-color: green-900`
  static const BgUtil green900 = BgUtil('bg-green-900');
  /// `background-color: green-950`
  static const BgUtil green950 = BgUtil('bg-green-950');

  // --- Emerald ---
  /// `background-color: emerald-50`
  static const BgUtil emerald50 = BgUtil('bg-emerald-50');
  /// `background-color: emerald-100`
  static const BgUtil emerald100 = BgUtil('bg-emerald-100');
  /// `background-color: emerald-200`
  static const BgUtil emerald200 = BgUtil('bg-emerald-200');
  /// `background-color: emerald-300`
  static const BgUtil emerald300 = BgUtil('bg-emerald-300');
  /// `background-color: emerald-400`
  static const BgUtil emerald400 = BgUtil('bg-emerald-400');
  /// `background-color: emerald-500`
  static const BgUtil emerald500 = BgUtil('bg-emerald-500');
  /// `background-color: emerald-600`
  static const BgUtil emerald600 = BgUtil('bg-emerald-600');
  /// `background-color: emerald-700`
  static const BgUtil emerald700 = BgUtil('bg-emerald-700');
  /// `background-color: emerald-800`
  static const BgUtil emerald800 = BgUtil('bg-emerald-800');
  /// `background-color: emerald-900`
  static const BgUtil emerald900 = BgUtil('bg-emerald-900');
  /// `background-color: emerald-950`
  static const BgUtil emerald950 = BgUtil('bg-emerald-950');

  // --- Teal ---
  /// `background-color: teal-50`
  static const BgUtil teal50 = BgUtil('bg-teal-50');
  /// `background-color: teal-100`
  static const BgUtil teal100 = BgUtil('bg-teal-100');
  /// `background-color: teal-200`
  static const BgUtil teal200 = BgUtil('bg-teal-200');
  /// `background-color: teal-300`
  static const BgUtil teal300 = BgUtil('bg-teal-300');
  /// `background-color: teal-400`
  static const BgUtil teal400 = BgUtil('bg-teal-400');
  /// `background-color: teal-500`
  static const BgUtil teal500 = BgUtil('bg-teal-500');
  /// `background-color: teal-600`
  static const BgUtil teal600 = BgUtil('bg-teal-600');
  /// `background-color: teal-700`
  static const BgUtil teal700 = BgUtil('bg-teal-700');
  /// `background-color: teal-800`
  static const BgUtil teal800 = BgUtil('bg-teal-800');
  /// `background-color: teal-900`
  static const BgUtil teal900 = BgUtil('bg-teal-900');
  /// `background-color: teal-950`
  static const BgUtil teal950 = BgUtil('bg-teal-950');

  // --- Cyan ---
  /// `background-color: cyan-50`
  static const BgUtil cyan50 = BgUtil('bg-cyan-50');
  /// `background-color: cyan-100`
  static const BgUtil cyan100 = BgUtil('bg-cyan-100');
  /// `background-color: cyan-200`
  static const BgUtil cyan200 = BgUtil('bg-cyan-200');
  /// `background-color: cyan-300`
  static const BgUtil cyan300 = BgUtil('bg-cyan-300');
  /// `background-color: cyan-400`
  static const BgUtil cyan400 = BgUtil('bg-cyan-400');
  /// `background-color: cyan-500`
  static const BgUtil cyan500 = BgUtil('bg-cyan-500');
  /// `background-color: cyan-600`
  static const BgUtil cyan600 = BgUtil('bg-cyan-600');
  /// `background-color: cyan-700`
  static const BgUtil cyan700 = BgUtil('bg-cyan-700');
  /// `background-color: cyan-800`
  static const BgUtil cyan800 = BgUtil('bg-cyan-800');
  /// `background-color: cyan-900`
  static const BgUtil cyan900 = BgUtil('bg-cyan-900');
  /// `background-color: cyan-950`
  static const BgUtil cyan950 = BgUtil('bg-cyan-950');

  // --- Sky ---
  /// `background-color: sky-50`
  static const BgUtil sky50 = BgUtil('bg-sky-50');
  /// `background-color: sky-100`
  static const BgUtil sky100 = BgUtil('bg-sky-100');
  /// `background-color: sky-200`
  static const BgUtil sky200 = BgUtil('bg-sky-200');
  /// `background-color: sky-300`
  static const BgUtil sky300 = BgUtil('bg-sky-300');
  /// `background-color: sky-400`
  static const BgUtil sky400 = BgUtil('bg-sky-400');
  /// `background-color: sky-500`
  static const BgUtil sky500 = BgUtil('bg-sky-500');
  /// `background-color: sky-600`
  static const BgUtil sky600 = BgUtil('bg-sky-600');
  /// `background-color: sky-700`
  static const BgUtil sky700 = BgUtil('bg-sky-700');
  /// `background-color: sky-800`
  static const BgUtil sky800 = BgUtil('bg-sky-800');
  /// `background-color: sky-900`
  static const BgUtil sky900 = BgUtil('bg-sky-900');
  /// `background-color: sky-950`
  static const BgUtil sky950 = BgUtil('bg-sky-950');

  // --- Blue ---
  /// `background-color: blue-50`
  static const BgUtil blue50 = BgUtil('bg-blue-50');
  /// `background-color: blue-100`
  static const BgUtil blue100 = BgUtil('bg-blue-100');
  /// `background-color: blue-200`
  static const BgUtil blue200 = BgUtil('bg-blue-200');
  /// `background-color: blue-300`
  static const BgUtil blue300 = BgUtil('bg-blue-300');
  /// `background-color: blue-400`
  static const BgUtil blue400 = BgUtil('bg-blue-400');
  /// `background-color: blue-500`
  static const BgUtil blue500 = BgUtil('bg-blue-500');
  /// `background-color: blue-600`
  static const BgUtil blue600 = BgUtil('bg-blue-600');
  /// `background-color: blue-700`
  static const BgUtil blue700 = BgUtil('bg-blue-700');
  /// `background-color: blue-800`
  static const BgUtil blue800 = BgUtil('bg-blue-800');
  /// `background-color: blue-900`
  static const BgUtil blue900 = BgUtil('bg-blue-900');
  /// `background-color: blue-950`
  static const BgUtil blue950 = BgUtil('bg-blue-950');

  // --- Indigo ---
  /// `background-color: indigo-50`
  static const BgUtil indigo50 = BgUtil('bg-indigo-50');
  /// `background-color: indigo-100`
  static const BgUtil indigo100 = BgUtil('bg-indigo-100');
  /// `background-color: indigo-200`
  static const BgUtil indigo200 = BgUtil('bg-indigo-200');
  /// `background-color: indigo-300`
  static const BgUtil indigo300 = BgUtil('bg-indigo-300');
  /// `background-color: indigo-400`
  static const BgUtil indigo400 = BgUtil('bg-indigo-400');
  /// `background-color: indigo-500`
  static const BgUtil indigo500 = BgUtil('bg-indigo-500');
  /// `background-color: indigo-600`
  static const BgUtil indigo600 = BgUtil('bg-indigo-600');
  /// `background-color: indigo-700`
  static const BgUtil indigo700 = BgUtil('bg-indigo-700');
  /// `background-color: indigo-800`
  static const BgUtil indigo800 = BgUtil('bg-indigo-800');
  /// `background-color: indigo-900`
  static const BgUtil indigo900 = BgUtil('bg-indigo-900');
  /// `background-color: indigo-950`
  static const BgUtil indigo950 = BgUtil('bg-indigo-950');

  // --- Violet ---
  /// `background-color: violet-50`
  static const BgUtil violet50 = BgUtil('bg-violet-50');
  /// `background-color: violet-100`
  static const BgUtil violet100 = BgUtil('bg-violet-100');
  /// `background-color: violet-200`
  static const BgUtil violet200 = BgUtil('bg-violet-200');
  /// `background-color: violet-300`
  static const BgUtil violet300 = BgUtil('bg-violet-300');
  /// `background-color: violet-400`
  static const BgUtil violet400 = BgUtil('bg-violet-400');
  /// `background-color: violet-500`
  static const BgUtil violet500 = BgUtil('bg-violet-500');
  /// `background-color: violet-600`
  static const BgUtil violet600 = BgUtil('bg-violet-600');
  /// `background-color: violet-700`
  static const BgUtil violet700 = BgUtil('bg-violet-700');
  /// `background-color: violet-800`
  static const BgUtil violet800 = BgUtil('bg-violet-800');
  /// `background-color: violet-900`
  static const BgUtil violet900 = BgUtil('bg-violet-900');
  /// `background-color: violet-950`
  static const BgUtil violet950 = BgUtil('bg-violet-950');

  // --- Purple ---
  /// `background-color: purple-50`
  static const BgUtil purple50 = BgUtil('bg-purple-50');
  /// `background-color: purple-100`
  static const BgUtil purple100 = BgUtil('bg-purple-100');
  /// `background-color: purple-200`
  static const BgUtil purple200 = BgUtil('bg-purple-200');
  /// `background-color: purple-300`
  static const BgUtil purple300 = BgUtil('bg-purple-300');
  /// `background-color: purple-400`
  static const BgUtil purple400 = BgUtil('bg-purple-400');
  /// `background-color: purple-500`
  static const BgUtil purple500 = BgUtil('bg-purple-500');
  /// `background-color: purple-600`
  static const BgUtil purple600 = BgUtil('bg-purple-600');
  /// `background-color: purple-700`
  static const BgUtil purple700 = BgUtil('bg-purple-700');
  /// `background-color: purple-800`
  static const BgUtil purple800 = BgUtil('bg-purple-800');
  /// `background-color: purple-900`
  static const BgUtil purple900 = BgUtil('bg-purple-900');
  /// `background-color: purple-950`
  static const BgUtil purple950 = BgUtil('bg-purple-950');

  // --- Fuchsia ---
  /// `background-color: fuchsia-50`
  static const BgUtil fuchsia50 = BgUtil('bg-fuchsia-50');
  /// `background-color: fuchsia-100`
  static const BgUtil fuchsia100 = BgUtil('bg-fuchsia-100');
  /// `background-color: fuchsia-200`
  static const BgUtil fuchsia200 = BgUtil('bg-fuchsia-200');
  /// `background-color: fuchsia-300`
  static const BgUtil fuchsia300 = BgUtil('bg-fuchsia-300');
  /// `background-color: fuchsia-400`
  static const BgUtil fuchsia400 = BgUtil('bg-fuchsia-400');
  /// `background-color: fuchsia-500`
  static const BgUtil fuchsia500 = BgUtil('bg-fuchsia-500');
  /// `background-color: fuchsia-600`
  static const BgUtil fuchsia600 = BgUtil('bg-fuchsia-600');
  /// `background-color: fuchsia-700`
  static const BgUtil fuchsia700 = BgUtil('bg-fuchsia-700');
  /// `background-color: fuchsia-800`
  static const BgUtil fuchsia800 = BgUtil('bg-fuchsia-800');
  /// `background-color: fuchsia-900`
  static const BgUtil fuchsia900 = BgUtil('bg-fuchsia-900');
  /// `background-color: fuchsia-950`
  static const BgUtil fuchsia950 = BgUtil('bg-fuchsia-950');

  // --- Pink ---
  /// `background-color: pink-50`
  static const BgUtil pink50 = BgUtil('bg-pink-50');
  /// `background-color: pink-100`
  static const BgUtil pink100 = BgUtil('bg-pink-100');
  /// `background-color: pink-200`
  static const BgUtil pink200 = BgUtil('bg-pink-200');
  /// `background-color: pink-300`
  static const BgUtil pink300 = BgUtil('bg-pink-300');
  /// `background-color: pink-400`
  static const BgUtil pink400 = BgUtil('bg-pink-400');
  /// `background-color: pink-500`
  static const BgUtil pink500 = BgUtil('bg-pink-500');
  /// `background-color: pink-600`
  static const BgUtil pink600 = BgUtil('bg-pink-600');
  /// `background-color: pink-700`
  static const BgUtil pink700 = BgUtil('bg-pink-700');
  /// `background-color: pink-800`
  static const BgUtil pink800 = BgUtil('bg-pink-800');
  /// `background-color: pink-900`
  static const BgUtil pink900 = BgUtil('bg-pink-900');
  /// `background-color: pink-950`
  static const BgUtil pink950 = BgUtil('bg-pink-950');

  // --- Rose ---
  /// `background-color: rose-50`
  static const BgUtil rose50 = BgUtil('bg-rose-50');
  /// `background-color: rose-100`
  static const BgUtil rose100 = BgUtil('bg-rose-100');
  /// `background-color: rose-200`
  static const BgUtil rose200 = BgUtil('bg-rose-200');
  /// `background-color: rose-300`
  static const BgUtil rose300 = BgUtil('bg-rose-300');
  /// `background-color: rose-400`
  static const BgUtil rose400 = BgUtil('bg-rose-400');
  /// `background-color: rose-500`
  static const BgUtil rose500 = BgUtil('bg-rose-500');
  /// `background-color: rose-600`
  static const BgUtil rose600 = BgUtil('bg-rose-600');
  /// `background-color: rose-700`
  static const BgUtil rose700 = BgUtil('bg-rose-700');
  /// `background-color: rose-800`
  static const BgUtil rose800 = BgUtil('bg-rose-800');
  /// `background-color: rose-900`
  static const BgUtil rose900 = BgUtil('bg-rose-900');
  /// `background-color: rose-950`
  static const BgUtil rose950 = BgUtil('bg-rose-950');

  @override
  BgUtil create(List<PrefixModifier> modifiers) {
    return BgUtil(cssClass, modifiers: modifiers);
  }
}
