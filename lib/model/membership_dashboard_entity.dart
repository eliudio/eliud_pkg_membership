/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'package:eliud_core/tools/common_tools.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';

class MembershipDashboardEntity {
  final String appId;
  final String description;

  MembershipDashboardEntity({this.appId, this.description, });


  List<Object> get props => [appId, description, ];

  @override
  String toString() {
    return 'MembershipDashboardEntity{appId: $appId, description: $description}';
  }

  static MembershipDashboardEntity fromMap(Map map) {
    if (map == null) return null;

    return MembershipDashboardEntity(
      appId: map['appId'], 
      description: map['description'], 
    );
  }

  Map<String, Object> toDocument() {
    Map<String, Object> theDocument = HashMap();
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (description != null) theDocument["description"] = description;
      else theDocument["description"] = null;
    return theDocument;
  }

  static MembershipDashboardEntity fromJsonString(String json) {
    Map<String, dynamic> generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

