/// The type of account.
enum AccountType {
  /// A student account.
  student,

  /// A teacher account.
  teacher,

  /// A parent account.
  parent,

  /// A staff account.
  admin,

  /// A development account.
  dev;

  /// Convert a [String] into an [AccountType].
  // TODO(lishaduck): Use Appwrite roles once they're properly hooked up.
  factory AccountType.fromEmail(String email) {
    return email.endsWith("@student.psdr3.org")
        ? AccountType.student
        : email.endsWith("@psdr3.org")
            ? AccountType.teacher
            : AccountType.dev;
  }
}
