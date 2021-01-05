/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_public_info_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:collection/collection.dart';
import 'package:eliud_core/core/global_data.dart';
import 'package:eliud_core/tools/common_tools.dart';

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


import 'package:eliud_pkg_membership/model/member_public_info_entity.dart';

import 'package:eliud_core/tools/random.dart';



class MemberPublicInfoModel {

  // User UUID
  String documentID;
  String name;
  String photoURL;
  List<MemberSubscriptionModel> subscriptions;

  MemberPublicInfoModel({this.documentID, this.name, this.photoURL, this.subscriptions, })  {
    assert(documentID != null);
  }

  MemberPublicInfoModel copyWith({String documentID, String name, String photoURL, List<MemberSubscriptionModel> subscriptions, }) {
    return MemberPublicInfoModel(documentID: documentID ?? this.documentID, name: name ?? this.name, photoURL: photoURL ?? this.photoURL, subscriptions: subscriptions ?? this.subscriptions, );
  }

  @override
  int get hashCode => documentID.hashCode ^ name.hashCode ^ photoURL.hashCode ^ subscriptions.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is MemberPublicInfoModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          name == other.name &&
          photoURL == other.photoURL &&
          ListEquality().equals(subscriptions, other.subscriptions);

  @override
  String toString() {
    String subscriptionsCsv = (subscriptions == null) ? '' : subscriptions.join(', ');

    return 'MemberPublicInfoModel{documentID: $documentID, name: $name, photoURL: $photoURL, subscriptions: MemberSubscription[] { $subscriptionsCsv }}';
  }

  MemberPublicInfoEntity toEntity({String appId}) {
    return MemberPublicInfoEntity(
          name: (name != null) ? name : null, 
          photoURL: (photoURL != null) ? photoURL : null, 
          subscriptions: (subscriptions != null) ? subscriptions
            .map((item) => item.toEntity(appId: appId))
            .toList() : null, 
    );
  }

  static MemberPublicInfoModel fromEntity(String documentID, MemberPublicInfoEntity entity) {
    if (entity == null) return null;
    return MemberPublicInfoModel(
          documentID: documentID, 
          name: entity.name, 
          photoURL: entity.photoURL, 
          subscriptions: 
            entity.subscriptions == null ? null :
            entity.subscriptions
            .map((item) => MemberSubscriptionModel.fromEntity(newRandomKey(), item))
            .toList(), 
    );
  }

  static Future<MemberPublicInfoModel> fromEntityPlus(String documentID, MemberPublicInfoEntity entity, { String appId}) async {
    if (entity == null) return null;

    return MemberPublicInfoModel(
          documentID: documentID, 
          name: entity.name, 
          photoURL: entity.photoURL, 
          subscriptions: 
            entity. subscriptions == null ? null : new List<MemberSubscriptionModel>.from(await Future.wait(entity. subscriptions
            .map((item) => MemberSubscriptionModel.fromEntityPlus(newRandomKey(), item, appId: appId))
            .toList())), 
    );
  }

}

