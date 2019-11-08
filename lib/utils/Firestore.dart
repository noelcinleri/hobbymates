import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobby_mates/utils/utils.dart';

class FirestoreData {
  String userName;
  String adSoyad;
  String mail;
  String numara;
  int yas;
  List<String> rooms = List();
  FirestoreData();

  FirestoreData.fromMap(Map<String, dynamic> map) {
    this.userName = map['userName'];
    this.adSoyad = map['adSoyad'];
    this.mail = map['mail'];
    this.numara = map['numara'];
    this.yas = map['yas'];
    this.rooms = map['rooms'];
  }
}

class FirestoreMessage {
  String message, time, username, type, replyText, replyName;
  bool isMe, isGroup, isReply;

  FirestoreMessage();

  FirestoreMessage.fromMap(Map<String, dynamic> map) {
    message = map['message'];
    time = map['time'];
    username = map['username'];
    type = map['type'];
    replyText = map['replyText'];
    replyName = map['replyName'];
    isMe = map['isMe'];
    isGroup = map['isGroup'];
    isReply = map['isReply'];
  }
}

class FireStoreHobby {
  final String hobbyName;
  final int id;
  FireStoreHobby(this.hobbyName, this.id);
}

class Data {
  static Firestore db = Firestore.instance;
  CollectionReference notesCollectionRef = db.collection('users');

  static FirestoreData getDataById(String id) {
    try {
      FirestoreData dt = FirestoreData();
      final TransactionHandler createTransaction = (Transaction tx) async {
        final DocumentSnapshot ds =
            await tx.get(db.collection('users').document(id));
        dt.userName = ds.data['userName'];
        dt.adSoyad = ds.data['adSoyad'];
        dt.mail = ds.data['mail'];
        dt.numara = ds.data['yas'];
      };

      Firestore.instance.runTransaction(createTransaction).then((mapData) {
        return FirestoreData.fromMap(mapData);
      }).catchError((error) {
        print('error: $error');
        return null;
      });
      return dt;
    } catch (e) {
      print("Error => ${e.toString()}");
      return null;
    }
  }

  static createUser(String id, String userName, String adSoyad, String mail,
      String numara, yas, rooms) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(db.collection('users').document(id));

      var dataMap = new Map<String, dynamic>();
      dataMap['userName'] = userName;
      dataMap['adSoyad'] = adSoyad;
      dataMap['mail'] = mail;
      dataMap['yas'] = yas;
      dataMap['rooms'] = rooms;
      dataMap['numara'] = numara;

      await tx.set(ds.reference, dataMap);

      return dataMap;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return null;
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  static updateUser(String uid, String dataTitle, newData) async {
    await db.collection('users').document(uid).updateData({dataTitle: newData});
  }

  static getHobby() async {
    List<FireStoreHobby> hobbies = List();
    await db.collection('hobbies').getDocuments().then((snap) {
      var documents = snap.documents;
      for (DocumentSnapshot document in documents) {
        print('name> ${hobbies.length}');
        hobbies
            .add(FireStoreHobby(document.documentID, document.data['hobi_ID']));
      }
    });
  }

  static setHobbyMaters(hobbyName) async {
    db.collection('hobbies').document(hobbyName).get().then((e) {
      var a;
      int id = e.data['hobi_ID'];
      if (e.data['hobbyMates'] != null) {
        List ad = List();
        if (e.data['hobbyMates'].contains(Uid.uid)) {
          ad = e.data['hobbyMates'];
          var i = e.data['hobbyMates'].indexOf(Uid.uid);
          ad[i] = '';
          a = ad;
        } else {
          a = e.data['hobbyMates'] + [Uid.uid];
        }
      } else {
        a = [Uid.uid];
      }
      db
          .collection('hobbies')
          .document(hobbyName)
          .setData({'hobbyMates': a, 'hobi_ID': id});
    });
  }

  static FirestoreData getDataByUid(String uid) {
    FirestoreData dt = FirestoreData();
    try {
      final document = db.collection('users').document(uid);
      document.get().then((document) {
        dt.userName = document['userName'];
        dt.adSoyad = document['adSoyad'];
        dt.mail = document['mail'];
        dt.numara = document['numara'];
        dt.yas = document['yas'];
        dt.rooms = document['rooms'];
      });
    } catch (e) {
      print("getDataByUid ERROR => ${e.toString()}");
    }
    return dt;
  }

  static FirestoreData documentToFirestoreData(document) {
    FirestoreData dt = FirestoreData();
    try {
      dt.userName = document['userName'];
      dt.adSoyad = document['adSoyad'];
      dt.mail = document['mail'];
      dt.numara = document['numara'];
      dt.yas = document['yas'];
      dt.rooms = document['rooms'];
    } catch (e) {
      print("dtToFirestoreData ERROR => ${e.toString()}");
    }
    return dt;
  }

  static FirestoreMessage getMessages(String uid) {
    FirestoreMessage dt = FirestoreMessage();
    String roomId = '1';
    try {
      final document = db.collection('rooms').document(roomId);
      document.get().then((map) {
        dt.message = map['message'];
        dt.time = map['time'];
        dt.username = map['username'];
        dt.type = map['type'];
        dt.replyText = map['replyText'];
        dt.replyName = map['replyName'];
        dt.isMe = map['isMe'];
        dt.isGroup = map['isGroup'];
        dt.isReply = map['isReply'];
      });
    } catch (e) {
      print("getDataByUid ERROR => ${e.toString()}");
    }
    return dt;
  }
}
