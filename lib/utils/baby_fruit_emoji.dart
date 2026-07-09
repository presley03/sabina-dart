// Pemetaan emoji buah per minggu kehamilan (index 1-40; index 0 tidak dipakai).
// Dipakai bersama oleh baby_development_screen.dart & home_screen.dart agar
// tidak ada dua sumber kebenaran yang bisa berbeda (mis. bug "Pisang 🌿").
const List<String> babyFruitEmoji = [
  '', // index 0 unused
  '🔬', '🔬', '🌱', '🌱', '🫛', '🫐', '🫐', '🫘', '🍇', '🍑',
  '🍈', '🍋', '🍑', '🍋', '🍎', '🥑', '🥕', '🍠', '🍅', '🍌',
  '🥕', '🌽', '🥭', '🌽', '🍍', '🥬', '🥦', '🍆', '🎃', '🥬',
  '🍍', '🥔', '🍍', '🎃', '🍈', '🍐', '🍈', '🍉', '🍉', '🍉',
];
