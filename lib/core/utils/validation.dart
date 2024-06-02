class Validation {
  String? validate(String value, {required String title}) {
    if (value.trim().isEmpty) {
      return "Please enter your $title";
    }
    return null;
  }
}
