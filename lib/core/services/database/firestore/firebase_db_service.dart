import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mvvm_template/core/models/user/profile.dart';

class FirebaseService {
  //TODO update all the references according to your database structure
  final CollectionReference usersReference =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference adminReference =
      FirebaseFirestore.instance.collection('Admin');
  final CollectionReference appointmentsReference =
      FirebaseFirestore.instance.collection('Appointments');
  final CollectionReference sellReference =
      FirebaseFirestore.instance.collection('Sells');
  final CollectionReference chatsReference =
      FirebaseFirestore.instance.collection('Chats');
  final CollectionReference complainsReference =
      FirebaseFirestore.instance.collection('Complains');

  ///Uploads the [UserProfile] data to the users collection
  ///
  ///**Important**: This function assumes that you have not set the uid
  ///for the user, it creates a document first, fetches the id of the document,
  ///assigns the docId to the uid and then uploads the data to the newly created document
  Future<void> uploadUserData(UserProfile user) async {
    var docRef = usersReference.doc();
    user.uid = docRef.id;
    await usersReference.doc(user.uid).set(user.toJson());
  }

  ///Updates the [fields] provided to the function for the given user
  ///
  ///**Important**: This function can be used to update any number of fields
  Future updateUserInfo(String uid, Map<String, dynamic> fields) async {
    return await usersReference.doc(uid).update(fields);
  }

  ///Returns a [UserProfile] for the given [uid]
  Future<UserProfile> getUserData(String uid) async {
    var docSnap = await usersReference.doc(uid).get();
    return UserProfile.fromJson(docSnap.data() as Map<String, dynamic>);
  }

  ///Updates the [fcm] token for the given [uid]
  ///
  ///**Important**: This function assumes that the field name is "fcmToken".
  ///Change it if you have named it something else
  Future<void> updateFCMToken(String uid, String? fcm) async {
    await usersReference.doc(uid).update({
      'fcmToken': fcm,
    });
  }

  ///Returns a [Stream] of all the [UserProfile] accounts in the users collection
  Stream<List<UserProfile>> getAllUsersStream() {
    Stream<QuerySnapshot<Object?>> stream = usersReference.snapshots();

    var result = stream.map((qSnap) => qSnap.docs
        .map((doc) => UserProfile.fromJson(doc.data() as Map<String, dynamic>))
        .toList());

    return result;
  }

  ///Uploads the [file] to the given [path] in [FirebaseStorage] and
  ///returns the downloadUrl for the [file]
  Future<String> uploadFile(File file, String path) async {
    FirebaseStorage storage = FirebaseStorage.instanceFor();
    Reference firebaseStorageRef = storage.ref().child(path);
    UploadTask uploadTask = firebaseStorageRef.putFile(file);
    String downloadUrl =
        await uploadTask.then((taskSnap) => taskSnap.ref.getDownloadURL());
    return downloadUrl;
  }

  ///Deletes the data of the [uid] user
  Future deleteUserData(String uid) async {
    return usersReference.doc(uid).delete();
  }
}
