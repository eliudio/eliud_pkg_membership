/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_firestore.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_membership/model/membership_dashboard_repository.dart';


import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_membership/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';


import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';

class MembershipDashboardFirestore implements MembershipDashboardRepository {
  Future<MembershipDashboardModel> add(MembershipDashboardModel value) {
    return MembershipDashboardCollection.doc(value.documentID).set(value.toEntity(appId: appId).toDocument()).then((_) => value);
  }

  Future<void> delete(MembershipDashboardModel value) {
    return MembershipDashboardCollection.doc(value.documentID).delete();
  }

  Future<MembershipDashboardModel> update(MembershipDashboardModel value) {
    return MembershipDashboardCollection.doc(value.documentID).update(value.toEntity(appId: appId).toDocument()).then((_) => value);
  }

  MembershipDashboardModel? _populateDoc(DocumentSnapshot value) {
    return MembershipDashboardModel.fromEntity(value.id, MembershipDashboardEntity.fromMap(value.data()));
  }

  Future<MembershipDashboardModel?> _populateDocPlus(DocumentSnapshot value) async {
    return MembershipDashboardModel.fromEntityPlus(value.id, MembershipDashboardEntity.fromMap(value.data()), appId: appId);  }

  Future<MembershipDashboardModel?> get(String? id, {Function(Exception)? onError}) {
    return MembershipDashboardCollection.doc(id).get().then((doc) async {
      if (doc.data() != null)
        return await _populateDocPlus(doc);
      else
        return null;
    }).catchError((Object e) {
      if (onError != null) {
        onError(e as Exception);
      }
    });
  }

  StreamSubscription<List<MembershipDashboardModel?>> listen(MembershipDashboardModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery}) {
    Stream<List<MembershipDashboardModel?>> stream;
//    stream = getQuery(MembershipDashboardCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots().map((data) {
//    The above line is replaced by the below line. The reason is because the same collection can not be subscribed to twice
//    The reason we're subscribing twice to the same list, is because the close on bloc isn't called. This needs to be fixed.
//    See https://github.com/felangel/bloc/issues/2073.
//    In the meantime:
      stream = getQuery(appRepository()!.getSubCollection(appId, 'membershipdashboard'), orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots().map((data) {
      Iterable<MembershipDashboardModel?> membershipDashboards  = data.docs.map((doc) {
        MembershipDashboardModel? value = _populateDoc(doc);
        return value;
      }).toList();
      return membershipDashboards as List<MembershipDashboardModel?>;
    });
    return stream.listen((listOfMembershipDashboardModels) {
      trigger(listOfMembershipDashboardModels);
    });
  }

  StreamSubscription<List<MembershipDashboardModel?>> listenWithDetails(MembershipDashboardModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery}) {
    Stream<List<MembershipDashboardModel?>> stream;
//  stream = getQuery(MembershipDashboardCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId).snapshots()
//  see comment listen(...) above
    stream = getQuery(appRepository()!.getSubCollection(appId, 'membershipdashboard'), orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
        .asyncMap((data) async {
      return await Future.wait(data.docs.map((doc) =>  _populateDocPlus(doc)).toList());
    });

    return stream.listen((listOfMembershipDashboardModels) {
      trigger(listOfMembershipDashboardModels);
    });
  }

  @override
  StreamSubscription<MembershipDashboardModel?> listenTo(String documentId, MembershipDashboardChanged changed) {
    var stream = MembershipDashboardCollection.doc(documentId)
        .snapshots()
        .asyncMap((data) {
      return _populateDocPlus(data);
    });
    return stream.listen((value) {
      changed(value);
    });
  }

  Stream<List<MembershipDashboardModel?>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
    DocumentSnapshot? lastDoc;
    Stream<List<MembershipDashboardModel?>> _values = getQuery(MembershipDashboardCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?, limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        lastDoc = doc;
        return _populateDoc(doc);
      }).toList();});
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  Stream<List<MembershipDashboardModel?>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
    DocumentSnapshot? lastDoc;
    Stream<List<MembershipDashboardModel?>> _values = getQuery(MembershipDashboardCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?, limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots().asyncMap((snapshot) {
      return Future.wait(snapshot.docs.map((doc) {
        lastDoc = doc;
        return _populateDocPlus(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  Future<List<MembershipDashboardModel?>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) async {
    DocumentSnapshot? lastDoc;
    List<MembershipDashboardModel?> _values = await getQuery(MembershipDashboardCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.get().then((value) {
      var list = value.docs;
      return list.map((doc) { 
        lastDoc = doc;
        return _populateDoc(doc);
      }).toList();
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  Future<List<MembershipDashboardModel?>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) async {
    DocumentSnapshot? lastDoc;
    List<MembershipDashboardModel?> _values = await getQuery(MembershipDashboardCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.get().then((value) {
      var list = value.docs;
      return Future.wait(list.map((doc) {
        lastDoc = doc;
        return _populateDocPlus(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  void flush() {}

  Future<void> deleteAll() {
    return MembershipDashboardCollection.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    });
  }

  dynamic getSubCollection(String documentId, String name) {
    return MembershipDashboardCollection.doc(documentId).collection(name);
  }

  String? timeStampToString(dynamic timeStamp) {
    return firestoreTimeStampToString(timeStamp);
  } 

  Future<MembershipDashboardModel?> changeValue(String documentId, String fieldName, num changeByThisValue) {
    var change = FieldValue.increment(changeByThisValue);
    return MembershipDashboardCollection.doc(documentId).update({fieldName: change}).then((v) => get(documentId));
  }


  final String appId;
  MembershipDashboardFirestore(this.MembershipDashboardCollection, this.appId);

  final CollectionReference MembershipDashboardCollection;
}

