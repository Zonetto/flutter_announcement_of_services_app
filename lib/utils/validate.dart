
class ValidTextForm {
  final String _empty = "لا يمكن ترك الحقل فارغ";
  String? emptyText(
    String? value,
  ) {
    if (value!.isEmpty) {
      return _empty;
    }
    return null;
  }

  String? email(
    String? value,
  ) {
    if (value!.isEmpty) {
      return emptyText(value);
    }
    if (!value.contains('@gmail')) {
      return "يجب ان يحتوي email على @gmail";
    }
    if (!value.contains('.com')) {
      return "يجب ان يحتوي email على com.";
    }
    return null;
  }

  String? password(
    String? value,
  ) {
    if (value!.isEmpty) {
      return emptyText(value);
    }
    if (value.length <= 5) {
      return "يجب أن تكون كلمة المرور اكبر من 7 رموز";
    }
    return null;
  }

  String? confirmPassword(
    String? confirmPassword,
    String? primaryPassword,
  ) {
    if (confirmPassword!.isEmpty) {
      return emptyText(confirmPassword);
    }
    if (confirmPassword != primaryPassword) {
      return "كلمة المرور غير متطابقة";
    }
    return null;
  }

  String? nullText(
    String? value,
  ) {
    if (value == null) {
      return _empty;
    }
    return null;
  }

  String? call(
    String? value,
  ) {
    if (value!.isEmpty) {
      return emptyText(value);
    }
    if (value.length < 11) {
      return "يجب ان يكون رقم الهاتف ١١ رقم";
    }
    return null;
  }
}
