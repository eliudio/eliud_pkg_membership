/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/abstract_repository_singleton.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import '../model/membership_dashboard_repository.dart';
import 'package:eliud_core/core/access/bloc/user_repository.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_core/package/package.dart';

MembershipDashboardRepository? membershipDashboardRepository({ String? appId }) => AbstractRepositorySingleton.singleton.membershipDashboardRepository(appId);

abstract class AbstractRepositorySingleton {
  static List<MemberCollectionInfo> collections = [
  ];
  static late AbstractRepositorySingleton singleton;

  MembershipDashboardRepository? membershipDashboardRepository(String? appId);

  void flush(String? appId) {
  }
}
