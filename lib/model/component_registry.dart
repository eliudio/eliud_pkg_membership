/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/component_registry.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import '../model/internal_component.dart';
import 'package:eliud_core/core/registry.dart';
import 'package:eliud_core_model/tools/component/component_spec.dart';
import 'abstract_repository_singleton.dart';

import '../extensions/membership_dashboard_component.dart';
import '../editors/membership_dashboard_component_editor.dart';
import 'membership_dashboard_component_selector.dart';

/* 
 * Component registry contains a list of components
 */
class ComponentRegistry {
  /* 
   * Initialise the component registry
   */
  void init() {
    Apis.apis().addInternalComponents('eliud_pkg_membership', [
      "membershipDashboards",
    ]);

    Apis.apis().register(
        componentName: "eliud_pkg_membership_internalWidgets",
        componentConstructor: ListComponentFactory());
    Apis.apis().addDropDownSupporter(
        "membershipDashboards", DropdownButtonComponentFactory());
    Apis.apis().register(
        componentName: "membershipDashboards",
        componentConstructor: MembershipDashboardComponentConstructorDefault());
    Apis.apis()
        .addComponentSpec('eliud_pkg_membership', 'membership', [
      ComponentSpec(
          'membershipDashboards',
          MembershipDashboardComponentConstructorDefault(),
          MembershipDashboardComponentSelector(),
          MembershipDashboardComponentEditorConstructor(),
          ({String? appId}) => membershipDashboardRepository(appId: appId)!),
    ]);
    Apis.apis().registerRetrieveRepository(
        'eliud_pkg_membership',
        'membershipDashboards',
        ({String? appId}) => membershipDashboardRepository(appId: appId)!);
  }
}
