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


import 'package:eliud_pkg_membership/model/membership_dashboard_entity.dart';

import 'package:eliud_core/tools/random.dart';



class MembershipDashboardModel {
  String documentID;

  // This is the identifier of the app to which this feed belongs
  String appId;
  String description;

  MembershipDashboardModel({this.documentID, this.appId, this.description, })  {
    assert(documentID != null);
  }

  MembershipDashboardModel copyWith({String documentID, String appId, String description, }) {
    return MembershipDashboardModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, description: description ?? this.description, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ description.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is MembershipDashboardModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          description == other.description;

  @override
  String toString() {
    return 'MembershipDashboardModel{documentID: $documentID, appId: $appId, description: $description}';
  }

  MembershipDashboardEntity toEntity({String appId}) {
    return MembershipDashboardEntity(
          appId: (appId != null) ? appId : null, 
          description: (description != null) ? description : null, 
    );
  }

  static MembershipDashboardModel fromEntity(String documentID, MembershipDashboardEntity entity) {
    if (entity == null) return null;
    return MembershipDashboardModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
    );
  }

  static Future<MembershipDashboardModel> fromEntityPlus(String documentID, MembershipDashboardEntity entity, { String appId}) async {
    if (entity == null) return null;

    return MembershipDashboardModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
    );
  }

}

