class Person {
  final String uid;

  Person({required this.uid});
}

class PersonData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  PersonData({
    required this.uid,
    required this.name,
    required this.sugars,
    required this.strength,
  });
}
