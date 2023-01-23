import 'package:firedart/firedart.dart';
import 'package:wireless_build/data_model/data_class.dart';

String projectId ='wireless-build-tool';

bool? isExist;
List<String> IdList=[];
bool? commandSuccess=false;


var reff = Firestore.instance.collection('users');

Future getUsersFromFirestore(String id)async {
  return await  reff.document(id).get();
}

/*CollectionReference getTaskCollection() {
  return FirebaseFirestore.instance.collection('users').withConverter<User>(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (task, _) => task.toJson(),
      );
}

Future<void> addTaskToFirebase(User user) async {
  var collection = getTaskCollection();
  var docRef = collection.doc(user.userId);
  return await docRef.set(user);
}

 Future getUsersFromFirestore(String id)async {
  return await  getTaskCollection().doc(id).get()
      ;
}
*/
Future getAllDocument() async {
    await reff.get().then((value) => value.forEach((element) {
      IdList.add(element.id);
      
    }));
    //print(IdList);
  
}
