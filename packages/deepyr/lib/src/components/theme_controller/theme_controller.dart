import 'package:jaspr/dom.dart' show InputType, Styles, input;
import 'package:jaspr/jaspr.dart';

import '../../base/stateful_ui_component.dart';
import '../../base/style_type.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'theme_controller_style_modifier.dart';
import 'theme_service.dart';

/// Helper to merge class strings, as the Mixin is not available in the Widget class.
String? _mergeClasses(String? a, String? b) {
  if (a == null || a.isEmpty) return b;
  if (b == null || b.isEmpty) return a;
  return '$a $b';
}

/// Represents a theme that can be used with DaisyUI.
@immutable
class DaisyTheme {
  /// Creates a custom theme.
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
/// This component renders an HTML `<input>` (checkbox or radio) that changes
/// the `data-theme` attribute on the `<html>` element.
///
/// It acts as a **controlled component** that synchronizes with the global theme state.
abstract class ThemeController extends StatefulUiComponent {
  /// Creates a ThemeController.
  ///
  /// - [value]: The [DaisyTheme] this controller represents or activates.
  /// - [toggleTheme]: For checkbox types, the alternative theme it toggles to.
  /// - [name]: The HTML `name` attribute. Essential for radio groups.
  /// - [isChecked]: Determines if the input is checked.
  /// - [transitionDuration]: Optional duration for theme transition animations.
  /// - [style]: A list of [ThemeControllerStyling] instances.
  /// - [onThemeChanged]: Optional callback invoked when this controller successfully changes the theme.
  const ThemeController({
    required this.value,
    required this.name,
    this.toggleTheme,
    this.isChecked = false,
    this.transitionDuration,
    this.onThemeChanged,
    List<ThemeControllerStyling>? style,
    super.tag = 'input',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style);

  /// The primary [DaisyTheme] this controller activates.
  final DaisyTheme value;

  /// For checkbox controllers, the alternate theme.
  final DaisyTheme? toggleTheme;

  /// The HTML `name` attribute.
  final String name;

  /// Whether the input is checked.
  final bool isChecked;

  /// Duration for theme transition animations.
  final Duration? transitionDuration;

  /// Callback when the theme is changed by this controller.
  final ValueChanged<String>? onThemeChanged;

  /// Returns 'checkbox' or 'radio'.
  String get inputType;

  @override
  String get baseClass => 'theme-controller';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    attributes..add('type', inputType)
    ..add('name', name)
    ..add('value', value.value);

    // Attributes for theme-change.js
    var toggleThemeValue = value.value;
    if (toggleTheme != null) {
      toggleThemeValue = '${value.value},${toggleTheme!.value}';
    }
    attributes.addData('toggle-theme', toggleThemeValue);

    if (transitionDuration != null) {
      attributes.addData('theme-transition', '${transitionDuration!.inMilliseconds}ms');
    }
  }
}

class _ThemeControllerState extends StatefulUiComponentState<ThemeController> {
  bool _isChecked = false;

  @override
  String get baseClass => component.baseClass;

  @override
  void initState() {
    super.initState();
    _initCheckedState();
  }

  @override
  void didUpdateComponent(ThemeController oldComponent) {
    super.didUpdateComponent(oldComponent);
    // If the parent explicitly changes isChecked, we update our state.
    if (oldComponent.isChecked != component.isChecked) {
      _isChecked = component.isChecked;
    }
  }

  /// Initializes the checked state.
  /// It prefers the actual active theme from the Service (to handle page reloads/persistence),
  /// but falls back to the [component.isChecked] prop.
  void _initCheckedState() {
    if (!kIsWeb) {
      _isChecked = component.isChecked;
      return;
    }

    final currentTheme = ThemeService.instance.getCurrentTheme();
    if (currentTheme != null) {
      // If we have a verified current theme, match against it.
      _isChecked = currentTheme == component.value.value;
    } else {
      // Otherwise respect the passed prop.
      _isChecked = component.isChecked;
    }
  }

  void _handleOnChange(bool newValue) {
    if (component.inputType == 'radio') {
      // Radio buttons only trigger change when selected
      if (newValue) {
        ThemeService.instance.setTheme(component.value.value);
        component.onThemeChanged?.call(component.value.value);
        setState(() => _isChecked = true);
      }
    } else {
      // Checkbox logic
      if (newValue) {
        // Checked -> Primary Theme
        ThemeService.instance.setTheme(component.value.value);
        component.onThemeChanged?.call(component.value.value);
        setState(() => _isChecked = true);
      } else {
        // Unchecked -> Toggle Theme (or default)
        final target = component.toggleTheme?.value ?? 'default';
        ThemeService.instance.setTheme(target);
        component.onThemeChanged?.call(target);
        setState(() => _isChecked = false);
      }
    }
  }

  @override
  Component build(BuildContext context) {
    return input(
      type: component.inputType == 'checkbox' ? InputType.checkbox : InputType.radio,
      name: component.name,
      value: component.value.value,

      // Controlled state
      checked: _isChecked ? true : null,

      classes: combinedClasses,
      styles: component.css,
      attributes: componentAttributes,

      // Handle change
      onChange: (dynamic val) {
        if (component.inputType == 'checkbox') {
          _handleOnChange(!_isChecked);
        } else {
          _handleOnChange(true);
        }
      },
    );
  }
}

/// A [ThemeController] rendered as an HTML `<input type="checkbox">`.
/// Can be styled as a standard checkbox or a toggle switch.
class ThemeControllerCheckbox extends ThemeController {
  /// Creates a ThemeControllerCheckbox.
  const ThemeControllerCheckbox({
    required super.value,
    required super.name,
    super.toggleTheme,
    super.isChecked,
    super.transitionDuration,
    super.onThemeChanged,
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  });

  @override
  String get inputType => 'checkbox';

  @override
  State<ThemeController> createState() => _ThemeControllerState();

  ThemeControllerCheckbox copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return ThemeControllerCheckbox(
      value: value,
      name: name,
      toggleTheme: toggleTheme,
      isChecked: isChecked,
      transitionDuration: transitionDuration,
      onThemeChanged: onThemeChanged,
      style: style as List<ThemeControllerStyling>?,
      id: id ?? this.id,
      classes: _mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  /// Styles the checkbox as a toggle switch. `toggle`
  static const ThemeControllerStyle toggle = ThemeControllerStyle('toggle', type: StyleType.style);
}

/// A [ThemeController] rendered as an HTML `<input type="radio">`.
class ThemeControllerRadio extends ThemeController {
  /// Creates a ThemeControllerRadio.
  const ThemeControllerRadio({
    required super.value,
    required super.name,
    super.isChecked,
    super.transitionDuration,
    super.onThemeChanged,
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  });

  @override
  String get inputType => 'radio';

  @override
  State<ThemeController> createState() => _ThemeControllerState();

  ThemeControllerRadio copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return ThemeControllerRadio(
      value: value,
      name: name,
      isChecked: isChecked,
      transitionDuration: transitionDuration,
      onThemeChanged: onThemeChanged,
      style: style as List<ThemeControllerStyling>?,
      id: id ?? this.id,
      classes: _mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  /// Styles the radio input as a button. `btn`
  static const ThemeControllerStyling button = ThemeControllerStyle('btn', type: StyleType.style);
}
