/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_repository.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_membership/model/model_export.dart';
import 'package:eliud_pkg_membership/model/entity_export.dart';

import 'dart:async';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/core/base/repository_base.dart';

typedef MembershipDashboardModelTrigger = Function(
    List<MembershipDashboardModel?> list);
typedef MembershipDashboardChanged = Function(MembershipDashboardModel? value);
typedef MembershipDashboardErrorHandler = Function(dynamic o, dynamic e);

abstract class MembershipDashboardRepository extends RepositoryBase<
    MembershipDashboardModel, MembershipDashboardEntity> {
  @override
  Future<MembershipDashboardEntity> addEntity(
      String documentID, MembershipDashboardEntity value);
  @override
  Future<MembershipDashboardEntity> updateEntity(
      String documentID, MembershipDashboardEntity value);
  @override
  Future<MembershipDashboardModel> add(MembershipDashboardModel value);
  @override
  Future<void> delete(MembershipDashboardModel value);
  @override
  Future<MembershipDashboardModel?> get(String? id,
      {Function(Exception)? onError});
  @override
  Future<MembershipDashboardModel> update(MembershipDashboardModel value);

  @override
  Stream<List<MembershipDashboardModel?>> values(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Stream<List<MembershipDashboardModel?>> valuesWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Future<List<MembershipDashboardModel?>> valuesList(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Future<List<MembershipDashboardModel?>> valuesListWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});

  @override
  StreamSubscription<List<MembershipDashboardModel?>> listen(
      MembershipDashboardModelTrigger trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  StreamSubscription<List<MembershipDashboardModel?>> listenWithDetails(
      MembershipDashboardModelTrigger trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  StreamSubscription<MembershipDashboardModel?> listenTo(
      String documentId, MembershipDashboardChanged changed,
      {MembershipDashboardErrorHandler? errorHandler});
  @override
  void flush();

  @override
  String? timeStampToString(dynamic timeStamp);

  @override
  dynamic getSubCollection(String documentId, String name);
  @override
  Future<MembershipDashboardModel?> changeValue(
      String documentId, String fieldName, num changeByThisValue);

  @override
  Future<void> deleteAll();
}
