// Kelas Induk
class Contact {
  String name;
  String phone;

  Contact(this.name, this.phone);

  String display() {
    return "$name • $phone";
  }
}

// Kelas Turunan: PersonalContact
class PersonalContact extends Contact {
  DateTime? birthDate;

  PersonalContact(String name, String phone, {this.birthDate})
      : super(name, phone);

  @override
  String display() {
    String result = "[Personal] $name • $phone";
    if (birthDate != null) {
      String dob =
          "${birthDate!.year.toString().padLeft(4, '0')}-"
          "${birthDate!.month.toString().padLeft(2, '0')}-"
          "${birthDate!.day.toString().padLeft(2, '0')}";
      result += " • DOB: $dob";
    }
    return result;
  }
}

// Kelas Turunan: BusinessContact
class BusinessContact extends Contact {
  String company;

  BusinessContact(String name, String phone, this.company)
      : super(name, phone);

  @override
  String display() {
    return "[Business] $name • $phone • $company";
  }
}

void main() {
  // Variabel bertipe Contact (Polymorphism)
  Contact contact;

  // 1. Objek Contact biasa
  contact = Contact("Andi", "081234567890");
  print(contact.display());

  // 2. Objek PersonalContact
  contact = PersonalContact(
    "Budi",
    "089876543210",
    birthDate: DateTime(2000, 5, 10),
  );
  print(contact.display());

  // 3. Objek BusinessContact
  contact = BusinessContact(
    "Cindy",
    "082143658709",
    "PT Sinar Jaya",
  );
  print(contact.display());
}