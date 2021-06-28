/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

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


import 'package:eliud_pkg_membership/model/membership_dashboard_entity.dart';

import 'package:eliud_core/tools/random.dart';



class MembershipDashboardModel {
  String? documentID;

  // This is the identifier of the app to which this feed belongs
  String? appId;
  String? description;
  ConditionsSimpleModel? conditions;

  MembershipDashboardModel({this.documentID, this.appId, this.description, this.conditions, })  {
    assert(documentID != null);
  }

  MembershipDashboardModel copyWith({String? documentID, String? appId, String? description, ConditionsSimpleModel? conditions, }) {
    return MembershipDashboardModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, description: description ?? this.description, conditions: conditions ?? this.conditions, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ description.hashCode ^ conditions.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is MembershipDashboardModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          description == other.description &&
          conditions == other.conditions;

  @override
  String toString() {
    return 'MembershipDashboardModel{documentID: $documentID, appId: $appId, description: $description, conditions: $conditions}';
  }

  MembershipDashboardEntity toEntity({String? appId}) {
    return MembershipDashboardEntity(
          appId: (appId != null) ? appId : null, 
          description: (description != null) ? description : null, 
          conditions: (conditions != null) ? conditions!.toEntity(appId: appId) : null, 
    );
  }

  static MembershipDashboardModel? fromEntity(String documentID, MembershipDashboardEntity? entity) {
    if (entity == null) return null;
    var counter = 0;
    return MembershipDashboardModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
          conditions: 
            ConditionsSimpleModel.fromEntity(entity.conditions), 
    );
  }

  static Future<MembershipDashboardModel?> fromEntityPlus(String documentID, MembershipDashboardEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return MembershipDashboardModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
          conditions: 
            await ConditionsSimpleModel.fromEntityPlus(entity.conditions, appId: appId), 
    );
  }

}

