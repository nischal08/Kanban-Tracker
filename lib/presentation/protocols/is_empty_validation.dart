import 'package:kanban/presentation/protocols/validation.dart';

class IsEmptyValidation extends Validation {
  @override
  String? validate(String value, {String? title}) {
    if (value.trim().isEmpty) {
      if (title != null) {
        return "Please enter the valid $title.";
      } else {
        return "Please enter the valid input.";
      }
    }
    return null;
  }
}
