import 'package:brew/models/brew.dart';
import 'package:brew/models/person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{
  
  final String uid;
  DatabaseService({required this.uid});
  
  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
  
  Future updateUserData(String sugars, String name, int strength )async {
   
    return await  brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength' : strength,
    });
    
  }

  // brew list
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>; // Fix: call data() as a map
      return Brew(
        name: data['name'] ?? '',
        strength: data['strength'] ?? 0,
        sugars: data['sugars'] ?? '0',
      );
    }).toList();
  }

  //userData from snapshots
  PersonData _personDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;

    if (data == null) {
      // Return default data or handle appropriately
      return PersonData(uid: uid, name: '', sugars: '0', strength: 100);
    }

    return PersonData(
      uid: uid,
      name: data['name'] ?? '',
      sugars: data['sugars'] ?? '0',
      strength: data['strength'] ?? 100,
    );
  }

  // get stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream <PersonData> get userData{
    return brewCollection.doc(uid).snapshots().map(_personDataFromSnapshot);
  }

}