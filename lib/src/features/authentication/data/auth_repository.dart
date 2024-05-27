import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/main.dart';
import 'package:rossoneri_store/src/constants/test_user.dart';
import 'package:rossoneri_store/src/features/authentication/data/firebase_app_user.dart';
import 'package:rossoneri_store/src/features/authentication/domain/user_model.dart';
import 'package:rossoneri_store/src/features/products/domain/product_model.dart';
import 'package:rossoneri_store/src/untils/in_memory_store.dart';

abstract class iAuthRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Stream<String?> authStateChanges();
  Future<void> editFullName(String fullName);
  Future<void> editPhoneNumber(String phoneNumber);
  Future<void> editAddress(String address);
}

// class FakeAuthRepository implements iAuthRepository {
//   final _authState = InMemoryStore<User?>(ktestUser);

//   @override
//   User get currentUser => _authState.value!;

//   @override
//   Future<User?> signInWithEmailAndPassword(
//       String email, String password) async {
//     await Future.delayed(const Duration(seconds: 1));
//     final user = ktestUser;
//     _authState.value = user;
//     return user;
//   }

//   @override
//   Stream<User?> authStateChanges() {
//     return _authState.stream;
//   }

//   void dispose() {
//     _authState.close();
//   }

//   @override
//   Future createUserWithEmailAndPassword(String email, String password) {
//     // TODO: implement createUserWithEmailAndPassword
//     throw UnimplementedError();
//   }
// }

class AuthRepository implements iAuthRepository {
  final fire.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  String? uid;

  AuthRepository(this._firebaseAuth, this._firestore);

  //Login
  @override
  Future signInWithEmailAndPassword(String email, String password) async {
    print('cc jz');
    final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    if (result.user != null) {
      print('Login success');
      uid = result.user!.uid;
      MyApp.sharePre.setString('UID', uid!);
    }
  }

  //Register
  @override
  Future createUserWithEmailAndPassword(String email, String password) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (result.user != null) {
      uid = result.user!.uid;
    }
  }

  //save user data to firestore
  Future saveUserData(User user) async {
    final ref = _authRef(uid!);
    await ref.set(user);
    uid = null;
  }

  Stream<User?> watchUser() {
    if (!MyApp.sharePre.containsKey('UID')) {
      return Stream.value(null);
    }
    final ref = _authRef(MyApp.sharePre.getString('UID'));
    late User? user;
    return ref.snapshots().map((snapshot) {
      user = snapshot.data();
      return user;
    });
  }

  DocumentReference<User> _authRef(String? uid) =>
      _firestore.collection('users').doc(uid).withConverter(
            fromFirestore: (doc, _) => User.fromMap(doc.data()!),
            toFirestore: (User user, options) => user.toMap(),
          );

  Future signOut() async {
    await _firebaseAuth.signOut();
    MyApp.sharePre.remove('UID');
    // _authRef(uid!).delete();
  }

  @override
  Stream<String?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map((user) => user?.uid);
  }

  @override
  Future<void> editAddress(String address) async {
    final ref = _authRef(MyApp.sharePre.getString('UID'));
    await ref.update({'address': address});
  }

  @override
  Future<void> editFullName(String fullName) async {
    final ref = _authRef(MyApp.sharePre.getString('UID'));
    await ref.update({'fullName': fullName});
  }

  @override
  Future<void> editPhoneNumber(String phoneNumber) {
    final ref = _authRef(MyApp.sharePre.getString('UID'));
    return ref.update({'phoneNumber': phoneNumber});
  }
}

// final fakeAuthRepositoryProvider = Provider<iAuthRepository>((ref) {
//   final auth = FakeAuthRepository();
//   ref.onDispose(() {
//     auth.dispose();
//   });
//   return auth;
// });

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final auth =
      AuthRepository(fire.FirebaseAuth.instance, FirebaseFirestore.instance);
  //ref.onDispose(() => _a);
  return auth;
});

final authWatchProvider = StreamProvider<User?>(
    (ref) => ref.read(authRepositoryProvider).watchUser());

final authStateChangesProvider = StreamProvider<String?>(
    (ref) => ref.watch(authRepositoryProvider).authStateChanges());
