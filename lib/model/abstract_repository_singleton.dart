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
import '../model/member_public_info_repository.dart';
import 'package:eliud_core/core/access/bloc/user_repository.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';

MembershipDashboardRepository membershipDashboardRepository({ String appId }) => AbstractRepositorySingleton.singleton.membershipDashboardRepository(appId);
MemberPublicInfoRepository memberPublicInfoRepository({ String appId }) => AbstractRepositorySingleton.singleton.memberPublicInfoRepository();

abstract class AbstractRepositorySingleton {
  static AbstractRepositorySingleton singleton;

  MembershipDashboardRepository membershipDashboardRepository(String appId);
  MemberPublicInfoRepository memberPublicInfoRepository();

  void flush(String appId) {
    memberPublicInfoRepository().flush();
  }
}
