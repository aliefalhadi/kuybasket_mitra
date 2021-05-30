class Validations {
  static String stringValidation(String value) {
    if (value.isEmpty) {
      return 'inputan tidak boleh kosong';
    }
    return null;
  }
}