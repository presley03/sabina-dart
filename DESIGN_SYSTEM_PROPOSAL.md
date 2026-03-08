# SABINA APP - DESIGN SYSTEM PROPOSAL

**Aplikasi**: Kesehatan Ibu Hamil (Modern, Premium, Feminine)  
**Font**: Plus Jakarta Sans (Google Fonts)  
**Style**: Modern Minimal, Clean & Professional

---

## 1. COLOR PALETTE

### Primary Colors (Main Brand - Feminine & Premium)
```
Primary 900:  #6B4B7C  (Deep Purple - untuk header, main actions)
Primary 700:  #8B5E9E  (Rich Purple - untuk primary buttons)
Primary 500:  #A87ABD  (Warm Pink-Purple - untuk accents, highlights)
Primary 300:  #D4B5E8  (Soft Purple - untuk backgrounds, hover states)
Primary 100:  #F5EFF9  (Very Light Purple - untuk card backgrounds)
```

**Alasan**: 
- Purple adalah warna yang sophisticated dan feminine tanpa terkesan childish
- Mix dengan warm pink membuat terasa premium dan caring
- Terinspirasi dari aplikasi healthcare premium (Halodoc palette trend)

---

### Secondary Colors (Supporting - Trust & Health)
```
Secondary 700:  #2D9E78  (Teal Green - untuk success states, health positivity)
Secondary 500:  #40B99D  (Soft Green - untuk progress indicators)
Secondary 300:  #7DD4C5  (Light Mint - untuk informational elements)
```

**Alasan**:
- Green untuk kesehatan dan wellness adalah standard industri
- Teal bukan green murni, lebih sophisticated dan cocok dengan purple
- Tidak overwhelming, complementary ke primary palette

---

### Neutral Colors (Text, Backgrounds - Professional)
```
Neutral 900:  #1A1A1A  (Deep Black - primary text, headers)
Neutral 700:  #424242  (Dark Gray - secondary text, body copy)
Neutral 500:  #9E9E9E  (Medium Gray - disabled, tertiary text)
Neutral 300:  #E0E0E0  (Light Gray - borders, dividers, subtle backgrounds)
Neutral 100:  #F5F5F5  (Off White - page backgrounds)
White    :    #FFFFFF  (Pure White - card backgrounds, main content areas)
```

---

### Semantic Colors
```
Error 700:     #D32F2F  (Red - untuk warnings, errors, dangerous actions)
Error 100:     #FFEBEE  (Light Red - untuk error backgrounds)

Success:       #40B99D  (Teal Green - confirmation, success states)
Warning:       #FF9800  (Amber - untuk cautionary messages)
Info:          #2196F3  (Blue - untuk informational content)
```

---

## 2. TYPOGRAPHY SCALE

**Font Family**: Plus Jakarta Sans (Google Fonts)

### Heading Styles

| Level | Size | Weight | Line Height | Usage |
|-------|------|--------|-------------|-------|
| **H1** | 32px | 700 Bold | 40px | Page titles, main headings |
| **H2** | 24px | 600 SemiBold | 32px | Section titles, card headers |
| **H3** | 20px | 600 SemiBold | 28px | Subsection titles |
| **H4** | 16px | 600 SemiBold | 24px | Card titles, prominent labels |

### Body Styles

| Level | Size | Weight | Line Height | Usage |
|-------|------|--------|-------------|-------|
| **Body Large** | 16px | 500 Medium | 24px | Main body text, descriptions |
| **Body Regular** | 14px | 400 Regular | 22px | Standard body text |
| **Body Small** | 12px | 400 Regular | 18px | Secondary text, metadata |

### Accent Styles

| Level | Size | Weight | Line Height | Usage |
|-------|------|--------|-------------|-------|
| **Caption** | 12px | 500 Medium | 16px | Labels, badges, captions |
| **Overline** | 11px | 600 SemiBold | 16px | Section labels, tabs |
| **Button** | 14px | 600 SemiBold | 20px | Button text (standard) |
| **Button Small** | 12px | 600 SemiBold | 18px | Small button text |

---

## 3. COMPONENT SPECIFICATIONS

### Card Component
- **Background**: White (#FFFFFF) atau Primary 100 (#F5EFF9)
- **Border Radius**: 16px
- **Shadow**: 
  - `elevation: 2` (subtle)
  - Soft shadow, no heavy borders
  - Example: `boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: Offset(0, 2))]`
- **Padding**: 16px
- **Border**: None (clean look)

### Button Component
- **Border Radius**: 14px
- **Style**: Solid fill, no outline
- **States**:
  - **Enabled**: Primary 700 (#8B5E9E) background, white text
  - **Hover/Pressed**: Primary 900 (#6B4B7C) (darker shade)
  - **Disabled**: Neutral 300 (#E0E0E0) background, Neutral 500 (#9E9E9E) text
- **Typography**: Button semi-bold 14px, white text
- **Padding**: Vertical 12px, Horizontal 24px
- **Height**: Min 48px (touch target)

### Bottom Navigation
- **Style**: Clean, icon + label
- **Inactive**: Neutral 700 (#424242) icon, Neutral 700 text (12px)
- **Active**: Primary 700 (#8B5E9E) icon, Primary 700 text (12px, bold)
- **Background**: White (#FFFFFF)
- **Border Top**: Neutral 300 (#E0E0E0) divider (1px)
- **Height**: 64px
- **Icon size**: 24px

### App Bar / Header
- **Background**: White (#FFFFFF)
- **Title Text**: Neutral 900 (#1A1A1A), H2 size
- **Divider Bottom**: Neutral 300 (#E0E0E0), 1px
- **Height**: 56px
- **No shadow** - clean, minimal approach

### Input Fields
- **Border Radius**: 12px
- **Border**: Neutral 300 (#E0E0E0), 1px
- **Background**: Neutral 100 (#F5F5F5)
- **Focus Border**: Primary 700 (#8B5E9E), 2px
- **Padding**: 12px 16px
- **Placeholder**: Neutral 500 (#9E9E9E)
- **Label**: Body Small (12px), Neutral 700 (#424242)

---

## 4. COLOR PALETTE VISUAL PREVIEW

### Primary Purple Palette (Main Brand)
```
█████████████████████████████████████  #6B4B7C  Primary 900 (Darkest)
█████████████████████████████████████  #8B5E9E  Primary 700 (Bold)
█████████████████████████████████████  #A87ABD  Primary 500 (Accent)
█████████████████████████████████████  #D4B5E8  Primary 300 (Light)
█████████████████████████████████████  #F5EFF9  Primary 100 (Palest)
```

### Secondary Teal Palette (Health & Success)
```
█████████████████████████████████████  #2D9E78  Secondary 700
█████████████████████████████████████  #40B99D  Secondary 500
█████████████████████████████████████  #7DD4C5  Secondary 300
```

### Neutral Palette (Text & Structure)
```
█████████████████████████████████████  #1A1A1A  Neutral 900 (Black)
█████████████████████████████████████  #424242  Neutral 700 (Dark Gray)
█████████████████████████████████████  #9E9E9E  Neutral 500 (Medium Gray)
█████████████████████████████████████  #E0E0E0  Neutral 300 (Light Gray)
█████████████████████████████████████  #F5F5F5  Neutral 100 (Off-white)
█████████████████████████████████████  #FFFFFF  White (Pure)
```

### Semantic Palette
```
█████████████████████████████████████  #D32F2F  Error 700 (Red)
█████████████████████████████████████  #40B99D  Success (Teal - sama dengan Secondary 500)
█████████████████████████████████████  #FF9800  Warning (Amber)
█████████████████████████████████████  #2196F3  Info (Blue)
```

---

## 5. TYPOGRAPHY EXAMPLES

### Heading 1 (32px, 700 Bold)
Pantau Kesehatan Anda Setiap Hari

### Heading 2 (24px, 600 SemiBold)
Pemeriksaan Kehamilan

### Heading 3 (20px, 600 SemiBold)
Data Janin Terkini

### Heading 4 (16px, 600 SemiBold)
Terakhir diperiksa: 15 Maret 2026

**Body Large (16px, 500 Medium)**  
Aplikasi kesehatan ini dirancang khusus untuk mendampingi perjalanan kehamilan Anda dengan informasi akurat dan fitur monitoring yang komprehensif.

**Body Regular (14px, 400 Regular)**  
Pantau perkembangan janin, catat gejala, dan dapatkan rekomendasi kesehatan dari ahli medis kami.

**Body Small (12px, 400 Regular)**  
Diperbarui: Hari ini, 14:30

---

## 6. DESIGN PRINCIPLES (untuk reference)

✓ **Clean & Minimal**: No unnecessary decorations, gradients, atau flourishes  
✓ **Professional**: Sophisticated purple + teal, cocok untuk healthcare  
✓ **Readable**: Strong typography hierarchy, high contrast (Neutral 900 on white)  
✓ **Feminine not Childish**: Purple sophisticated, bukan pink candy  
✓ **Premium Feel**: Subtle shadows, proper spacing, clean borders  
✓ **Consistent**: Same radius (16px cards, 14px buttons, 12px inputs), aligned spacing  
✓ **Accessible**: WCAG compliant colors, sufficient contrast ratios  

---

## 7. COMPARISON REFERENCE

| Aspect | Sabina Design | Target Apps (Halodoc/Gojek) |
|--------|---------------|------------------------------|
| Primary Color | Purple (#8B5E9E) | Often brand-specific blues/greens maintained |
| Typography | Plus Jakarta Sans (modern) | Clean, modern sans-serif |
| Card Style | Subtle shadow, 16px radius | Minimal, clean cards |
| Button Style | Solid 14px radius | Solid, bold, rounded |
| Overall Feel | Sophisticated healthcare | Professional, trustworthy |

---

## ✅ READY FOR APPROVAL

**Pertanyaan untuk Anda:**

1. Apakah color palette (purple + teal + neutral) cocok untuk target Sabina?
   - Primary Purple terasa premium dan feminine?
   - Secondary Teal melengkapi dan terasa natural untuk healthcare?

2. Apakah typography scale sudah sesuai (Plus Jakarta Sans dengan berat 400-700)?

3. Apakah component specifications (card shadow, button radius, bottom nav) sudah sesuai vision?

4. Ada warna atau nuansa yang ingin diubah?

**Setelah Anda approve, saya akan:**
- Buat `lib/theme/app_theme.dart` dengan semua configuration ini
- Redesign `home_screen.dart` sebagai pilot
- Tampilkan side-by-side comparison sebelum final
