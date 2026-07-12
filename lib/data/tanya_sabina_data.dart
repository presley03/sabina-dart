/// Data kurasi "Tanya SABINA" — retrieval Q&A OFFLINE (bukan LLM).
///
/// Sumber: `kurasi/qna_draft.md` — STATUS FINAL, tervalidasi penuh oleh
/// Bdn. Wahidah Sukriani, S.ST., M.Keb. (2026-07-10). 72 entri aktif
/// (Q33 dihapus atas keputusan validator — tidak ada di sini).
/// Teks `answerId` disalin apa adanya dari hasil validasi; JANGAN diedit
/// tanpa validasi ulang. `answerEn` adalah terjemahan setia (angka & marker
/// `==istilah==` dipertahankan persis).
///
/// `id` = nomor pertanyaan asli dari draf kurasi (tidak selalu berurutan
/// karena Q33 dihapus) — dipertahankan agar tertelusuri ke sumber.
class TanyaSabinaEntry {
  final int id;
  final String cluster;
  final String questionId;
  final String questionEn;
  final List<String> keywordsId;
  final List<String> keywordsEn;
  final String answerId;
  final String answerEn;
  final String sourceLabel;

  /// Kunci rute layar terkait (lihat resolver di lib/screens/tanya_sabina_screen.dart).
  /// `'consultation'` = tombol WhatsApp, bukan layar. Daftar kosong = tidak
  /// ada layar terkait langsung (mis. klaster menyusui — belum ada layarnya).
  final List<String> routes;

  /// True bila pertanyaan mengandung kata-bahaya (⚠) dan jawaban WAJIB
  /// tampil dengan panel darurat + tombol kuesioner + Konsultasi di atas.
  final bool isSafetyPath;

  const TanyaSabinaEntry({
    required this.id,
    required this.cluster,
    required this.questionId,
    required this.questionEn,
    required this.keywordsId,
    required this.keywordsEn,
    required this.answerId,
    required this.answerEn,
    required this.sourceLabel,
    required this.routes,
    this.isSafetyPath = false,
  });
}

const List<TanyaSabinaEntry> tanyaSabinaEntries = [
  // ── K1 — Keluhan Kehamilan ──────────────────────────────────────────────
  TanyaSabinaEntry(
    id: 1,
    cluster: 'K1',
    questionId: 'Mual muntah saat hamil itu normal?',
    questionEn: 'Is nausea and vomiting during pregnancy normal?',
    keywordsId: ['mual', 'muntah', 'morning sickness', 'eneg'],
    keywordsEn: ['nausea', 'vomiting', 'morning sickness', 'queasy'],
    answerId:
        'Mual muntah ringan (morning sickness) dialami sebagian besar ibu di trimester pertama dan biasanya membaik setelah minggu ke-12–16. Pemicunya perubahan hormon. Makan porsi kecil tapi sering, hindari makanan berminyak/berbau tajam, dan cukupi cairan. Bila mual sampai tidak bisa makan-minum sama sekali, isi kuesioner Mual Muntah di SABINA dan konsultasikan ke bidan.',
    answerEn:
        'Mild nausea and vomiting (morning sickness) affects most mothers in the first trimester and usually improves after week 12–16. It\'s triggered by hormonal changes. Eat small, frequent portions, avoid oily or strong-smelling food, and stay hydrated. If nausea stops you from eating or drinking at all, fill in the Nausea & Vomiting questionnaire in SABINA and consult your midwife.',
    sourceLabel: 'Konten SABINA (keluhan mual) + Asuhan Kebidanan Kehamilan (2022)',
    routes: ['keluhan/mual_muntah'],
  ),
  TanyaSabinaEntry(
    id: 2,
    cluster: 'K1',
    questionId: 'Muntah terus-menerus sampai lemas, bahayakah?',
    questionEn: 'Is it dangerous to keep vomiting until I feel weak?',
    keywordsId: ['muntah terus', 'tidak bisa makan', 'lemas', 'hiperemesis'],
    keywordsEn: ['vomiting nonstop', "can't eat", 'weak', 'hyperemesis'],
    answerId:
        'Muntah berlebihan hingga tidak bisa makan-minum, badan lemas, atau berat badan turun bisa menandakan ==hiperemesis gravidarum== yang butuh penanganan medis — jangan ditunda. Segera isi kuesioner Mual Muntah untuk menilai tingkatnya, lalu hubungi bidan/dokter. Sambil menunggu, coba seruput cairan sedikit-sedikit tapi sering.',
    answerEn:
        'Excessive vomiting that stops you from eating or drinking, leaves you weak, or causes weight loss can signal ==hyperemesis gravidarum==, which needs medical care — don\'t delay. Fill in the Nausea & Vomiting questionnaire right away to assess the severity, then contact your midwife/doctor. While you wait, try sipping fluids slowly but often.',
    sourceLabel: 'Asuhan Kebidanan Kehamilan (2022)',
    routes: ['keluhan/mual_muntah', 'consultation'],
    isSafetyPath: true,
  ),
  TanyaSabinaEntry(
    id: 3,
    cluster: 'K1',
    questionId: 'Cara alami meredakan mual?',
    questionEn: 'Natural ways to relieve nausea?',
    keywordsId: ['redakan mual', 'jahe', 'mual alami', 'tips mual'],
    keywordsEn: ['relieve nausea', 'ginger', 'natural nausea remedy', 'nausea tips'],
    answerId:
        'Yang banyak membantu: makan porsi kecil 5–6 kali sehari, biskuit/kraker sebelum bangun dari tempat tidur, minuman jahe hangat, hindari perut kosong dan bau menyengat, serta istirahat cukup. Vitamin B6 dapat membantu tetapi konsumsinya harus atas anjuran bidan/dokter.',
    answerEn:
        'What helps most: eating small portions 5–6 times a day, crackers before getting out of bed, warm ginger drinks, avoiding an empty stomach and strong smells, and enough rest. Vitamin B6 can help, but only take it on your midwife\'s/doctor\'s advice.',
    sourceLabel: 'Konten SABINA (keluhan mual) + Asuhan Kebidanan Kehamilan (2022)',
    routes: ['keluhan/mual_muntah'],
  ),
  TanyaSabinaEntry(
    id: 4,
    cluster: 'K1',
    questionId: 'Sakit kepala saat hamil, normalkah?',
    questionEn: 'Is a headache during pregnancy normal?',
    keywordsId: ['sakit kepala', 'pusing', 'migrain'],
    keywordsEn: ['headache', 'dizzy', 'migraine'],
    answerId:
        'Sakit kepala ringan cukup umum, terutama trimester pertama — pemicunya hormon, kurang tidur, lapar, atau dehidrasi. Redakan dengan istirahat, minum cukup, dan makan teratur. Jangan minum obat sakit kepala sembarangan tanpa anjuran bidan/dokter. Yang perlu diwaspadai: sakit kepala hebat yang tidak hilang — lihat pertanyaan berikutnya.',
    answerEn:
        'Mild headaches are fairly common, especially in the first trimester — triggered by hormones, lack of sleep, hunger, or dehydration. Ease it with rest, enough fluids, and regular meals. Don\'t take headache medicine without your midwife\'s/doctor\'s advice. Watch out for: a severe headache that won\'t go away — see the next question.',
    sourceLabel: 'Konten SABINA (keluhan sakit kepala)',
    routes: ['keluhan/sakit_kepala'],
  ),
  TanyaSabinaEntry(
    id: 5,
    cluster: 'K1',
    questionId: 'Sakit kepala hebat + pandangan kabur?',
    questionEn: 'Severe headache plus blurry vision?',
    keywordsId: ['sakit kepala hebat', 'pandangan kabur', 'mata berkunang'],
    keywordsEn: ['severe headache', 'blurry vision', 'blurred vision', 'spots in vision'],
    answerId:
        'Sakit kepala hebat yang menetap, apalagi disertai ==pandangan kabur==, nyeri ulu hati, atau bengkak wajah/tangan, bisa menjadi tanda ==preeklampsia== — kondisi tekanan darah tinggi kehamilan yang serius. Segera lakukan Skrining Preeklampsia di SABINA dan periksakan diri ke fasilitas kesehatan hari ini juga.',
    answerEn:
        'A severe, persistent headache — especially with ==blurry vision==, upper abdominal pain, or swelling of the face/hands — can be a sign of ==preeclampsia==, a serious high blood pressure condition in pregnancy. Do the Preeclampsia Screening in SABINA right away and get checked at a health facility today.',
    sourceLabel: 'Konten SABINA (skrining preeklampsia)',
    routes: ['preeclampsia', 'consultation'],
    isSafetyPath: true,
  ),
  TanyaSabinaEntry(
    id: 6,
    cluster: 'K1',
    questionId: 'Kaki bengkak saat hamil normal?',
    questionEn: 'Is swollen feet during pregnancy normal?',
    keywordsId: ['kaki bengkak', 'bengkak kaki', 'edema'],
    keywordsEn: ['swollen feet', 'foot swelling', 'edema'],
    answerId:
        'Bengkak ringan di kaki/pergelangan pada trimester akhir umumnya normal (==edema fisiologis==) — akibat rahim menekan pembuluh darah balik. Kurangi berdiri lama, tinggikan kaki saat duduk/tidur, dan minum cukup air. Bengkak yang perlu diwaspadai: muncul mendadak di wajah dan tangan — lihat pertanyaan berikutnya.',
    answerEn:
        'Mild swelling in the feet/ankles in the last trimester is usually normal (==physiological edema==) — caused by the womb pressing on the veins. Avoid standing for long periods, elevate your feet when sitting/lying down, and drink enough water. Swelling to watch for: sudden swelling in the face and hands — see the next question.',
    sourceLabel: 'Konten SABINA (keluhan bengkak)',
    routes: ['keluhan/bengkak'],
  ),
  TanyaSabinaEntry(
    id: 7,
    cluster: 'K1',
    questionId: 'Bengkak di wajah dan tangan mendadak?',
    questionEn: 'Sudden swelling in the face and hands?',
    keywordsId: ['bengkak wajah', 'bengkak tangan', 'bengkak mendadak'],
    keywordsEn: ['swollen face', 'swollen hands', 'sudden swelling'],
    answerId:
        'Bengkak yang muncul ==mendadak di wajah, kelopak mata, atau tangan== berbeda dari bengkak kaki biasa — ini salah satu tanda ==preeklampsia==. Segera isi kuesioner Bengkak dan Skrining Preeklampsia di SABINA, lalu periksakan tekanan darah ke bidan/fasilitas kesehatan secepatnya.',
    answerEn:
        'Swelling that appears ==suddenly in the face, eyelids, or hands== is different from ordinary foot swelling — it\'s one of the signs of ==preeclampsia==. Fill in the Swelling questionnaire and the Preeclampsia Screening in SABINA right away, then get your blood pressure checked at a midwife/health facility as soon as possible.',
    sourceLabel: 'Konten SABINA (keluhan bengkak + skrining)',
    routes: ['keluhan/bengkak', 'preeclampsia', 'consultation'],
    isSafetyPath: true,
  ),
  TanyaSabinaEntry(
    id: 8,
    cluster: 'K1',
    questionId: 'Keluar flek/darah saat hamil muda?',
    questionEn: 'Spotting or bleeding in early pregnancy?',
    keywordsId: ['flek', 'keluar darah', 'perdarahan', 'bercak darah'],
    keywordsEn: ['spotting', 'bleeding', 'blood', 'blood stain'],
    answerId:
        'Flek sedikit di awal kehamilan bisa terjadi (misal perdarahan implantasi), tetapi SEMUA perdarahan saat hamil sebaiknya diperiksakan — terutama bila makin banyak, berwarna merah segar, atau disertai nyeri/kram. Isi kuesioner Keluar Darah di SABINA untuk menilai kondisinya, dan segera hubungi bidan/dokter. Jangan menunda bila darah banyak.',
    answerEn:
        'A little spotting early in pregnancy can happen (e.g. implantation bleeding), but ALL bleeding during pregnancy should be checked — especially if it increases, is bright red, or comes with pain/cramping. Fill in the Bleeding questionnaire in SABINA to assess it, and contact your midwife/doctor right away. Don\'t delay if the bleeding is heavy.',
    sourceLabel: 'Konten SABINA (keluhan keluar darah)',
    routes: ['keluhan/keluar_darah', 'consultation'],
    isSafetyPath: true,
  ),
  TanyaSabinaEntry(
    id: 9,
    cluster: 'K1',
    questionId: 'Keluar cairan bening banyak, apakah ketuban?',
    questionEn: 'A lot of clear fluid is coming out — is it amniotic fluid?',
    keywordsId: ['keluar cairan', 'air ketuban', 'rembes', 'pecah ketuban'],
    keywordsEn: ['fluid leaking', 'amniotic fluid', 'leaking water', 'water broke'],
    answerId:
        'Cairan bening yang keluar banyak, terus merembes, dan tidak bisa ditahan (beda dengan pipis) bisa jadi ==air ketuban==. Bila usia kehamilan belum cukup bulan, ini disebut ==ketuban pecah dini== dan perlu penanganan segera. Isi kuesioner Keluar Cairan di SABINA, catat warna dan baunya, dan segera ke fasilitas kesehatan.',
    answerEn:
        'A large amount of clear fluid that keeps leaking and can\'t be held back (unlike urine) could be ==amniotic fluid==. If it\'s before full term, this is called ==premature rupture of membranes== and needs immediate care. Fill in the Fluid Discharge questionnaire in SABINA, note its color and smell, and go to a health facility right away.',
    sourceLabel: 'Konten SABINA (keluhan keluar cairan)',
    routes: ['keluhan/keluar_cairan', 'consultation'],
    isSafetyPath: true,
  ),
  TanyaSabinaEntry(
    id: 10,
    cluster: 'K1',
    questionId: 'Keputihan saat hamil normal?',
    questionEn: 'Is vaginal discharge during pregnancy normal?',
    keywordsId: ['keputihan', 'cairan putih', 'lendir'],
    keywordsEn: ['vaginal discharge', 'white discharge', 'mucus'],
    answerId:
        'Keputihan bening/putih susu tanpa bau menyengat dan tanpa gatal umumnya normal saat hamil — produksinya memang meningkat. Yang perlu diperiksakan: bila berbau, berwarna kehijauan/keabu-abuan, gatal, atau perih — bisa jadi infeksi yang perlu diobati agar tidak memengaruhi kehamilan.',
    answerEn:
        'Clear or milky-white discharge without a strong smell or itching is generally normal during pregnancy — production does increase. Get it checked if it smells bad, is greenish/grayish, itchy, or stinging — it could be an infection that needs treatment so it doesn\'t affect the pregnancy.',
    sourceLabel: 'Asuhan Kebidanan Kehamilan (2022) — divalidasi 2026-07-10',
    routes: ['keluhan/keluar_cairan'],
  ),
  TanyaSabinaEntry(
    id: 11,
    cluster: 'K1',
    questionId: 'Kapan gerakan janin mulai terasa?',
    questionEn: 'When does fetal movement start to be felt?',
    keywordsId: ['gerakan janin', 'tendangan bayi', 'quickening'],
    keywordsEn: ['fetal movement', 'baby kicks', 'quickening'],
    answerId:
        'Gerakan pertama (==quickening==) umumnya mulai terasa di usia 16–20 minggu — pada kehamilan pertama biasanya lebih lambat (mendekati 20 minggu), pada kehamilan berikutnya bisa lebih awal. Awalnya terasa seperti kedutan atau gelembung kecil. Setelah 28 minggu, gerakan sebaiknya dipantau setiap hari.',
    answerEn:
        'First movements (==quickening==) are usually felt at 16–20 weeks — in a first pregnancy this is typically later (closer to 20 weeks), while later pregnancies can feel it earlier. It first feels like a flutter or small bubble. After 28 weeks, movement should be monitored every day.',
    sourceLabel: 'Konten SABINA (trimester 2)',
    routes: ['keluhan/pergerakan_janin'],
  ),
  TanyaSabinaEntry(
    id: 12,
    cluster: 'K1',
    questionId: 'Gerakan janin berkurang, harus bagaimana?',
    questionEn: 'Fetal movement has decreased — what should I do?',
    keywordsId: ['janin tidak bergerak', 'gerakan berkurang', 'bayi diam'],
    keywordsEn: ['baby not moving', 'decreased movement', 'baby still'],
    answerId:
        'Bila gerakan janin terasa jauh berkurang dari biasanya, berbaring miring kiri, makan/minum sesuatu, dan rasakan kembali gerakannya. Bila tetap terasa jauh berkurang atau tidak ada gerakan sama sekali, JANGAN menunggu — isi kuesioner Pergerakan Janin dan segera ke fasilitas kesehatan sekarang.',
    answerEn:
        'If fetal movement feels much less than usual, lie on your left side, eat or drink something, and check again for movement. If it\'s still clearly reduced or there\'s no movement at all, DO NOT wait — fill in the Fetal Movement questionnaire and go to a health facility right now.',
    sourceLabel:
        'Konten SABINA (keluhan pergerakan janin) — divalidasi 2026-07-10 (metode hitung dihapus atas arahan validator)',
    routes: ['keluhan/pergerakan_janin', 'consultation'],
    isSafetyPath: true,
  ),
  TanyaSabinaEntry(
    id: 13,
    cluster: 'K1',
    questionId: 'Kram perut ringan saat hamil?',
    questionEn: 'Mild abdominal cramps during pregnancy?',
    keywordsId: ['kram perut', 'nyeri perut bawah', 'perut kencang'],
    keywordsEn: ['abdominal cramps', 'lower belly pain', 'tight belly'],
    answerId:
        'Kram ringan sesekali bisa normal — rahim yang membesar menarik ligamen di sekitarnya (nyeri ligamen bundar), terutama saat berubah posisi. Istirahat dan ubah posisi perlahan biasanya membantu. Waspadai bila kram hebat, menetap, atau disertai perdarahan/keluar cairan — segera periksakan.',
    answerEn:
        'Occasional mild cramping can be normal — the growing womb pulls on the ligaments around it (round ligament pain), especially when you change position. Resting and moving slowly usually helps. Watch out for cramps that are severe, persistent, or come with bleeding/fluid discharge — get checked right away.',
    sourceLabel: 'Asuhan Kebidanan Kehamilan (2022) — divalidasi 2026-07-10',
    routes: ['keluhan_menu'],
  ),
  TanyaSabinaEntry(
    id: 14,
    cluster: 'K1',
    questionId: 'Nyeri punggung saat hamil, bagaimana mengatasinya?',
    questionEn: 'How do I deal with back pain during pregnancy?',
    keywordsId: ['nyeri punggung', 'sakit pinggang', 'pegal'],
    keywordsEn: ['back pain', 'lower back ache', 'sore back'],
    answerId:
        'Nyeri punggung umum terjadi karena perubahan postur dan hormon yang melenturkan sendi. Membantu: jaga postur tegak, hindari mengangkat berat, kompres hangat, senam hamil/peregangan ringan, sepatu datar, dan tidur miring dengan bantal penyangga di antara lutut.',
    answerEn:
        'Back pain is common due to postural changes and hormones that loosen the joints. What helps: keeping an upright posture, avoiding heavy lifting, warm compresses, prenatal exercise/light stretching, flat shoes, and sleeping on your side with a pillow between your knees.',
    sourceLabel: 'Konten SABINA (aktivitas fisik & perawatan harian)',
    routes: ['care/perawatan_sehari_hari'],
  ),
  TanyaSabinaEntry(
    id: 15,
    cluster: 'K1',
    questionId: 'Susah BAB (sembelit) saat hamil?',
    questionEn: 'Constipation during pregnancy?',
    keywordsId: ['sembelit', 'susah bab', 'konstipasi', 'wasir'],
    keywordsEn: ['constipation', 'hard to poop', 'hemorrhoids'],
    answerId:
        'Sembelit umum saat hamil — hormon memperlambat usus, dan tablet tambah darah juga bisa memperberat. Atasi dengan banyak serat (sayur, buah, kacang), minum air lebih banyak, dan tetap aktif bergerak. Jangan minum obat pencahar tanpa anjuran bidan/dokter. Sembelit menahun bisa memicu wasir, jadi jangan dibiarkan.',
    answerEn:
        'Constipation is common in pregnancy — hormones slow the gut, and iron tablets can make it worse. Ease it with plenty of fiber (vegetables, fruit, nuts), more water, and staying active. Don\'t take laxatives without your midwife\'s/doctor\'s advice. Chronic constipation can lead to hemorrhoids, so don\'t let it linger.',
    sourceLabel: 'Asuhan Kebidanan Kehamilan (2022)',
    routes: ['care/makanan'],
  ),

  // ── K2 — Nutrisi & Suplemen ─────────────────────────────────────────────
  TanyaSabinaEntry(
    id: 16,
    cluster: 'K2',
    questionId: 'Bolehkah minum kopi saat hamil?',
    questionEn: 'Is it okay to drink coffee during pregnancy?',
    keywordsId: ['kopi', 'kafein', 'teh', 'minuman berenergi'],
    keywordsEn: ['coffee', 'caffeine', 'tea', 'energy drink'],
    answerId:
        'Boleh, tetapi dibatasi: maksimal ==200 mg kafein per hari== — kira-kira satu cangkir kopi. Ingat kafein juga ada di teh, cokelat, dan minuman bersoda/berenergi, jadi hitung totalnya. Kafein berlebihan berkaitan dengan risiko keguguran dan berat lahir rendah.',
    answerEn:
        'Yes, but limited: no more than ==200 mg of caffeine per day== — about one cup of coffee. Remember caffeine is also in tea, chocolate, and soft/energy drinks, so count the total. Too much caffeine is linked to a higher risk of miscarriage and low birth weight.',
    sourceLabel: 'Konten SABINA (yang perlu dihindari)',
    routes: ['care/yang_perlu_dihindari'],
  ),
  TanyaSabinaEntry(
    id: 17,
    cluster: 'K2',
    questionId: 'Makanan apa saja yang dilarang saat hamil?',
    questionEn: 'What foods are off-limits during pregnancy?',
    keywordsId: ['makanan dilarang', 'pantangan makanan', 'tidak boleh dimakan'],
    keywordsEn: ['forbidden food', 'food restrictions', 'foods to avoid'],
    answerId:
        'Hindari: makanan mentah/setengah matang (sushi, telur setengah matang, daging kurang matang), susu/keju tidak dipasteurisasi (risiko ==listeria==), ikan tinggi merkuri (hiu, ikan pedang, tuna sirip biru), alkohol (sama sekali), dan batasi kafein ==200 mg/hari==. Selebihnya, makan beragam justru dianjurkan.',
    answerEn:
        'Avoid: raw/undercooked food (sushi, soft-cooked eggs, undercooked meat), unpasteurized milk/cheese (risk of ==listeria==), high-mercury fish (shark, swordfish, bluefin tuna), alcohol (entirely), and limit caffeine to ==200 mg/day==. Beyond that, eating a varied diet is actually recommended.',
    sourceLabel: 'Konten SABINA (yang perlu dihindari)',
    routes: ['care/yang_perlu_dihindari'],
  ),
  TanyaSabinaEntry(
    id: 18,
    cluster: 'K2',
    questionId: 'Ikan apa yang aman dimakan ibu hamil?',
    questionEn: 'What fish is safe for pregnant women to eat?',
    keywordsId: ['ikan', 'merkuri', 'salmon', 'lele', 'tuna'],
    keywordsEn: ['fish', 'mercury', 'salmon', 'catfish', 'tuna'],
    answerId:
        'Ikan justru sangat baik — sumber protein dan ==DHA== untuk otak janin. Pilih ikan rendah merkuri: lele, nila, kembung, bandeng, salmon, teri. Hindari ikan predator besar tinggi merkuri (hiu, ikan pedang, king mackerel, tuna sirip biru). Pastikan dimasak matang.',
    answerEn:
        'Fish is actually very good — a source of protein and ==DHA== for the baby\'s brain. Choose low-mercury fish: catfish, tilapia, mackerel, milkfish, salmon, anchovies. Avoid large predator fish high in mercury (shark, swordfish, king mackerel, bluefin tuna). Make sure it\'s fully cooked.',
    sourceLabel: 'Konten SABINA (makanan & yang dihindari)',
    routes: ['care/makanan'],
  ),
  TanyaSabinaEntry(
    id: 19,
    cluster: 'K2',
    questionId: 'Bagaimana cara minum Tablet Tambah Darah yang benar?',
    questionEn: 'What\'s the right way to take iron supplement tablets?',
    keywordsId: ['tablet tambah darah', 'ttd', 'zat besi', 'obat penambah darah'],
    keywordsEn: ['iron tablets', 'ttd', 'iron supplement', 'blood booster tablet'],
    answerId:
        '==Tablet Tambah Darah (TTD)== diminum ==1 tablet setiap hari== — program nasional menargetkan ==minimal 90 tablet== selama kehamilan — untuk mencegah anemia. Tips: minum dengan air putih atau jus buah (vitamin C membantu penyerapan), JANGAN bersamaan teh/kopi/susu karena menghambat penyerapan. Lebih nyaman diminum malam bila membuat mual.',
    answerEn:
        '==Iron supplement tablets (TTD)== are taken ==1 tablet every day== — the national program targets ==at least 90 tablets== during pregnancy — to prevent anemia. Tips: take with plain water or fruit juice (vitamin C helps absorption), and do NOT take with tea/coffee/milk as they block absorption. It\'s more comfortable to take at night if it causes nausea.',
    sourceLabel:
        'Konten SABINA (perawatan sehari-hari) + riset edukasi anemia (2023) — divalidasi 2026-07-10',
    routes: ['care/perawatan_sehari_hari'],
  ),
  TanyaSabinaEntry(
    id: 20,
    cluster: 'K2',
    questionId: 'TTD bikin mual, bagaimana?',
    questionEn: 'Iron tablets make me nauseous — what should I do?',
    keywordsId: ['mual minum ttd', 'tablet besi mual', 'sembelit ttd'],
    keywordsEn: ['nauseous from iron tablets', 'iron tablet nausea', 'iron tablet constipation'],
    answerId:
        'Efek samping TTD (mual, sembelit, BAB kehitaman) umum dan tidak berbahaya. Siasati: minum sesudah makan malam atau menjelang tidur, jangan dengan perut kosong, dan perbanyak serat + air untuk sembelit. Jangan berhenti minum TTD tanpa konsultasi — anemia jauh lebih berisiko bagi ibu dan janin.',
    answerEn:
        'Iron tablet side effects (nausea, constipation, dark stools) are common and not dangerous. Work around it: take it after dinner or before bed, not on an empty stomach, and add more fiber + water for constipation. Don\'t stop taking iron tablets without consulting first — anemia is far riskier for mother and baby.',
    sourceLabel: 'Asuhan Kebidanan Kehamilan (2022) + riset edukasi anemia (2023)',
    routes: ['care/perawatan_sehari_hari'],
  ),
  TanyaSabinaEntry(
    id: 21,
    cluster: 'K2',
    questionId: 'Asam folat itu apa dan kenapa penting?',
    questionEn: 'What is folic acid and why is it important?',
    keywordsId: ['asam folat', 'folat', 'vitamin hamil'],
    keywordsEn: ['folic acid', 'folate', 'pregnancy vitamin'],
    answerId:
        '==Asam folat== adalah vitamin B yang mencegah cacat tabung saraf pada janin — paling krusial di trimester pertama, bahkan sejak merencanakan kehamilan. Sumber alami: sayuran hijau, kacang-kacangan, jeruk. Suplemen dianjurkan ==minimal 400 mikrogram/hari== — ikuti anjuran bidan/dokter Anda.',
    answerEn:
        '==Folic acid== is a B vitamin that prevents neural tube defects in the baby — most crucial in the first trimester, even from the time you\'re planning pregnancy. Natural sources: leafy greens, nuts/beans, oranges. Supplements are recommended at ==at least 400 micrograms/day== — follow your midwife\'s/doctor\'s advice.',
    sourceLabel: 'Konten SABINA (makanan) — divalidasi 2026-07-10',
    routes: ['care/makanan'],
  ),
  TanyaSabinaEntry(
    id: 22,
    cluster: 'K2',
    questionId: 'Berapa kenaikan berat badan yang normal saat hamil?',
    questionEn: 'How much weight gain is normal during pregnancy?',
    keywordsId: ['naik berat badan', 'kenaikan bb', 'berat badan hamil'],
    keywordsEn: ['weight gain', 'pregnancy weight', 'gaining weight'],
    answerId:
        'Tergantung IMT sebelum hamil: IMT normal umumnya naik ==11,5–16 kg==; kurus lebih banyak (12,5–18 kg); berlebih lebih sedikit (7–11,5 kg). Gunakan kalkulator IMT di SABINA untuk tahu titik awal Anda, dan pantau bersama bidan di tiap pemeriksaan.',
    answerEn:
        'It depends on your pre-pregnancy BMI: normal BMI usually gains ==11.5–16 kg==; underweight gains more (12.5–18 kg); overweight gains less (7–11.5 kg). Use the BMI calculator in SABINA to know your starting point, and track it with your midwife at every check-up.',
    sourceLabel: 'Kalkulator IMT SABINA + Asuhan Kebidanan Kehamilan (2022) — divalidasi',
    routes: ['imt_calculator'],
  ),
  TanyaSabinaEntry(
    id: 23,
    cluster: 'K2',
    questionId: 'Apakah ibu hamil harus makan porsi dua orang?',
    questionEn: 'Do pregnant women need to eat for two?',
    keywordsId: ['makan dua porsi', 'porsi makan hamil', 'kalori'],
    keywordsEn: ['eating for two', 'pregnancy portions', 'calories'],
    answerId:
        'Mitos. Kebutuhan kalori hanya bertambah bertahap — trimester 2 sekitar ==+340 kkal/hari== (setara segelas susu + sepotong roti), trimester 3 sedikit lebih banyak. Yang penting kualitas: protein, zat besi, kalsium, dan sayur-buah beragam, bukan porsi ganda.',
    answerEn:
        'That\'s a myth. Calorie needs only increase gradually — around ==+340 kcal/day== in the second trimester (about a glass of milk plus a slice of bread), slightly more in the third. What matters is quality: protein, iron, calcium, and varied fruit and vegetables — not double portions.',
    sourceLabel: 'Artikel SABINA "Makanan Sehat Trimester 2"',
    routes: ['artikel/makanan_trimester2'],
  ),
  TanyaSabinaEntry(
    id: 24,
    cluster: 'K2',
    questionId: 'Bolehkah makan durian/nanas saat hamil?',
    questionEn: 'Is it okay to eat durian or pineapple during pregnancy?',
    keywordsId: ['durian', 'nanas', 'mitos makanan'],
    keywordsEn: ['durian', 'pineapple', 'food myth'],
    answerId:
        'Dalam jumlah wajar, nanas matang dan durian tidak terbukti membahayakan kehamilan — larangan mutlaknya lebih ke mitos. Yang perlu dijaga: porsi (durian tinggi gula & kalori; hati-hati bila ada diabetes gestasional) dan kebersihan buah. Bila ragu dengan kondisi khusus Anda, tanyakan ke bidan.',
    answerEn:
        'In reasonable amounts, ripe pineapple and durian have not been shown to harm pregnancy — the strict ban is more myth than fact. What to watch: portion size (durian is high in sugar and calories; be careful with gestational diabetes) and cleanliness of the fruit. If you\'re unsure about your specific condition, ask your midwife.',
    sourceLabel: 'Sikap resmi validator (2026-07-10): boleh dalam porsi wajar',
    routes: ['care/makanan'],
  ),
  TanyaSabinaEntry(
    id: 25,
    cluster: 'K2',
    questionId: 'Berapa banyak air putih yang harus diminum?',
    questionEn: 'How much water should I drink?',
    keywordsId: ['air putih', 'minum air', 'hidrasi', 'dehidrasi'],
    keywordsEn: ['water', 'drinking water', 'hydration', 'dehydration'],
    answerId:
        'Sekitar ==8–12 gelas per hari== — kebutuhan cairan naik saat hamil untuk mendukung volume darah yang bertambah hingga ==50%== dan cairan ketuban. Tanda cukup: urin kuning muda. Tambah porsi saat cuaca panas, olahraga, atau bila muntah-muntah.',
    answerEn:
        'About ==8–12 glasses a day== — fluid needs rise during pregnancy to support blood volume, which increases by up to ==50%==, plus amniotic fluid. A good sign you\'re getting enough: pale yellow urine. Drink more in hot weather, during exercise, or if you\'re vomiting.',
    sourceLabel: 'Konten SABINA (tips hidrasi) + Artikel "Makanan Sehat Trimester 2"',
    routes: ['care/makanan'],
  ),

  // ── K3 — Tanda Bahaya (semua jalur aman) ────────────────────────────────
  TanyaSabinaEntry(
    id: 26,
    cluster: 'K3',
    questionId: 'Apa saja tanda-tanda preeklampsia?',
    questionEn: 'What are the signs of preeclampsia?',
    keywordsId: ['preeklampsia', 'tanda preeklampsia', 'keracunan kehamilan'],
    keywordsEn: ['preeclampsia', 'preeclampsia signs', 'pregnancy toxemia'],
    answerId:
        'Waspadai kombinasi: ==tekanan darah tinggi==, ==sakit kepala hebat== menetap, ==pandangan kabur/berkunang==, nyeri ulu hati, ==bengkak mendadak di wajah/tangan==, dan protein dalam urin (diketahui saat periksa). Biasanya muncul setelah 20 minggu. SABINA punya Skrining Preeklampsia 12 pertanyaan — gunakan, lalu diskusikan hasilnya dengan bidan.',
    answerEn:
        'Watch for this combination: ==high blood pressure==, a persistent ==severe headache==, ==blurry or spotty vision==, upper abdominal pain, ==sudden swelling of the face/hands==, and protein in the urine (found during a check-up). It usually appears after 20 weeks. SABINA has a 12-question Preeclampsia Screening — use it, then discuss the result with your midwife.',
    sourceLabel: 'Konten SABINA (skrining preeklampsia)',
    routes: ['preeclampsia', 'consultation'],
    isSafetyPath: true,
  ),
  TanyaSabinaEntry(
    id: 27,
    cluster: 'K3',
    questionId: 'Tekanan darah saya tinggi saat periksa, bahayakah?',
    questionEn: 'My blood pressure was high at my check-up — is it dangerous?',
    keywordsId: ['tekanan darah tinggi', 'hipertensi', 'tensi tinggi'],
    keywordsEn: ['high blood pressure', 'hypertension', 'high tension'],
    answerId:
        'Tekanan darah ==≥140/90== saat hamil perlu dipantau ketat karena bisa berkembang menjadi preeklampsia. Jangan panik, tapi jangan diabaikan: rutin kontrol sesuai jadwal bidan, kurangi garam berlebih, cukup istirahat, dan kenali tanda bahaya (sakit kepala hebat, pandangan kabur). Lakukan Skrining Preeklampsia di SABINA.',
    answerEn:
        'Blood pressure of ==≥140/90== during pregnancy needs to be watched closely because it can develop into preeclampsia. Don\'t panic, but don\'t ignore it either: keep to your midwife\'s check-up schedule, cut back on excess salt, rest enough, and know the danger signs (severe headache, blurry vision). Do the Preeclampsia Screening in SABINA.',
    sourceLabel: 'Konten SABINA (skrining) — divalidasi',
    routes: ['preeclampsia', 'consultation'],
    isSafetyPath: true,
  ),
  TanyaSabinaEntry(
    id: 28,
    cluster: 'K3',
    questionId: 'Demam saat hamil, kapan harus ke dokter?',
    questionEn: 'Fever during pregnancy — when should I see a doctor?',
    keywordsId: ['demam', 'panas', 'meriang'],
    keywordsEn: ['fever', 'high temperature', 'chills'],
    answerId:
        'Demam ringan boleh dikompres dan istirahat, tetapi demam ==≥38°C==, demam yang tidak turun 1–2 hari, atau demam disertai nyeri/keluhan lain perlu diperiksakan — infeksi saat hamil harus ditangani benar. Jangan minum obat penurun panas sembarangan; parasetamol umumnya aman tetapi tetap konfirmasi ke bidan/dokter.',
    answerEn:
        'A mild fever can be managed with a compress and rest, but a fever of ==≥38°C==, one that doesn\'t go down after 1–2 days, or one with pain or other symptoms needs to be checked — infections during pregnancy must be treated properly. Don\'t take fever medicine on your own; paracetamol is generally safe but still confirm with your midwife/doctor.',
    sourceLabel: 'Asuhan Kebidanan Kehamilan (2022)',
    routes: ['consultation'],
    isSafetyPath: true,
  ),
  TanyaSabinaEntry(
    id: 29,
    cluster: 'K3',
    questionId: 'Ketuban pecah tapi belum ada mulas, harus bagaimana?',
    questionEn: 'My water broke but I have no contractions yet — what should I do?',
    keywordsId: ['ketuban pecah', 'air ketuban keluar', 'ketuban pecah dini'],
    keywordsEn: ['water broke', 'amniotic fluid leaking', 'premature rupture of membranes'],
    answerId:
        'Bila ==air ketuban sudah pecah/merembes==, jangan menunggu mulas — segera ke fasilitas persalinan, apa pun usia kehamilannya. Catat jam pecahnya, warna, dan bau cairan. Jangan berendam atau memasukkan apa pun. Semakin lama ketuban terbuka, risiko infeksi bagi bayi meningkat.',
    answerEn:
        'If your ==water has broken or is leaking==, don\'t wait for contractions — go to a birth facility right away, no matter your gestational age. Note the time it broke, the fluid\'s color, and its smell. Don\'t take a bath or insert anything. The longer the membranes stay open, the higher the infection risk for the baby.',
    sourceLabel: 'Konten SABINA (persiapan persalinan + keluhan cairan)',
    routes: ['keluhan/keluar_cairan', 'consultation'],
    isSafetyPath: true,
  ),
  TanyaSabinaEntry(
    id: 30,
    cluster: 'K3',
    questionId: 'Perdarahan banyak saat hamil tua?',
    questionEn: 'Heavy bleeding late in pregnancy?',
    keywordsId: ['perdarahan hamil tua', 'darah banyak', 'plasenta'],
    keywordsEn: ['late pregnancy bleeding', 'heavy blood', 'placenta'],
    answerId:
        'Perdarahan pada trimester akhir — apalagi banyak, merah segar, dengan atau tanpa nyeri — adalah kegawatan (bisa terkait posisi plasenta). JANGAN menunda dan jangan menunggu berhenti sendiri: langsung ke IGD/fasilitas persalinan terdekat sekarang, dan hubungi bidan Anda dalam perjalanan.',
    answerEn:
        'Bleeding in the last trimester — especially if heavy, bright red, with or without pain — is an emergency (it can be related to placenta position). DO NOT wait and don\'t expect it to stop on its own: go straight to the nearest ER/birth facility now, and call your midwife on the way.',
    sourceLabel: 'Konten SABINA (keluhan keluar darah)',
    routes: ['keluhan/keluar_darah', 'consultation'],
    isSafetyPath: true,
  ),
  TanyaSabinaEntry(
    id: 31,
    cluster: 'K3',
    questionId: 'Kapan saya harus langsung ke IGD tanpa menunggu?',
    questionEn: 'When should I go straight to the ER without waiting?',
    keywordsId: ['darurat', 'igd', 'gawat darurat', 'segera ke rumah sakit'],
    keywordsEn: ['emergency', 'er', 'urgent care', 'go to hospital now'],
    answerId:
        'Langsung ke fasilitas kesehatan bila ada salah satu: ==perdarahan banyak==, ==ketuban pecah==, ==janin tidak bergerak==, ==kejang==, ==sakit kepala hebat + pandangan kabur==, ==nyeri perut hebat==, atau ==demam tinggi==. Ini daftar yang sama dengan banner peringatan di menu Keluhan SABINA — simpan nomor bidan/faskes Anda agar cepat dihubungi.',
    answerEn:
        'Go straight to a health facility if any of these happen: ==heavy bleeding==, ==water breaking==, ==baby not moving==, ==seizures==, ==severe headache with blurry vision==, ==severe abdominal pain==, or ==high fever==. This is the same list as the warning banner in SABINA\'s Complaints menu — save your midwife\'s/facility\'s number so you can call quickly.',
    sourceLabel: 'Konten SABINA (menu keluhan)',
    routes: ['keluhan_menu', 'consultation'],
    isSafetyPath: true,
  ),
  TanyaSabinaEntry(
    id: 32,
    cluster: 'K3',
    questionId: 'Nyeri ulu hati hebat di kehamilan akhir?',
    questionEn: 'Severe upper abdominal pain late in pregnancy?',
    keywordsId: ['nyeri ulu hati', 'sakit ulu hati', 'nyeri perut atas'],
    keywordsEn: ['upper abdominal pain', 'epigastric pain', 'stomach pain under ribs'],
    answerId:
        'Nyeri ulu hati ringan bisa sekadar asam lambung, tetapi nyeri ulu hati ==hebat dan menetap== di paruh kedua kehamilan adalah salah satu tanda ==preeklampsia berat== — apalagi bila disertai sakit kepala atau pandangan kabur. Lakukan Skrining Preeklampsia dan periksakan diri segera.',
    answerEn:
        'Mild upper abdominal pain can just be acid reflux, but ==severe, persistent== upper abdominal pain in the second half of pregnancy is one of the signs of ==severe preeclampsia== — especially if it comes with a headache or blurry vision. Do the Preeclampsia Screening and get checked right away.',
    sourceLabel: 'Konten SABINA (skrining preeklampsia)',
    routes: ['preeclampsia', 'consultation'],
    isSafetyPath: true,
  ),

  // ── K4 — Perkembangan Janin & Trimester ─────────────────────────────────
  TanyaSabinaEntry(
    id: 34,
    cluster: 'K4',
    questionId: 'Kapan sebaiknya USG dan berapa kali?',
    questionEn: 'When should I get an ultrasound and how many times?',
    keywordsId: ['usg', 'periksa kandungan', 'kapan usg'],
    keywordsEn: ['ultrasound', 'usg', 'prenatal scan', 'when ultrasound'],
    answerId:
        'Program pemerintah menganjurkan pemeriksaan kehamilan (ANC) ==minimal 6 kali==, dengan USG oleh dokter minimal ==2 kali==: di trimester pertama (memastikan usia kehamilan) dan trimester ketiga (persiapan persalinan). Bidan Anda akan mengatur jadwal sesuai kondisi. Catat setiap hasil di Riwayat Pemeriksaan SABINA.',
    answerEn:
        'The government program recommends ==at least 6== antenatal care (ANC) visits, with ultrasound by a doctor at least ==2 times==: in the first trimester (to confirm gestational age) and the third trimester (to prepare for delivery). Your midwife will schedule this based on your condition. Log every result in SABINA\'s Examination History.',
    sourceLabel: 'standar ANC nasional — divalidasi 2026-07-10',
    routes: ['user_profile_riwayat'],
  ),
  TanyaSabinaEntry(
    id: 35,
    cluster: 'K4',
    questionId: 'Apa saja yang terjadi di trimester pertama?',
    questionEn: 'What happens in the first trimester?',
    keywordsId: ['trimester 1', 'hamil muda', 'awal kehamilan'],
    keywordsEn: ['first trimester', 'early pregnancy', 'first months pregnant'],
    answerId:
        'Minggu 1–13: organ-organ utama janin terbentuk — masa paling krusial. Ibu biasanya mengalami mual, lelah, payudara nyeri, sering pipis. Fokus: asam folat, hindari alkohol/rokok/obat sembarangan, dan mulai periksa ke bidan. Panduan lengkap ada di menu Trimester I SABINA.',
    answerEn:
        'Weeks 1–13: the baby\'s major organs form — the most crucial period. Mothers usually experience nausea, fatigue, breast tenderness, and frequent urination. Focus on: folic acid, avoiding alcohol/smoking/unsupervised medication, and starting check-ups with a midwife. Full guidance is in SABINA\'s Trimester I menu.',
    sourceLabel: 'Konten SABINA (trimester 1)',
    routes: ['trimester/satu'],
  ),
  TanyaSabinaEntry(
    id: 36,
    cluster: 'K4',
    questionId: 'Trimester kedua katanya paling nyaman, benarkah?',
    questionEn: 'People say the second trimester is the most comfortable — is that true?',
    keywordsId: ['trimester 2', 'hamil 4-6 bulan'],
    keywordsEn: ['second trimester', '4-6 months pregnant'],
    answerId:
        'Umumnya ya — mual mereda, energi kembali, dan Anda mulai merasakan gerakan janin (==quickening==). Ini waktu terbaik untuk senam hamil, menyiapkan kebutuhan bayi, dan menjaga nutrisi (+340 kkal/hari). Perut yang membesar mulai mengubah postur — jaga posisi tubuh.',
    answerEn:
        'Generally yes — nausea eases, energy returns, and you start feeling the baby move (==quickening==). This is the best time for prenatal exercise, preparing baby essentials, and keeping up nutrition (+340 kcal/day). Your growing belly starts to change your posture — mind your body position.',
    sourceLabel: 'Konten SABINA (trimester 2)',
    routes: ['trimester/dua'],
  ),
  TanyaSabinaEntry(
    id: 37,
    cluster: 'K4',
    questionId: 'Apa yang harus disiapkan di trimester ketiga?',
    questionEn: 'What should I prepare in the third trimester?',
    keywordsId: ['trimester 3', 'hamil tua', '7-9 bulan'],
    keywordsEn: ['third trimester', 'late pregnancy', '7-9 months pregnant'],
    answerId:
        'Minggu 28–40: pantau gerakan janin harian, kenali tanda persalinan vs ==kontraksi Braxton Hicks==, siapkan tas persalinan, tentukan tempat bersalin dan pendamping, serta periksa lebih sering sesuai jadwal bidan. Keluhan umum: sesak, bengkak kaki, sering pipis, sulit tidur — semuanya ada panduannya di SABINA.',
    answerEn:
        'Weeks 28–40: monitor fetal movement daily, learn to tell labor signs apart from ==Braxton Hicks contractions==, pack your birth bag, decide on a birth place and companion, and get checked more often per your midwife\'s schedule. Common complaints: shortness of breath, swollen feet, frequent urination, trouble sleeping — all covered in SABINA\'s guides.',
    sourceLabel: 'Konten SABINA (trimester 3)',
    routes: ['trimester/tiga'],
  ),
  TanyaSabinaEntry(
    id: 38,
    cluster: 'K4',
    questionId: 'Kapan jenis kelamin bayi bisa diketahui?',
    questionEn: 'When can the baby\'s sex be determined?',
    keywordsId: ['jenis kelamin', 'laki-laki atau perempuan', 'usg kelamin'],
    keywordsEn: ['baby sex', 'boy or girl', 'gender ultrasound'],
    answerId:
        'Lewat USG umumnya mulai terlihat di usia ==18–22 minggu==, tergantung posisi bayi dan kejelasan gambar. Tidak selalu langsung kelihatan — kadang perlu USG ulang. Yang lebih penting dari jenis kelamin: pertumbuhan dan kesejahteraan janin yang dipantau tiap pemeriksaan.',
    answerEn:
        'Via ultrasound, it usually becomes visible at ==18–22 weeks==, depending on the baby\'s position and image clarity. It\'s not always visible right away — sometimes a repeat scan is needed. More important than the sex: the baby\'s growth and wellbeing, which are monitored at every check-up.',
    sourceLabel: 'Asuhan Kebidanan Kehamilan (2022) — divalidasi',
    routes: ['baby_development'],
  ),
  TanyaSabinaEntry(
    id: 39,
    cluster: 'K4',
    questionId: 'Apakah HPL pasti tepat?',
    questionEn: 'Is the estimated due date always accurate?',
    keywordsId: ['hpl', 'hari perkiraan lahir', 'kapan lahir'],
    keywordsEn: ['due date', 'estimated delivery date', 'when will i give birth'],
    answerId:
        'HPL adalah perkiraan — hanya sekitar 1 dari 20 bayi lahir tepat di tanggalnya. Persalinan normal terjadi di rentang ==37–42 minggu==. SABINA menghitung usia kehamilan dan HPL dari HPHT Anda; gunakan sebagai panduan menyiapkan diri, bukan tanggal pasti.',
    answerEn:
        'The due date is an estimate — only about 1 in 20 babies are born exactly on that date. Normal delivery happens within a range of ==37–42 weeks==. SABINA calculates your gestational age and due date from your last period date; use it as a guide to prepare, not a fixed date.',
    sourceLabel: 'Konten SABINA (hero beranda)',
    routes: ['home'],
  ),
  TanyaSabinaEntry(
    id: 40,
    cluster: 'K4',
    questionId: 'Bayi sungsang, apakah masih bisa berputar?',
    questionEn: 'My baby is breech — can it still turn?',
    keywordsId: ['sungsang', 'posisi bayi', 'kepala di atas'],
    keywordsEn: ['breech', 'baby position', 'head up'],
    answerId:
        'Banyak bayi masih berubah posisi hingga minggu ==34–36==. Bila mendekati persalinan masih sungsang, bidan/dokter akan mendiskusikan pilihan yang aman (termasuk kemungkinan persalinan caesar). Jangan mencoba "memutar" bayi dengan pijat sendiri — selalu lewat tenaga kesehatan.',
    answerEn:
        'Many babies still change position up to weeks ==34–36==. If your baby is still breech close to delivery, your midwife/doctor will discuss safe options (including the possibility of a cesarean birth). Don\'t try to "turn" the baby with self-massage — always go through a health professional.',
    sourceLabel: 'Buku Ajar Asuhan Persalinan & BBL (2023) — divalidasi',
    routes: ['consultation'],
  ),
  TanyaSabinaEntry(
    id: 41,
    cluster: 'K4',
    questionId: 'Perut sering kencang sebentar lalu hilang, apa itu?',
    questionEn: 'My belly keeps tightening briefly then releasing — what is that?',
    keywordsId: ['perut kencang', 'kontraksi palsu', 'braxton hicks'],
    keywordsEn: ['tight belly', 'false contractions', 'braxton hicks'],
    answerId:
        'Kemungkinan ==kontraksi Braxton Hicks== ("kontraksi latihan") — tidak teratur, tidak makin kuat, dan hilang saat istirahat/ganti posisi. Berbeda dengan kontraksi persalinan yang teratur, makin sering, dan makin kuat. Bila kencang teratur sebelum 37 minggu, periksakan segera.',
    answerEn:
        'It\'s likely ==Braxton Hicks contractions== ("practice contractions") — irregular, not getting stronger, and easing with rest or a position change. This differs from labor contractions, which are regular, more frequent, and stronger over time. If the tightening becomes regular before 37 weeks, get checked right away.',
    sourceLabel: 'Konten SABINA (trimester 3)',
    routes: ['trimester/tiga'],
  ),

  // ── K5 — Aktivitas, Tidur & Stres ───────────────────────────────────────
  TanyaSabinaEntry(
    id: 42,
    cluster: 'K5',
    questionId: 'Olahraga apa yang aman untuk ibu hamil?',
    questionEn: 'What exercise is safe for pregnant women?',
    keywordsId: ['olahraga', 'senam hamil', 'jalan kaki', 'yoga'],
    keywordsEn: ['exercise', 'prenatal exercise', 'walking', 'yoga'],
    answerId:
        'Paling aman dan dianjurkan: ==jalan kaki 20–30 menit==, senam hamil, yoga prenatal, berenang, dan peregangan. Hindari olahraga berisiko jatuh/benturan. Aturan utama: konsultasi dulu sebelum mulai aktivitas baru, jangan memaksakan diri, berhenti bila pusing/nyeri, dan minum cukup.',
    answerEn:
        'Safest and recommended: ==20–30 minutes of walking==, prenatal exercise, prenatal yoga, swimming, and stretching. Avoid exercise with a risk of falling or impact. Main rules: consult first before starting a new activity, don\'t push yourself, stop if you feel dizzy or in pain, and drink enough water.',
    sourceLabel: 'Konten SABINA (aktivitas fisik) + Artikel "Olahraga Aman Saat Hamil"',
    routes: ['care/aktivitas_fisik'],
  ),
  TanyaSabinaEntry(
    id: 43,
    cluster: 'K5',
    questionId: 'Posisi tidur terbaik untuk ibu hamil?',
    questionEn: 'What\'s the best sleeping position for pregnant women?',
    keywordsId: ['posisi tidur', 'tidur miring kiri', 'susah tidur'],
    keywordsEn: ['sleep position', 'sleep on left side', 'trouble sleeping'],
    answerId:
        '==Miring ke kiri== — melancarkan aliran darah ke janin karena tidak menekan pembuluh besar (==vena cava inferior==). Gunakan bantal di antara lutut dan di bawah perut agar nyaman. Hindari telentang lama di trimester akhir. Terbangun lalu posisi berubah? Tidak apa-apa, kembalikan saja.',
    answerEn:
        'Lying on your ==left side== — it keeps blood flowing well to the baby since it doesn\'t press on the large ==inferior vena cava== vein. Use a pillow between your knees and under your belly for comfort. Avoid lying flat on your back for long periods in the last trimester. Woke up in a different position? That\'s fine, just shift back.',
    sourceLabel: 'Artikel SABINA "Tips Tidur Nyaman"',
    routes: ['artikel/tidur_nyaman'],
  ),
  TanyaSabinaEntry(
    id: 44,
    cluster: 'K5',
    questionId: 'Bolehkah ibu hamil berpuasa?',
    questionEn: 'Can pregnant women fast?',
    keywordsId: ['puasa', 'ramadhan', 'puasa hamil'],
    keywordsEn: ['fasting', 'ramadan', 'pregnancy fasting'],
    answerId:
        'Tergantung kondisi — ibu hamil sehat dengan kehamilan tanpa penyulit sebagian bisa berpuasa dengan pengaturan makan sahur-berbuka yang baik, tetapi ibu dengan mual berat, anemia, diabetes, atau kehamilan berisiko sebaiknya tidak. Agama pun memberi keringanan. Diskusikan kondisi spesifik Anda dengan bidan/dokter sebelum memutuskan.',
    answerEn:
        'It depends on your condition — healthy mothers with an uncomplicated pregnancy may be able to fast with well-planned pre-dawn and breaking-fast meals, but mothers with severe nausea, anemia, diabetes, or a high-risk pregnancy should not. Religious guidance also allows exemptions. Discuss your specific condition with your midwife/doctor before deciding.',
    sourceLabel: 'Sikap resmi validator (2026-07-10): boleh dengan syarat + konsultasi',
    routes: ['consultation'],
  ),
  TanyaSabinaEntry(
    id: 45,
    cluster: 'K5',
    questionId: 'Bolehkah naik pesawat/perjalanan jauh saat hamil?',
    questionEn: 'Is it okay to fly or travel long distances during pregnancy?',
    keywordsId: ['naik pesawat', 'mudik', 'perjalanan jauh', 'travel'],
    keywordsEn: ['flying', 'air travel', 'long trip', 'travel while pregnant'],
    answerId:
        'Umumnya aman di kehamilan sehat, ternyaman di trimester kedua. Maskapai biasanya membatasi setelah ==28–36 minggu== (perlu surat dokter). Tips: banyak minum, gerakkan kaki tiap jam, sabuk di bawah perut, bawa buku pemeriksaan/catatan SABINA. Konsultasikan dulu bila ada penyulit.',
    answerEn:
        'Generally safe in a healthy pregnancy, and most comfortable in the second trimester. Airlines usually restrict flying after ==28–36 weeks== (a doctor\'s letter is needed). Tips: drink plenty, move your legs every hour, wear the seatbelt low under your belly, and bring your check-up book/SABINA records. Consult first if you have any complications.',
    sourceLabel: 'praktik umum perjalanan kehamilan — divalidasi',
    routes: ['consultation'],
  ),
  TanyaSabinaEntry(
    id: 46,
    cluster: 'K5',
    questionId: 'Bolehkah berhubungan intim saat hamil?',
    questionEn: 'Is sex safe during pregnancy?',
    keywordsId: ['hubungan intim', 'hubungan suami istri', 'berhubungan'],
    keywordsEn: ['sex', 'intimacy', 'marital relations'],
    answerId:
        'Pada kehamilan sehat, umumnya aman sepanjang ibu nyaman — janin terlindung oleh rahim dan cairan ketuban. Perlu dihindari/dikonsultasikan dulu bila ada riwayat perdarahan, plasenta previa, ketuban rembes, atau risiko persalinan prematur. Komunikasikan dengan pasangan dan jangan ragu bertanya ke bidan.',
    answerEn:
        'In a healthy pregnancy, it\'s generally safe as long as the mother is comfortable — the baby is protected by the womb and amniotic fluid. It should be avoided or discussed first if there\'s a history of bleeding, placenta previa, leaking amniotic fluid, or risk of preterm labor. Talk with your partner and don\'t hesitate to ask your midwife.',
    sourceLabel: 'Asuhan Kebidanan Kehamilan (2022)',
    routes: ['consultation'],
  ),
  TanyaSabinaEntry(
    id: 47,
    cluster: 'K5',
    questionId: 'Apakah stres memengaruhi janin?',
    questionEn: 'Does stress affect the baby?',
    keywordsId: ['stres', 'cemas', 'pikiran', 'khawatir'],
    keywordsEn: ['stress', 'anxiety', 'worry', 'overthinking'],
    answerId:
        'Stres berkepanjangan dapat memengaruhi kesejahteraan ibu dan kehamilan, jadi kelola sejak dini: cerita ke pasangan/orang terdekat, komunitas ibu hamil, relaksasi/napas dalam, tidur cukup. Bila stres terasa berat atau berlangsung ==lebih dari 2 minggu==, bicarakan dengan bidan — bantuan profesional adalah pilihan bijak.',
    answerEn:
        'Prolonged stress can affect the wellbeing of both mother and pregnancy, so manage it early: talk to your partner/close ones, join a pregnancy community, try relaxation/deep breathing, and get enough sleep. If the stress feels heavy or lasts ==more than 2 weeks==, talk to your midwife — getting professional help is a wise choice.',
    sourceLabel: 'Artikel SABINA "Stres Kehamilan" + riset kecemasan primigravida (2024)',
    routes: ['artikel/stres_kehamilan'],
  ),
  TanyaSabinaEntry(
    id: 48,
    cluster: 'K5',
    questionId: 'Wajar tidak sih hamil pertama merasa sangat cemas?',
    questionEn: 'Is it normal to feel very anxious during a first pregnancy?',
    keywordsId: ['cemas hamil pertama', 'takut melahirkan', 'khawatir bayi'],
    keywordsEn: ['first pregnancy anxiety', 'fear of childbirth', 'worried about baby'],
    answerId:
        'Sangat wajar — kecemasan pada ==kehamilan pertama (primigravida)== nyata dan umum, terutama menjelang persalinan. Yang membantu: informasi yang benar (bukan cerita seram), kelas ibu hamil, pendamping yang suportif, dan mencatat perasaan di Jurnal Mingguan SABINA. Cemas berat yang mengganggu tidur/aktivitas layak dikonsultasikan.',
    answerEn:
        'Very normal — anxiety in a ==first pregnancy (primigravida)== is real and common, especially as birth approaches. What helps: accurate information (not scary stories), pregnancy classes, a supportive companion, and writing down your feelings in SABINA\'s Weekly Journal. Severe anxiety that disrupts sleep or daily life is worth discussing with a professional.',
    sourceLabel: 'Riset "Anxiety Levels among Primigravida" (Sukriani, 2024)',
    routes: ['weekly_journal', 'artikel/stres_kehamilan'],
  ),
  TanyaSabinaEntry(
    id: 49,
    cluster: 'K5',
    questionId: 'Ibu hamil boleh kerja berat/angkat-angkat?',
    questionEn: 'Can pregnant women do heavy work or lifting?',
    keywordsId: ['kerja berat', 'angkat berat', 'pekerjaan rumah'],
    keywordsEn: ['heavy work', 'heavy lifting', 'housework'],
    answerId:
        'Aktivitas rumah tangga ringan aman, tetapi hindari mengangkat beban berat, berdiri terlalu lama tanpa jeda, dan gerakan mendadak — terutama trimester akhir. Minta bantuan untuk pekerjaan berat itu bukan kelemahan. Bila pekerjaan menuntut fisik berat, diskusikan penyesuaian dengan atasan dan bidan.',
    answerEn:
        'Light housework is safe, but avoid lifting heavy loads, standing too long without a break, and sudden movements — especially in the last trimester. Asking for help with heavy work is not a weakness. If your job demands heavy physical work, discuss adjustments with your employer and midwife.',
    sourceLabel: 'Konten SABINA (yang perlu dihindari + stres)',
    routes: ['care/yang_perlu_dihindari'],
  ),

  // ── K6 — Persiapan Menyusui (sumber utama: sapabidan.com) ───────────────
  TanyaSabinaEntry(
    id: 50,
    cluster: 'K6',
    questionId: 'Apa itu kolostrum dan kenapa penting?',
    questionEn: 'What is colostrum and why is it important?',
    keywordsId: ['kolostrum', 'asi pertama', 'asi kuning'],
    keywordsEn: ['colostrum', 'first breast milk', 'yellow breast milk'],
    answerId:
        '==Kolostrum== adalah ASI pertama (hari 1–3): kental kekuningan, volumenya kecil (==2–20 ml==) tapi kaya antibodi — sering disebut "vaksin alami" bayi. Lambung bayi baru lahir hanya sebesar kelereng, jadi jumlah kecil itu memang cukup. Jangan dibuang dan jangan diganti apa pun.',
    answerEn:
        '==Colostrum== is the first breast milk (days 1–3): thick and yellowish, small in volume (==2–20 ml==) but rich in antibodies — often called the baby\'s "natural vaccine." A newborn\'s stomach is only marble-sized, so that small amount really is enough. Don\'t discard it and don\'t replace it with anything.',
    sourceLabel: 'sapabidan.com — "Kuning, Putih, atau Bening? 3 Jenis ASI"',
    routes: [],
  ),
  TanyaSabinaEntry(
    id: 51,
    cluster: 'K6',
    questionId: 'ASI belum keluar padahal sudah hamil tua, normalkah?',
    questionEn: 'My milk hasn\'t come in even though I\'m late in pregnancy — is that normal?',
    keywordsId: ['asi belum keluar', 'kolostrum saat hamil', 'payudara rembes'],
    keywordsEn: ['milk not coming in', 'colostrum during pregnancy', 'leaking breasts'],
    answerId:
        'Dua-duanya normal: sebagian ibu mengeluarkan sedikit kolostrum sejak trimester akhir, sebagian tidak sama sekali — keduanya TIDAK menentukan keberhasilan menyusui nanti. Produksi ASI penuh baru dipicu setelah plasenta lahir. Fokus saat hamil: pelajari posisi & perlekatan, dan niatkan IMD.',
    answerEn:
        'Both are normal: some mothers leak a little colostrum from the last trimester, others none at all — neither predicts how successful breastfeeding will be later. Full milk production only kicks in after the placenta is delivered. Focus during pregnancy: learn positioning and latch, and plan for early skin-to-skin (IMD).',
    sourceLabel: 'sapabidan.com (3 Jenis ASI) — divalidasi',
    routes: [],
  ),
  TanyaSabinaEntry(
    id: 52,
    cluster: 'K6',
    questionId: 'Apa arti ASI eksklusif?',
    questionEn: 'What does exclusive breastfeeding mean?',
    keywordsId: ['asi eksklusif', 'asi saja', '6 bulan'],
    keywordsEn: ['exclusive breastfeeding', 'breast milk only', '6 months'],
    answerId:
        'Memberi ==hanya ASI selama 6 bulan pertama== — tanpa air putih, madu, pisang, atau susu formula (vitamin/obat atas anjuran nakes diperbolehkan). ASI sudah ==88% air==, jadi bayi tidak butuh minum tambahan. Setelah 6 bulan, ASI diteruskan hingga ==2 tahun== didampingi MPASI.',
    answerEn:
        'Giving ==only breast milk for the first 6 months== — no water, honey, banana, or formula (vitamins/medicine prescribed by a health worker are allowed). Breast milk is already ==88% water==, so the baby doesn\'t need extra fluids. After 6 months, breastfeeding continues up to ==2 years== alongside solid food.',
    sourceLabel: 'sapabidan.com — "Mengapa ASI Eksklusif Itu Penting"',
    routes: [],
  ),
  TanyaSabinaEntry(
    id: 53,
    cluster: 'K6',
    questionId: 'Apa manfaat menyusui untuk ibu sendiri?',
    questionEn: 'What are the benefits of breastfeeding for the mother herself?',
    keywordsId: ['manfaat menyusui', 'keuntungan asi untuk ibu'],
    keywordsEn: ['breastfeeding benefits', 'benefits of breastfeeding for mother'],
    answerId:
        'Banyak: mempercepat pemulihan rahim dan mengurangi risiko perdarahan pasca persalinan, membakar ==300–500 kalori/hari==, menurunkan risiko kanker payudara dan ovarium, membantu menunda kehamilan (jika eksklusif), dan hormon menyusui memberi efek menenangkan. Plus hemat jutaan rupiah dibanding formula.',
    answerEn:
        'Many: it speeds up womb recovery and lowers the risk of postpartum bleeding, burns ==300–500 calories/day==, reduces the risk of breast and ovarian cancer, helps delay a new pregnancy (if exclusive), and breastfeeding hormones have a calming effect. Plus it saves a lot of money compared to formula.',
    sourceLabel: 'sapabidan.com — "Manfaat ASI dan Menyusui: 16 Fakta"',
    routes: [],
  ),
  TanyaSabinaEntry(
    id: 54,
    cluster: 'K6',
    questionId: 'Kenapa ASI lebih baik dari susu formula termahal?',
    questionEn: 'Why is breast milk better than even the most expensive formula?',
    keywordsId: ['asi vs formula', 'susu formula', 'sufor'],
    keywordsEn: ['breast milk vs formula', 'baby formula', 'formula milk'],
    answerId:
        'ASI adalah "laboratorium hidup": mengandung sel imun hidup dan antibodi ==IgA== yang tak bisa ditiru formula, komposisinya menyesuaikan diri — lebih encer saat cuaca panas, antibodinya bertambah saat bayi sakit. Formula adalah alternatif bila diperlukan, tetapi tidak setara. Diskusikan dengan bidan sebelum memutuskan.',
    answerEn:
        'Breast milk is a "living laboratory": it contains living immune cells and ==IgA== antibodies that formula cannot replicate, and its composition adapts — becoming thinner in hot weather, with more antibodies when the baby is sick. Formula is an alternative when needed, but it isn\'t equivalent. Discuss with your midwife before deciding.',
    sourceLabel: 'sapabidan.com — "Laboratorium Hidup: Gizi ASI"',
    routes: [],
  ),
  TanyaSabinaEntry(
    id: 55,
    cluster: 'K6',
    questionId: 'Posisi menyusui mana yang paling nyaman?',
    questionEn: 'Which breastfeeding position is most comfortable?',
    keywordsId: ['posisi menyusui', 'cara gendong menyusui'],
    keywordsEn: ['breastfeeding position', 'nursing hold'],
    answerId:
        'Tidak ada satu posisi "terbaik" — empat yang utama: ==cradle== (klasik), ==cross-cradle== (kontrol maksimal, cocok pemula/bayi prematur), ==football hold== (nyaman pasca caesar), dan ==berbaring miring== (untuk malam hari). Prinsipnya: bawa bayi ke payudara — bukan sebaliknya — dan tubuh bayi satu garis lurus.',
    answerEn:
        'There\'s no single "best" position — the four main ones are: ==cradle hold== (classic), ==cross-cradle hold== (most control, good for beginners/premature babies), ==football hold== (comfortable after a cesarean), and ==side-lying== (for nighttime). The principle: bring the baby to the breast — not the other way around — and keep the baby\'s body in one straight line.',
    sourceLabel: 'sapabidan.com — "4 Posisi Menyusui yang Benar"',
    routes: [],
  ),
  TanyaSabinaEntry(
    id: 56,
    cluster: 'K6',
    questionId: 'Bagaimana perlekatan menyusui yang benar?',
    questionEn: 'What does a correct breastfeeding latch look like?',
    keywordsId: ['perlekatan', 'latch', 'cara bayi menyusu'],
    keywordsEn: ['latch', 'latching', 'how baby nurses'],
    answerId:
        'Tanda perlekatan baik: mulut bayi terbuka lebar dengan ==sebagian besar areola== (bukan hanya puting) masuk mulut, bibir terlipat keluar, dagu menempel payudara, terdengar suara menelan (bukan decak), dan ibu ==tidak nyeri==. Nyeri/lecet adalah tanda perlekatan perlu diperbaiki — jangan ditahan.',
    answerEn:
        'Signs of a good latch: the baby\'s mouth opens wide with ==most of the areola== (not just the nipple) inside the mouth, lips flanged outward, chin touching the breast, you hear swallowing (not clicking), and the mother feels ==no pain==. Pain or soreness is a sign the latch needs fixing — don\'t just endure it.',
    sourceLabel: 'sapabidan.com — "Teknik Menyusui: Perlekatan Sempurna"',
    routes: [],
  ),
  TanyaSabinaEntry(
    id: 57,
    cluster: 'K6',
    questionId: 'Puting saya datar/masuk ke dalam, bisakah menyusui?',
    questionEn: 'My nipples are flat or inverted — can I still breastfeed?',
    keywordsId: ['puting datar', 'puting terbenam', 'puting masuk'],
    keywordsEn: ['flat nipples', 'inverted nipples', 'nipples not sticking out'],
    answerId:
        'Umumnya tetap bisa — bayi menyusu pada ==areola==, bukan puting. Perlekatan dalam yang benar sering menyelesaikan masalah; memerah sedikit ASI sebelum menyusui juga membantu bayi melekat. Minta bidan menilai dan mendampingi di hari-hari pertama — jangan buru-buru menyerah ke botol.',
    answerEn:
        'You usually still can — the baby nurses on the ==areola==, not the nipple. A correct deep latch often solves the problem; expressing a little milk before feeding also helps the baby latch on. Ask your midwife to assess and support you in the first days — don\'t give up and switch to a bottle too soon.',
    sourceLabel: 'sapabidan.com (teknik + ASI perah) — divalidasi',
    routes: ['consultation'],
  ),
  TanyaSabinaEntry(
    id: 58,
    cluster: 'K6',
    questionId: 'Bagaimana tahu bayi cukup ASI?',
    questionEn: 'How do I know if my baby is getting enough breast milk?',
    keywordsId: ['bayi cukup asi', 'asi cukup', 'bayi kenyang'],
    keywordsEn: ['baby getting enough milk', 'enough breast milk', 'baby full'],
    answerId:
        'Tanda utama: pipis ==6–8 kali/hari== dengan urin jernih/kuning muda, berat badan naik sesuai kurva, bayi aktif dan tampak puas setelah menyusu (tubuh rileks, tangan tidak mengepal). Payudara terasa "kosong" atau bayi sering minta menyusu BUKAN tanda ASI kurang — frekuensi 8–12 kali/hari itu normal.',
    answerEn:
        'Main signs: peeing ==6–8 times a day== with clear/pale yellow urine, weight gain following the growth curve, and the baby being active and looking satisfied after feeding (relaxed body, unclenched hands). Breasts feeling "empty" or the baby wanting to feed often are NOT signs of low milk supply — feeding 8–12 times a day is normal.',
    sourceLabel: 'sapabidan.com — "Teknik Menyusui" + "3 Jenis ASI"',
    routes: [],
  ),
  TanyaSabinaEntry(
    id: 59,
    cluster: 'K6',
    questionId: 'Kapan dan kenapa perlu belajar memerah ASI?',
    questionEn: 'When and why should I learn to express breast milk?',
    keywordsId: ['memerah asi', 'pompa asi', 'asi perah'],
    keywordsEn: ['expressing breast milk', 'pumping', 'expressed milk'],
    answerId:
        'Idealnya berlatih ==2–4 minggu sebelum kembali bekerja== — tapi setiap ibu sebaiknya bisa, sebagai "pelampung penyelamat": mengatasi payudara bengkak, mempertahankan produksi saat ibu/bayi sakit, dan menyediakan stok. Kuasai teknik tangan (==Marmet==: posisi jari huruf C, tekan ke arah dada, jangan pencet puting) dan/atau pompa.',
    answerEn:
        'Ideally practice ==2–4 weeks before returning to work== — but every mother should know how, as a "safety net": it relieves engorgement, keeps up supply when mother or baby is sick, and builds a stock. Learn the hand technique (==Marmet==: C-shaped finger position, press toward the chest, don\'t squeeze the nipple) and/or a pump.',
    sourceLabel: 'sapabidan.com — "9 Alasan Memerah ASI" + "Cara Memerah ASI"',
    routes: [],
  ),
  TanyaSabinaEntry(
    id: 60,
    cluster: 'K6',
    questionId: 'Berapa lama ASI perah tahan disimpan?',
    questionEn: 'How long can expressed breast milk be stored?',
    keywordsId: ['simpan asi', 'asi perah tahan berapa lama', 'kulkas freezer'],
    keywordsEn: ['storing breast milk', 'how long does expressed milk last', 'fridge freezer'],
    answerId:
        'Suhu ruang: ==3–4 jam==. Kulkas bawah (4°C): ==sampai 5 hari== (letakkan di bagian dalam, bukan pintu). Freezer (-18°C): ==6 bulan==. Beri label tanggal-jam, pakai yang paling lama dulu (FIFO). Cairkan di kulkas semalaman; hangatkan dengan rendaman air hangat — ==jangan microwave==. Yang sudah dihangatkan habiskan dalam 2 jam.',
    answerEn:
        'Room temperature: ==3–4 hours==. Fridge (4°C): ==up to 5 days== (store at the back, not the door). Freezer (-18°C): ==6 months==. Label with date and time, and use the oldest first (FIFO). Thaw overnight in the fridge; warm it in a bowl of warm water — ==never microwave it==. Once warmed, use within 2 hours.',
    sourceLabel: 'sapabidan.com — "Penyimpanan ASI Perah"',
    routes: [],
  ),
  TanyaSabinaEntry(
    id: 61,
    cluster: 'K6',
    questionId: 'Bagaimana memberi ASI perah tanpa bayi jadi bingung puting?',
    questionEn: 'How do I give expressed milk without causing nipple confusion?',
    keywordsId: ['bingung puting', 'botol dot', 'cup feeder'],
    keywordsEn: ['nipple confusion', 'bottle feeding', 'cup feeder'],
    answerId:
        '==Bingung puting== terjadi saat bayi terbiasa dot lalu menolak payudara. Pencegahannya: beri ASI perah dengan ==sendok, pipet, atau cup feeder==; tunda botol dot sampai menyusui langsung mantap (±==4–6 minggu==). Cek suhu ASI di pergelangan tangan sebelum diberikan — hangat kuku, bukan panas.',
    answerEn:
        '==Nipple confusion== happens when a baby gets used to a bottle teat and then refuses the breast. To prevent it: give expressed milk with a ==spoon, dropper, or cup feeder==; hold off on bottles until direct breastfeeding is well established (about ==4–6 weeks==). Check the milk\'s temperature on your wrist before feeding — lukewarm, not hot.',
    sourceLabel: 'sapabidan.com — "ASI Perah Tanpa Bingung Puting"',
    routes: [],
  ),
  TanyaSabinaEntry(
    id: 62,
    cluster: 'K6',
    questionId: 'Bagaimana merawat payudara agar siap menyusui?',
    questionEn: 'How do I care for my breasts to prepare for breastfeeding?',
    keywordsId: ['perawatan payudara', 'puting lecet', 'payudara nyeri'],
    keywordsEn: ['breast care', 'sore nipples', 'breast pain'],
    answerId:
        'Sederhana saja: bra katun yang pas tanpa kawat, bersihkan puting cukup dengan air (==hindari sabun== di area puting — menghilangkan pelindung alaminya), dan setelah menyusui oleskan setetes ASI sebagai pelembap alami. Payudara bengkak hari 3–5 pasca lahir itu normal — atasi dengan sering menyusui. Sumbatan yang memerah + demam = tanda ==mastitis==, segera ke bidan.',
    answerEn:
        'Keep it simple: a well-fitting cotton bra without underwire, clean the nipples with just water (==avoid soap== on the nipple area — it strips its natural protection), and after feeding, dab a drop of breast milk on as a natural moisturizer. Breast engorgement on days 3–5 after birth is normal — ease it by feeding often. A red, blocked area plus fever = a sign of ==mastitis== — see your midwife right away.',
    sourceLabel: 'sapabidan.com — "Perawatan Payudara" + "Atasi ASI Tersumbat"',
    routes: ['consultation'],
  ),

  // ── K7 — Persiapan Persalinan ────────────────────────────────────────────
  TanyaSabinaEntry(
    id: 63,
    cluster: 'K7',
    questionId: 'Apa saja tanda-tanda persalinan sudah dekat?',
    questionEn: 'What are the signs that labor is near?',
    keywordsId: ['tanda melahirkan', 'tanda persalinan', 'mau lahiran'],
    keywordsEn: ['signs of labor', 'labor symptoms', 'about to give birth'],
    answerId:
        'Tiga tanda utama: ==kontraksi teratur== yang makin sering, makin lama, makin kuat (tidak hilang dengan istirahat); keluar ==lendir bercampur darah==; dan ==pecahnya air ketuban==. Bila salah satu muncul — terutama ketuban pecah — berangkat ke tempat persalinan.',
    answerEn:
        'Three main signs: ==regular contractions== that become more frequent, longer, and stronger (and don\'t ease with rest); a ==blood-tinged mucus discharge==; and the ==amniotic sac breaking==. If any one appears — especially the water breaking — head to your birth place.',
    sourceLabel: 'Konten SABINA (persiapan persalinan, trimester 3)',
    routes: ['persiapan_persalinan'],
  ),
  TanyaSabinaEntry(
    id: 64,
    cluster: 'K7',
    questionId: 'Apa saja yang harus dibawa dalam tas persalinan?',
    questionEn: 'What should be packed in the hospital bag?',
    keywordsId: ['tas persalinan', 'persiapan lahiran', 'bawa apa ke rumah sakit'],
    keywordsEn: ['hospital bag', 'birth bag', 'what to bring to hospital'],
    answerId:
        'Siapkan sejak minggu ==34–36==: dokumen (KTP, BPJS/asuransi, buku KIA), perlengkapan ibu (baju ganti, pembalut nifas, bra menyusui, toiletries), perlengkapan bayi (baju, bedong, topi, popok), dan kebutuhan pendamping. Simpan di tempat yang mudah dijangkau dan beri tahu keluarga.',
    answerEn:
        'Pack it starting around weeks ==34–36==: documents (ID card, BPJS/insurance, maternal health book), items for the mother (change of clothes, postpartum pads, nursing bra, toiletries), items for the baby (clothes, swaddle, hat, diapers), and things for your companion. Keep it somewhere easy to reach and let your family know where it is.',
    sourceLabel: 'Konten SABINA (persiapan persalinan)',
    routes: ['persiapan_persalinan'],
  ),
  TanyaSabinaEntry(
    id: 65,
    cluster: 'K7',
    questionId: 'Kapan harus berangkat ke tempat bersalin?',
    questionEn: 'When should I head to the birth facility?',
    keywordsId: ['kapan ke rumah sakit', 'kapan berangkat', 'kontraksi berapa menit'],
    keywordsEn: ['when to go to hospital', 'when to leave', 'how many minutes apart contractions'],
    answerId:
        'Umumnya saat kontraksi teratur ==tiap 5 menit, berlangsung ±1 menit, selama 1 jam== (aturan 5-1-1) — atau LEBIH AWAL bila: ketuban pecah, perdarahan, gerakan janin berkurang, atau jarak ke faskes jauh. Kehamilan risiko tinggi: ikuti rencana khusus dari bidan/dokter Anda.',
    answerEn:
        'Generally when contractions are regular — ==every 5 minutes, lasting about 1 minute, for 1 hour== (the 5-1-1 rule) — or EARLIER if: your water breaks, you have bleeding, fetal movement decreases, or the facility is far away. For a high-risk pregnancy, follow the specific plan from your midwife/doctor.',
    sourceLabel: 'Buku Ajar Asuhan Persalinan & BBL (2023) — divalidasi',
    routes: ['persiapan_persalinan', 'consultation'],
  ),
  TanyaSabinaEntry(
    id: 66,
    cluster: 'K7',
    questionId: 'Bagaimana mengurangi nyeri saat persalinan?',
    questionEn: 'How can I reduce pain during labor?',
    keywordsId: ['nyeri persalinan', 'mengurangi sakit melahirkan', 'teknik napas'],
    keywordsEn: ['labor pain', 'reducing birth pain', 'breathing technique'],
    answerId:
        'Yang terbukti membantu: teknik ==napas dalam== dan relaksasi, berjalan/berganti posisi di awal persalinan, pijatan punggung bawah oleh pendamping, kompres hangat, dan dukungan pendamping yang menenangkan. Diskusikan pilihan manajemen nyeri lain dengan penolong persalinan Anda.',
    answerEn:
        'What\'s proven to help: ==deep breathing== and relaxation techniques, walking or changing position early in labor, lower-back massage from a companion, warm compresses, and calm support from a companion. Discuss other pain management options with your birth attendant.',
    sourceLabel: 'Konten SABINA (persiapan persalinan) — divalidasi',
    routes: ['persiapan_persalinan'],
  ),
  TanyaSabinaEntry(
    id: 67,
    cluster: 'K7',
    questionId: 'Apa itu IMD (Inisiasi Menyusu Dini)?',
    questionEn: 'What is early initiation of breastfeeding (IMD)?',
    keywordsId: ['imd', 'inisiasi menyusu dini', 'skin to skin'],
    keywordsEn: ['imd', 'early breastfeeding initiation', 'skin to skin'],
    answerId:
        '==IMD== adalah meletakkan bayi di dada ibu segera setelah lahir (kontak kulit-ke-kulit) selama minimal ==1 jam==, membiarkan bayi mencari payudara sendiri. Manfaat: bayi mendapat kolostrum, menyusui lebih berhasil, ikatan ibu-bayi kuat, dan membantu rahim berkontraksi. Sampaikan keinginan IMD ke penolong persalinan sejak sebelum bersalin.',
    answerEn:
        '==IMD== means placing the baby on the mother\'s chest right after birth (skin-to-skin contact) for at least ==1 hour==, letting the baby find the breast on its own. Benefits: the baby gets colostrum, breastfeeding succeeds more often, mother-baby bonding is stronger, and it helps the womb contract. Let your birth attendant know you want IMD before you give birth.',
    sourceLabel: 'sapabidan.com (ASI eksklusif) — divalidasi',
    routes: ['persiapan_persalinan'],
  ),
  TanyaSabinaEntry(
    id: 68,
    cluster: 'K7',
    questionId: 'Melahirkan di mana yang sebaiknya dipilih?',
    questionEn: 'Where should I choose to give birth?',
    keywordsId: ['tempat bersalin', 'melahirkan di bidan', 'rumah sakit'],
    keywordsEn: ['birth place', 'giving birth at midwife', 'hospital'],
    answerId:
        'Pilih fasilitas kesehatan dengan tenaga terlatih — puskesmas/praktik bidan untuk kehamilan tanpa penyulit, atau rumah sakit bila ada faktor risiko (hasil skrining SABINA membantu mengenalinya). Pertimbangkan jarak, biaya/BPJS, dan rencanakan sejak trimester ketiga bersama keluarga. Persalinan di fasilitas kesehatan jauh lebih aman daripada di rumah.',
    answerEn:
        'Choose a health facility with trained staff — a community health center/midwife practice for an uncomplicated pregnancy, or a hospital if there are risk factors (SABINA\'s screening results help identify these). Consider distance, cost/BPJS coverage, and plan it with your family from the third trimester. Giving birth at a health facility is far safer than at home.',
    sourceLabel: 'Riset pemilihan tempat persalinan (Sukriani dkk., 2023) + penapisan SABINA',
    routes: ['penapisan', 'persiapan_persalinan'],
  ),

  // ── K8 — KB & Pasca Persalinan ────────────────────────────────────────────
  TanyaSabinaEntry(
    id: 69,
    cluster: 'K8',
    questionId: 'Kapan bisa hamil lagi setelah melahirkan?',
    questionEn: 'When can I get pregnant again after giving birth?',
    keywordsId: ['hamil lagi', 'kesuburan setelah melahirkan', 'jarak kehamilan'],
    keywordsEn: ['pregnant again', 'fertility after birth', 'pregnancy spacing'],
    answerId:
        'Kesuburan bisa kembali ==sebelum haid pertama== pasca melahirkan — jadi kehamilan bisa terjadi lebih cepat dari dugaan. Jarak antar kehamilan yang dianjurkan minimal ==2 tahun== demi pemulihan ibu dan kesehatan bayi. Rencanakan KB sejak masa nifas bersama bidan.',
    answerEn:
        'Fertility can return ==before your first period== after giving birth — so pregnancy can happen sooner than you\'d expect. The recommended spacing between pregnancies is at least ==2 years== for the mother\'s recovery and the baby\'s health. Plan contraception from the postpartum period together with your midwife.',
    sourceLabel: 'Buku "KB dan Kesehatan Reproduksi" (Sukriani, 2023) — divalidasi',
    routes: ['consultation'],
  ),
  TanyaSabinaEntry(
    id: 70,
    cluster: 'K8',
    questionId: 'Benarkah menyusui bisa jadi KB alami?',
    questionEn: 'Is it true that breastfeeding can work as natural birth control?',
    keywordsId: ['kb alami', 'mal', 'menyusui mencegah hamil'],
    keywordsEn: ['natural birth control', 'lam', 'breastfeeding prevents pregnancy'],
    answerId:
        'Metode Amenorea Laktasi (==MAL==) efektif hingga ==98%== HANYA bila tiga syarat terpenuhi sekaligus: ASI eksklusif (siang-malam, tanpa selingan), belum haid, DAN bayi belum 6 bulan. Bila satu saja tidak terpenuhi, perlindungannya turun — siapkan metode KB lanjutan.',
    answerEn:
        'The Lactational Amenorrhea Method (==LAM==) is up to ==98%== effective ONLY if all three conditions are met at once: exclusive breastfeeding (day and night, no supplements), no period yet, AND the baby is under 6 months. If even one condition isn\'t met, protection drops — have a follow-up contraception method ready.',
    sourceLabel: 'sapabidan.com (Manfaat ASI) + buku KB & Kespro (2023) — divalidasi 2026-07-10',
    routes: ['consultation'],
  ),
  TanyaSabinaEntry(
    id: 71,
    cluster: 'K8',
    questionId: 'KB apa yang aman untuk ibu menyusui?',
    questionEn: 'What birth control is safe for breastfeeding mothers?',
    keywordsId: ['kb menyusui', 'kontrasepsi asi', 'kb pasca melahirkan'],
    keywordsEn: ['birth control while breastfeeding', 'contraception and breast milk', 'postpartum birth control'],
    answerId:
        'Beberapa pilihan yang tidak mengganggu produksi ASI antara lain: metode nonhormonal (IUD/AKDR, kondom) dan KB progestin (pil mini, suntik 3 bulan, implan). KB kombinasi (mengandung estrogen) umumnya ditunda dulu. Pilihan terbaik tergantung kondisi Anda — konsultasikan dengan bidan.',
    answerEn:
        'Some options that don\'t affect milk supply include: non-hormonal methods (IUD, condoms) and progestin-only contraception (mini pill, 3-month injection, implant). Combined contraception (containing estrogen) is generally postponed. The best choice depends on your condition — consult your midwife.',
    sourceLabel: 'Buku "KB dan Kesehatan Reproduksi" (Sukriani, 2023) — divalidasi',
    routes: ['consultation'],
  ),
  TanyaSabinaEntry(
    id: 72,
    cluster: 'K8',
    questionId: 'Apa itu masa nifas dan berapa lama?',
    questionEn: 'What is the postpartum period and how long does it last?',
    keywordsId: ['nifas', 'masa nifas', 'darah nifas'],
    keywordsEn: ['postpartum', 'postpartum period', 'postpartum bleeding'],
    answerId:
        'Masa nifas adalah pemulihan setelah persalinan, berlangsung sekitar ==6 minggu (42 hari)==. Darah nifas (lokia) normal berangsur berubah dari merah → kecokelatan → kekuningan → bening. Waspadai: darah kembali banyak, berbau busuk, demam, atau nyeri hebat — segera periksa. Jadwalkan kunjungan nifas sesuai anjuran bidan.',
    answerEn:
        'The postpartum period is the recovery after birth, lasting about ==6 weeks (42 days)==. Normal postpartum bleeding (lochia) gradually changes from red → brownish → yellowish → clear. Watch for: bleeding becoming heavy again, a foul smell, fever, or severe pain — get checked right away. Schedule postpartum visits as advised by your midwife.',
    sourceLabel:
        'Buku "Asuhan Kebidanan Pada Nifas" (2023) + "Asuhan Holistik Masa Nifas dan Menyusui" (2024) — divalidasi 2026-07-10',
    routes: ['consultation'],
  ),
  TanyaSabinaEntry(
    id: 73,
    cluster: 'K8',
    questionId: 'Sedih terus setelah melahirkan, apakah baby blues?',
    questionEn: 'Feeling sad all the time after giving birth — is this baby blues?',
    keywordsId: ['baby blues', 'sedih setelah melahirkan', 'depresi pasca melahirkan'],
    keywordsEn: ['baby blues', 'sad after birth', 'postpartum depression'],
    answerId:
        'Perasaan sedih/mudah menangis di ==2 minggu pertama== pasca melahirkan (baby blues) dialami banyak ibu dan biasanya membaik sendiri dengan istirahat & dukungan keluarga. Bila berlangsung ==lebih dari 2 minggu==, makin berat, atau muncul pikiran menyakiti diri/bayi — itu tanda perlu bantuan profesional SEGERA. Bercerita bukan kelemahan.',
    answerEn:
        'Feeling sad or crying easily in the ==first 2 weeks== after birth (baby blues) is experienced by many mothers and usually improves on its own with rest and family support. If it lasts ==more than 2 weeks==, gets worse, or thoughts of harming yourself/the baby appear — that\'s a sign professional help is needed RIGHT AWAY. Talking about it is not a weakness.',
    sourceLabel: 'Artikel SABINA (stres) + buku Nifas — divalidasi',
    routes: ['artikel/stres_kehamilan', 'consultation'],
  ),
];
