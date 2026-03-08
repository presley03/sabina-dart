class MedicalValidators {
  // Validasi berat badan (kg)
  static String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Berat badan tidak boleh kosong';
    }
    
    final weight = double.tryParse(value);
    if (weight == null) {
      return 'Masukkan angka yang valid';
    }
    
    if (weight < 30 || weight > 200) {
      return 'Berat badan harus antara 30-200 kg';
    }
    
    return null;
  }

  // Validasi tinggi badan (cm)
  static String? validateHeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tinggi badan tidak boleh kosong';
    }
    
    final height = double.tryParse(value);
    if (height == null) {
      return 'Masukkan angka yang valid';
    }
    
    if (height < 100 || height > 250) {
      return 'Tinggi badan harus antara 100-250 cm';
    }
    
    return null;
  }

  // Validasi usia kehamilan
  static String? validateGestationalAge(int weeks, int days) {
    if (weeks < 0 || weeks > 42) {
      return 'Minggu kehamilan harus antara 0-42';
    }
    
    if (days < 0 || days > 6) {
      return 'Hari harus antara 0-6';
    }
    
    return null;
  }

  // Validasi tekanan darah
  static String? validateBloodPressure(String? systolic, String? diastolic) {
    if (systolic == null || systolic.isEmpty || diastolic == null || diastolic.isEmpty) {
      return 'Tekanan darah tidak boleh kosong';
    }
    
    final sys = int.tryParse(systolic);
    final dia = int.tryParse(diastolic);
    
    if (sys == null || dia == null) {
      return 'Masukkan angka yang valid';
    }
    
    if (sys < 70 || sys > 250 || dia < 40 || dia > 150) {
      return 'Tekanan darah tidak dalam rentang normal';
    }
    
    if (sys <= dia) {
      return 'Tekanan sistolik harus lebih tinggi dari diastolik';
    }
    
    return null;
  }

  // Validasi nama lengkap
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama lengkap tidak boleh kosong';
    }
    
    if (value.length < 2) {
      return 'Nama terlalu pendek';
    }
    
    if (value.length > 50) {
      return 'Nama terlalu panjang (maksimal 50 karakter)';
    }
    
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Nama hanya boleh mengandung huruf dan spasi';
    }
    
    return null;
  }

  // Validasi alamat
  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Alamat tidak boleh kosong';
    }
    
    if (value.length < 10) {
      return 'Alamat terlalu pendek (minimal 10 karakter)';
    }
    
    if (value.length > 200) {
      return 'Alamat terlalu panjang (maksimal 200 karakter)';
    }
    
    return null;
  }

  // Validasi tanggal lahir
  static String? validateBirthDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tanggal lahir tidak boleh kosong';
    }
    
    try {
      final birthDate = DateTime.parse(value.replaceAll('-', '/'));
      final now = DateTime.now();
      final age = now.difference(birthDate).inDays ~/ 365;
      
      if (age < 12 || age > 60) {
        return 'Usia harus antara 12-60 tahun';
      }
      
      return null;
    } catch (e) {
      return 'Format tanggal tidak valid';
    }
  }

  // Validasi nomor telepon
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
    
    if (!RegExp(r'^(\+62|62|0)[0-9]{9,13}$').hasMatch(value)) {
      return 'Format nomor telepon tidak valid';
    }
    
    return null;
  }

  // Validasi email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Email opsional
    }
    
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Format email tidak valid';
    }
    
    return null;
  }

  // Validasi berat badan bayi lahir
  static String? validateBabyBirthWeight(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Opsional untuk kehamilan pertama
    }
    
    final weight = double.tryParse(value);
    if (weight == null) {
      return 'Masukkan angka yang valid';
    }
    
    if (weight < 0.5 || weight > 6.0) {
      return 'Berat badan bayi harus antara 0.5-6.0 kg';
    }
    
    return null;
  }

  // Validasi tahun kelahiran
  static String? validateBirthYear(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Opsional
    }
    
    final year = int.tryParse(value);
    if (year == null) {
      return 'Masukkan tahun yang valid';
    }
    
    final currentYear = DateTime.now().year;
    if (year < 1950 || year > currentYear) {
      return 'Tahun tidak valid';
    }
    
    return null;
  }
} 