/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/repository_singleton.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'dart:collection';
import '../model/membership_dashboard_firestore.dart';
import '../model/membership_dashboard_repository.dart';
import '../model/membership_dashboard_cache.dart';


class RepositorySingleton extends AbstractRepositorySingleton {
    var _membershipDashboardRepository = HashMap<String, MembershipDashboardRepository>();

    MembershipDashboardRepository membershipDashboardRepository(String appId) {
      if (_membershipDashboardRepository[appId] == null) _membershipDashboardRepository[appId] = MembershipDashboardCache(MembershipDashboardFirestore(appRepository().getSubCollection(appId, 'membershipdashboard'), appId));
      return _membershipDashboardRepository[appId];
    }

}
