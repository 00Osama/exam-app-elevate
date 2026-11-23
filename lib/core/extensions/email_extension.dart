extension EmailExtension on String {
  /// Whether this string is a syntactically valid email address.
  bool get isValidEmail {
    final email = trim();

    if (email.isEmpty || email.length > 254) {
      return false;
    }

    final parts = email.split('@');
    if (parts.length != 2) {
      return false;
    }

    final localPart = parts[0];
    final domain = parts[1];

    if (localPart.isEmpty ||
        localPart.length > 64 ||
        localPart.startsWith('.') ||
        localPart.endsWith('.') ||
        localPart.contains('..')) {
      return false;
    }

    final localPartPattern = RegExp(
      r"^[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*$",
    );
    if (!localPartPattern.hasMatch(localPart)) {
      return false;
    }

    if (domain.isEmpty ||
        domain.length > 253 ||
        domain.startsWith('.') ||
        domain.endsWith('.') ||
        domain.contains('..')) {
      return false;
    }

    final domainLabels = domain.split('.');
    if (domainLabels.length < 2) {
      return false;
    }

    final domainLabelPattern = RegExp(
      r'^[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?$',
    );
    return domainLabels.every(
      (label) =>
          label.isNotEmpty &&
          label.length <= 63 &&
          domainLabelPattern.hasMatch(label),
    );
  }

  /// Alias for [isValidEmail].
  bool get isEmailValid => isValidEmail;
}
