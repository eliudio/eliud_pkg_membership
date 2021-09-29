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
import 'package:eliud_core/tools/component/component_spec.dart';

import '../extensions/membership_dashboard_component.dart';
import '../editors/membership_dashboard_component_editor.dart';
import 'membership_dashboard_component_selector.dart';
import 'package:eliud_pkg_membership/model/internal_component.dart';




class ComponentRegistry {

  void init() {
    Registry.registry()!.addInternalComponents('eliud_pkg_membership', ["membershipDashboards", ]);

    Registry.registry()!.register(componentName: "eliud_pkg_membership_internalWidgets", componentConstructor: ListComponentFactory());
    Registry.registry()!.addDropDownSupporter("membershipDashboards", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "membershipDashboards", componentConstructor: MembershipDashboardComponentConstructorDefault());
    Registry.registry()!.addComponentSpec('eliud_pkg_membership', [
      ComponentSpec('membershipDashboards', MembershipDashboardComponentConstructorDefault(), MembershipDashboardComponentSelector(), MembershipDashboardComponentEditorConstructor(), ), 
    ]);

  }
}


