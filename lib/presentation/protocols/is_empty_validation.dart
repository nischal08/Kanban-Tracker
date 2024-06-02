import 'package:kanban/presentation/protocols/validation.dart';

class IsEmptyValidation extends Validation {
  @override
  String? validate(String value) {
    if (value.trim().isEmpty) {
      return "Please enter your the valid";
    }
    return null;
  }
}
