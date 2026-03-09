# Sistem Desain - SABINA

Dokumentasi lengkap untuk desain sistem SABINA mencakup warna, tipografi, komponen, dan panduan penggunaan.

---

## 📋 Daftar Isi

1. [Palet Warna](#palet-warna)
2. [Tipografi](#tipografi)
3. [Komponen UI](#komponen-ui)
4. [Spacing & Layout](#spacing--layout)
5. [Iconography](#iconography)
6. [Animation](#animation)
7. [Accessibility](#accessibility)
8. [Code Examples](#code-examples)

---

## 🎨 Palet Warna

### Primary - Purple (Aksi Utama)

| Shade | Hex | RGB | Penggunaan |
|-------|-----|-----|-----------|
| 900   | `#6B3D63` | 107, 61, 99 | Text, dark elements |
| 700   | `#8B5E9E` | 139, 94, 158 | Button backgrounds, primary CTA |
| 500   | `#A57DAB` | 165, 125, 171 | Secondary interactions |
| 300   | `#D4B5E0` | 212, 181, 224 | Hover states, highlights |
| 100   | `#EDD7F5` | 237, 215, 245 | Backgrounds, disabled states |

**Figma Color**: Purple 600
**Material Color**: Purple

### Secondary - Teal (Success & Information)

| Shade | Hex | RGB | Penggunaan |
|-------|-----|-----|-----------|
| 700   | `#2D9E78` | 45, 158, 120 | Success messages, positive actions |
| 500   | `#40B99D` | 64, 185, 157 | Secondary buttons, info |
| 300   | `#6ACBB8` | 106, 203, 184 | Hover states, light backgrounds |
| 100   | `#C3E6DD` | 195, 230, 221 | Light backgrounds, disabled |

**Figma Color**: Teal 600
**Material Color**: Teal

### Error - Red (Warning & Danger)

| Shade | Hex | RGB | Penggunaan |
|-------|-----|-----|-----------|
| 700   | `#D32F2F` | 211, 47, 47 | Error messages, danger actions |
| 100   | `#FFCDD2` | 255, 205, 210 | Error backgrounds, light alerts |

**Figma Color**: Red 600
**Material Color**: Red/Light Red

### Neutral - Gray (Text & Backgrounds)

| Shade | Hex | RGB | Penggunaan |
|-------|-----|-----|-----------|
| 900   | `#212121` | 33, 33, 33 | Primary text, headings |
| 700   | `#424242` | 66, 66, 66 | Secondary text |
| 500   | `#757575` | 117, 117, 117 | Tertiary text, icons |
| 300   | `#BDBDBD` | 189, 189, 189 | Disabled text, borders |
| 100   | `#F5F5F5` | 245, 245, 245 | Light backgrounds |
| White | `#FFFFFF` | 255, 255, 255 | Card backgrounds, appbars |

**Figma Color**: Gray scale

### Semantic Colors

| Color | Hex | Usage |
|-------|-----|-------|
| Success | `#40B99D` | Positive confirmations |
| Warning | `#FFA500` | Warnings, be cautious |
| Info | `#2D9E78` | Informational messages |
| Disabled | `#BDBDBD` | Disabled elements |

### Color Usage Guidelines

```
✅ DO:
- Use primary700 untuk main CTA buttons
- Use secondary700 untuk success messages
- Use error700 untuk error/warning states
- Use neutral900 untuk body text
- Use neutral100 untuk backgrounds

❌ DON'T:
- Mix dark colors (900) dengan light backgrounds
- Use pure red (#FF0000) - use error700
- Mix multiple primary colors dalam satu screen
- Use colors untuk accessibility differentiation saja
```

---

## 📝 Tipografi

### Font Family

**Primary Font**: Plus Jakarta Sans
- Variable font available
- Google Fonts integration
- Supports Indonesian characters

```dart
import 'package:google_fonts/google_fonts.dart';

// Usage
style: GoogleFonts.plusJakartaSans(...)
```

### Heading Styles

| Style | Size | Weight | Line Height | Letter Spacing | Usage |
|-------|------|--------|------------|---|--------|
| **H1** | 32px | 700 Bold | 40px | -0.5px | Page title |
| **H2** | 24px | 700 Bold | 32px | -0.3px | Section heading |
| **H3** | 18px | 700 Bold | 26px | -0.2px | Subsection heading |
| **H4** | 16px | 600 Bold | 24px | 0px | Small heading |

### Body Styles

| Style | Size | Weight | Line Height | Letter Spacing | Usage |
|-------|------|--------|------------|---|--------|
| **Body Large** | 16px | 500 Medium | 24px | 0.3px | Main body text |
| **Body Regular** | 14px | 500 Medium | 22px | 0.25px | Secondary text |
| **Body Small** | 12px | 400 Regular | 18px | 0.2px | Helper text |
| **Caption** | 12px | 400 Regular | 16px | 0.4px | Labels, captions |

### Button & Overline Styles

| Style | Size | Weight | Letter Spacing | Usage |
|-------|------|--------|---|--------|
| **Button** | 14px | 600 Bold | 0.5px | Button labels |
| **Button Small** | 12px | 600 Bold | 0.3px | Small button labels |
| **Overline** | 11px | 700 Bold | 1.5px | Section overline |

### Typography Hierarchy

```
H1 (32px) - Page titles
   ↓
H2 (24px) - Major sections
   ↓
H3 (18px) - Subsections
   ↓
H4 (16px) - Minor headings
   ↓
Body Large (16px) - Main content
   ↓
Body Regular (14px) - Secondary content
   ↓
Caption (12px) - Metadata, help text
```

### Code Implementation (Dart)

```dart
// lib/core/theme/app_theme.dart
class SabinaTextStyles {
  // Heading styles
  static TextStyle h1() => GoogleFonts.plusJakartaSans(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.25,
    letterSpacing: -0.5,
  );
  
  static TextStyle bodyLarge() => GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.3,
  );
  
  // Use with color override
  TextStyle headingWithColor = SabinaTextStyles.h2()
    .copyWith(color: SabinaColors.neutral900);
}
```

---

## 🧩 Komponen UI

### Buttons

#### Filled Button (Primary)
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: SabinaColors.primary700,
    foregroundColor: SabinaColors.white,
    elevation: 2,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  onPressed: () {},
  child: Text('Action', style: SabinaTextStyles.button()),
)
```

#### Outlined Button (Secondary)
```dart
OutlinedButton(
  style: OutlinedButton.styleFrom(
    foregroundColor: SabinaColors.primary700,
    side: BorderSide(color: SabinaColors.primary700, width: 2),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  onPressed: () {},
  child: Text('Secondary', style: SabinaTextStyles.button()),
)
```

#### Success Button (Secondary700)
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: SabinaColors.secondary700,
    elevation: 2,
  ),
  onPressed: () {},
  child: Text('Confirm'),
)
```

### Cards

#### Basic Card
```dart
Card(
  elevation: 2,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  child: Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: SabinaColors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: SabinaColors.neutral300.withValues(alpha: 0.2),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Text('Card content'),
  ),
)
```

#### Data Card (dengan background)
```dart
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: SabinaColors.primary100,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Column(
    children: [
      Text('Label', style: SabinaTextStyles.caption()),
      Text('Data', style: SabinaTextStyles.h3()),
    ],
  ),
)
```

### Form Elements

#### Input Field
```dart
TextField(
  decoration: InputDecoration(
    hintText: 'Enter data',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: SabinaColors.neutral300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: SabinaColors.primary700, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),
)
```

#### Checkbox
```dart
Checkbox(
  value: isSelected,
  onChanged: (value) {},
  fillColor: MaterialStateProperty.all(SabinaColors.primary700),
  side: BorderSide(color: SabinaColors.primary700, width: 2),
)
```

### Icon Containers

#### Standard Icon Container (36x36)
```dart
Container(
  width: 36,
  height: 36,
  decoration: BoxDecoration(
    color: SabinaColors.primary100,
    borderRadius: BorderRadius.circular(8),
  ),
  child: Icon(
    Icons.heart,
    color: SabinaColors.primary700,
    size: 18,
  ),
)
```

#### Large Icon Container (48x48)
```dart
Container(
  width: 48,
  height: 48,
  decoration: BoxDecoration(
    color: SabinaColors.primary100,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Icon(
    Icons.emergency,
    color: SabinaColors.error700,
    size: 24,
  ),
)
```

### AppBar

#### Standard AppBar
```dart
AppBar(
  backgroundColor: SabinaColors.white,
  foregroundColor: SabinaColors.primary700,
  elevation: 0,
  title: Text('Title', style: SabinaTextStyles.h2()),
  centerTitle: false,
)
```

---

## 📏 Spacing & Layout

### Spacing Scale

```
4px   - Micro spacing (rarely used)
8px   - Base unit (used for most spacing)
16px  - Standard padding/margin
24px  - Section spacing
32px  - Large section spacing
48px  - Extra large spacing (between major sections)
```

### Padding Guidelines

| Element | Padding |
|---------|---------|
| AppBar | 16px horizontal, 8px vertical |
| Card | 16px all sides |
| Screen | 16px horizontal, 24px vertical |
| Form Field | 12px vertical, 16px horizontal |
| List Item | 16px horizontal, 8px vertical |
| Button | 12px vertical, 24px horizontal |

### Grid System

- **Base Unit**: 8px
- **Mobile Width**: 360-400px
- **Tablet Width**: 600px+
- **Desktop Width**: 900px+

### Responsive Breakpoints

```dart
// Breakpoints
static const mobileWidth = 375.0;
static const tabletWidth = 600.0;
static const desktopWidth = 1200.0;

// Usage
if (mediaQuery.size.width < tabletWidth) {
  // Mobile layout
} else {
  // Tablet/Desktop layout
}
```

---

## 🎯 Iconography

### Icon Size Standards

| Usage | Size | Context |
|-------|------|---------|
| Small icon inside button | 18px | Icon containers |
| Navigation icon | 24px | Bottom nav, menus |
| Action icon | 28px | Toolbar icons |
| Large icon (hero) | 48-64px | Hero sections, empty states |

### Icon Resource

We use Material Icons and Cupertino Icons:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Material Icons
Icon(Icons.health_and_safety, size: 24)

// Custom SVG (if needed)
SvgPicture.asset('assets/icons/custom_icon.svg')
```

### Color for Icons

```dart
// Primary action
Icon(Icons.add, color: SabinaColors.primary700)

// Success
Icon(Icons.check_circle, color: SabinaColors.secondary700)

// Error/Warning
Icon(Icons.warning, color: SabinaColors.error700)

// Disabled
Icon(Icons.lock, color: SabinaColors.neutral300)
```

---

## ✨ Animation

### Transition Durations

| Type | Duration | Use Case |
|------|----------|----------|
| Instant | 0ms | No animation |
| Quick | 150-200ms | Hover, focus states |
| Standard | 300ms | Page transitions, dialogs |
| Slow | 500-800ms | Complex transitions |

### Animation Curves

```dart
// Standard curves
Curves.easeInOut    // Default, smooth
Curves.easeIn       // Accelerate
Curves.easeOut      // Decelerate
Curves.linear       // Constant speed
Curves.bounceOut    // Bounce effect
```

### Common Animations

```dart
// Fade transition (app initialization)
FadeTransition(
  opacity: Tween<double>(begin: 0, end: 1).animate(controller),
  child: widget,
)

// Slide transition (page navigation)
SlideTransition(
  position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
    .animate(controller),
  child: widget,
)

// Scale transition (scale up)
ScaleTransition(
  scale: Tween<double>(begin: 0.8, end: 1).animate(controller),
  child: widget,
)
```

---

## ♿ Accessibility

### Color Contrast

- **Text vs Background**: Minimum WCAG AA (4.5:1 untuk small text)
- **UI vs Background**: Minimum 3:1 ratio

Check contrast with: https://webaim.org/resources/contrastchecker/

### Text

- **Minimum Size**: 12px (use semantic sizes)
- **Line Height**: At least 1.4x font size
- **Letter Spacing**: 1.5px max
- **Font Styling**: Use weight, not italic for emphasis

### Interactive Elements

- **Touch Target**: Minimum 48x48dp
- **Focus State**: Always visible focus indicator
- **Semantic Labels**: Use `Semantics` widget for screen readers

```dart
Semantics(
  label: 'Add health record button',
  button: true,
  child: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
)
```

### Dark Mode Preparation

Current: Light mode only
Future: Dark mode variants dapat dengan:

```dart
// Color adaptation untuk dark mode
color: Theme.of(context).brightness == Brightness.dark
  ? SabinaColorsDark.primary700
  : SabinaColors.primary700
```

---

## 💻 Code Examples

### Complete Screen Template

```dart
// lib/screens/example_screen.dart
import 'package:flutter/material.dart';
import 'package:sabina/core/theme/app_theme.dart';

class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabinaColors.neutral100,
      appBar: AppBar(
        backgroundColor: SabinaColors.white,
        foregroundColor: SabinaColors.primary700,
        title: Text('Title', style: SabinaTextStyles.h2()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text('Section', style: SabinaTextStyles.h3()),
            SizedBox(height: 16),
            
            // Card with data
            _buildDataCard(),
            SizedBox(height: 24),
            
            // Action button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SabinaColors.primary700,
                ),
                onPressed: () {},
                child: Text('Action', style: SabinaTextStyles.button()),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDataCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SabinaColors.primary100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: SabinaColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.heart, color: SabinaColors.primary700, size: 18),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Label', style: SabinaTextStyles.caption()),
                Text('Value', style: SabinaTextStyles.h3()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 📊 Maintenance & Updates

### Color Updates

Jika ada perubahan warna:
1. Update `lib/core/theme/app_theme.dart`
2. Test all screens untuk ensure consistency
3. Update dokumentasi ini
4. Commit dengan message: "style: update color palette"

### Typography Updates

1. Update `SabinaTextStyles` class
2. Test semua heading dan body text
3. Validate line heights dan spacing
4. Update dokumentasi

### Component Templates

Template component disimpan di:
- `lib/widgets/` - Reusable components
- `lib/core/theme/` - Design tokens

---

## 🔗 Resources

- [Material Design 3](https://m3.material.io/)
- [Flutter's Theme System](https://flutter.dev/docs/cookbook/design/themes)
- [Plus Jakarta Sans Font](https://fonts.google.com/specimen/Plus+Jakarta+Sans)
- [Figma Design System](link-to-figma-if-available)

---

**Version**: 1.0
**Last Updated**: January 2026
**Designed for**: SABINA App v1.0+

