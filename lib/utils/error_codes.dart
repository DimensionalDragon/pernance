final List<RegExp> fatalResponseCodes = [
  // Class 22 - Data Exception (data type mismatch)
  RegExp(r'^22...$'),
  // Class 23 - Integrity Constraint Violation (database FK, NOT NULL, and related violations)
  RegExp(r'^23...$'),
  // Insufficient Privilege - Row level violation
  RegExp(r'^42501$'),
];