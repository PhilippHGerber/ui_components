import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import 'theme_controller_style_modifier.dart';

/// Represents a theme that can be used with DaisyUI.
@immutable
class DaisyTheme {
  /// Creates a custom theme.
  ///
  /// The [value] should correspond to a theme name defined in your tailwind.config.js
  const DaisyTheme.custom(this.value);

  /// Factory for creating a theme from a string value.
  factory DaisyTheme.fromValue(String value) {
    return predefined.firstWhere(
      (theme) => theme.value == value,
      orElse: () => DaisyTheme.custom(value),
    );
  }

  const DaisyTheme._(this.value);

  // Predefined DaisyUI Themes
  static const DaisyTheme light = DaisyTheme._('light');
  static const DaisyTheme dark = DaisyTheme._('dark');
  static const DaisyTheme cupcake = DaisyTheme._('cupcake');
  static const DaisyTheme bumblebee = DaisyTheme._('bumblebee');
  static const DaisyTheme emerald = DaisyTheme._('emerald');
  static const DaisyTheme corporate = DaisyTheme._('corporate');
  static const DaisyTheme synthwave = DaisyTheme._('synthwave');
  static const DaisyTheme retro = DaisyTheme._('retro');
  static const DaisyTheme cyberpunk = DaisyTheme._('cyberpunk');
  static const DaisyTheme valentine = DaisyTheme._('valentine');
  static const DaisyTheme halloween = DaisyTheme._('halloween');
  static const DaisyTheme garden = DaisyTheme._('garden');
  static const DaisyTheme forest = DaisyTheme._('forest');
  static const DaisyTheme aqua = DaisyTheme._('aqua');
  static const DaisyTheme lofi = DaisyTheme._('lofi');
  static const DaisyTheme pastel = DaisyTheme._('pastel');
  static const DaisyTheme fantasy = DaisyTheme._('fantasy');
  static const DaisyTheme wireframe = DaisyTheme._('wireframe');
  static const DaisyTheme black = DaisyTheme._('black');
  static const DaisyTheme luxury = DaisyTheme._('luxury');
  static const DaisyTheme dracula = DaisyTheme._('dracula');
  static const DaisyTheme cmyk = DaisyTheme._('cmyk');
  static const DaisyTheme autumn = DaisyTheme._('autumn');
  static const DaisyTheme business = DaisyTheme._('business');
  static const DaisyTheme acid = DaisyTheme._('acid');
  static const DaisyTheme lemonade = DaisyTheme._('lemonade');
  static const DaisyTheme night = DaisyTheme._('night');
  static const DaisyTheme coffee = DaisyTheme._('coffee');
  static const DaisyTheme winter = DaisyTheme._('winter');
  static const DaisyTheme dim = DaisyTheme._('dim');
  static const DaisyTheme nord = DaisyTheme._('nord');
  static const DaisyTheme sunset = DaisyTheme._('sunset');

  /// A list of all predefined themes.
  static List<DaisyTheme> get predefined => const <DaisyTheme>[
    light,
    dark,
    cupcake,
    bumblebee,
    emerald,
    corporate,
    synthwave,
    retro,
    cyberpunk,
    valentine,
    halloween,
    garden,
    forest,
    aqua,
    lofi,
    pastel,
    fantasy,
    wireframe,
    black,
    luxury,
    dracula,
    cmyk,
    autumn,
    business,
    acid,
    lemonade,
    night,
    coffee,
    winter,
    dim,
    nord,
    sunset,
  ];

  /// Checks if this theme is one of the predefined DaisyUI themes.
  bool get isPredefined => predefined.contains(this);

  /// Checks if this is a custom-defined theme.
  bool get isCustom => !isPredefined;
  final String value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DaisyTheme && value == other.value;
  @override
  int get hashCode => value.hashCode;
}

/// Abstract base class for DaisyUI theme controller input elements.
///
/// This component renders an HTML `<input>` (checkbox or radio) that, when
/// interacted with, changes the `data-theme` attribute on the `<html>` element,
/// allowing for dynamic theme switching using the `theme-change` JavaScript library.
///
/// The `modifiers` list accepts [ThemeControllerStyling] (the interface) instances.
abstract class ThemeController extends UiComponent {
  /// Creates a ThemeController.
  ///
  /// - [value]: The [DaisyTheme] this controller represents or activates when selected/checked.
  /// - [toggleTheme]: For checkbox/toggle types, the alternative theme it toggles to.
  ///   If null, the checkbox might toggle between `value` and a default (e.g., a browser default or previously set theme).
  /// - [name]: The HTML `name` attribute, crucial for grouping radio buttons.
  /// - [isChecked]: For radio buttons, whether this option is initially selected.
  /// - [defaultChecked]: For checkbox, whether it's initially checked.
  /// - [transitionDuration]: Optional duration for theme transition animations.
  /// - [style]: A list of [ThemeControllerStyling] (the interface) instances.
  /// - [onChange]: Callback for value changes.
  /// - Other parameters from [UiComponent].
  const ThemeController({
    required this.value,
    required this.name,
    this.toggleTheme,
    this.isChecked = false,
    this.defaultChecked = false,
    this.transitionDuration,
    List<ThemeControllerStyling>? style,
    super.tag = 'input',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.onChange,
    super.key,
  }) : super(null, style: style);

  /// The primary [DaisyTheme] this controller instance represents or sets.
  final DaisyTheme value;

  /// For checkbox-based controllers, this is the theme it toggles to/from.
  /// The `data-toggle-theme` attribute will be set to "[value],[toggleTheme]".
  /// If null, `data-toggle-theme` might just be "[value]".
  final DaisyTheme? toggleTheme;

  /// The HTML `name` attribute for the input element. Essential for radio button groups.
  final String name;

  /// For radio buttons: determines if this radio option is initially selected.
  /// The `checked` HTML attribute will be set if true.
  final bool isChecked;

  /// For checkboxes: determines if the checkbox is initially checked.
  /// The `checked` HTML attribute will be set if true.
  final bool defaultChecked; // Renamed from just 'checked' to avoid conflict

  /// Optional duration for theme transition animations, used for `data-theme-transition`.
  final Duration? transitionDuration;

  @override
  String get baseClass => 'theme-controller';

  /// Must be implemented by subclasses to return "checkbox" or "radio".
  String get inputType;

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    attributes.add('type', inputType);
    attributes.add('name', name);
    attributes.add('value', value.value);

    // Handle 'checked' attribute for both radio and checkbox
    if (inputType == 'radio' && isChecked) {
      attributes.add('checked', '');
    } else if (inputType == 'checkbox' && defaultChecked) {
      attributes.add('checked', '');
    }

    // Attributes for theme-change.js
    attributes.addData('act-class', 'ACTIVE');

    var toggleThemeValue = value.value;
    if (toggleTheme != null) {
      toggleThemeValue = '${value.value},${toggleTheme!.value}';
    } else if (inputType == 'checkbox') {
      // If it's a checkbox and no explicit toggleTheme, it implies toggling
      // the current `value` on/off relative to a default or another theme.
      // theme-change.js might need a pair or will toggle this single theme.
      // For simplicity, if only one theme is given to a checkbox, it often means
      // "apply this theme when checked, remove it (or revert to default) when unchecked".
      // The `data-toggle-theme` might just be the single theme name in this case.
    }
    attributes.addData('toggle-theme', toggleThemeValue);

    if (transitionDuration != null) {
      attributes.addData('theme-transition', '${transitionDuration!.inMilliseconds}ms');
    }
  }
}

/// A [ThemeController] rendered as an HTML `<input type="checkbox">`.
/// Can be styled as a standard checkbox or a toggle switch.
class ThemeControllerCheckbox extends ThemeController {
  /// Creates a ThemeControllerCheckbox.
  ///
  /// - [value]: The [DaisyTheme] to apply when checked (or the first theme in a toggle pair).
  /// - [toggleTheme]: The [DaisyTheme] to apply when unchecked (if it's a two-way toggle).
  ///   If null, checking applies `value`, unchecking might revert to a default or remove `value`.
  /// - [name]: The HTML `name` attribute.
  /// - [defaultChecked]: If true, the checkbox is initially checked.
  /// - [modifiers]: List of [ThemeControllerStyling], can include [ThemeControllerCheckbox.toggleStyle].
  /// - Other parameters from [ThemeController].
  const ThemeControllerCheckbox({
    required super.value,
    required super.name,
    super.toggleTheme, // If null, it toggles 'value' on/off
    super.defaultChecked = false,
    super.transitionDuration,
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.onChange,
    super.key,
  });

  @override
  String get inputType => 'checkbox';

  @override
  ThemeControllerCheckbox copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return ThemeControllerCheckbox(
      value: value,
      name: name,
      toggleTheme: toggleTheme,
      defaultChecked: defaultChecked,
      transitionDuration: transitionDuration,
      style: style as List<ThemeControllerStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      onChange: onChange,
      key: key ?? this.key,
    );
  }

  // --- Static ThemeController Modifiers specific to Checkbox rendering ---
  // (Type: ThemeControllerModifier interface, Instantiating: ThemeControllerStyleModifier)

  /// Styles the checkbox as a toggle switch. `toggle`
  static const ThemeControllerStyle toggle = ThemeControllerStyle('toggle', type: StyleType.style);
}

/// A [ThemeController] rendered as an HTML `<input type="radio">`.
/// Typically used in a group where only one theme can be selected.
class ThemeControllerRadio extends ThemeController {
  /// Creates a ThemeControllerRadio.
  ///
  /// - [value]: The [DaisyTheme] this radio button represents and applies when selected.
  /// - [name]: The HTML `name` attribute; must be the same for all radio buttons in a group.
  /// - [isChecked]: If true, this radio button is initially selected.
  /// - [modifiers]: List of [ThemeControllerStyling], can include [ThemeControllerRadio.button].
  /// - Other parameters from [ThemeController].
  const ThemeControllerRadio({
    required super.value,
    // toggleTheme is not typically used with radio buttons as they are mutually exclusive.
    required super.name,
    super.isChecked = false,
    super.transitionDuration,
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.onChange,
    super.key,
  });

  @override
  String get inputType => 'radio';

  @override
  ThemeControllerRadio copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return ThemeControllerRadio(
      value: value,
      name: name,
      isChecked: isChecked,
      transitionDuration: transitionDuration,
      style: style as List<ThemeControllerStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      onChange: onChange,
      key: key ?? this.key,
    );
  }

  // --- Static ThemeController Modifiers specific to Radio rendering ---

  /// Styles the radio input as a button. `btn`
  static const ThemeControllerStyling button = ThemeControllerStyle('btn', type: StyleType.style);
  // Other button styles (btn-primary, btn-sm) would be applied as general utilities if needed,
  // or more specific ThemeControllerStyleModifiers could be created.
}
