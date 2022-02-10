import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_create/registry/action_specification.dart';
import 'package:eliud_pkg_create/registry/new_app_wizard_info_with_action_specification.dart';
import 'package:eliud_pkg_create/registry/registry.dart';
import 'package:eliud_pkg_create/widgets/new_app_bloc/builders/app_builder.dart';
import 'package:eliud_pkg_create/widgets/new_app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'builders/dialog/membership_dashboard_dialog_builder.dart';

class MembershipDashboardWizard extends NewAppWizardInfoWithActionSpecification {
  static String MEMBERSHIP_DASHBOARD_DIALOG_ID = 'membership_dashboard';

  MembershipDashboardWizard() : super('membership', 'Membership', 'Generate membership dashboard dialog');

  @override
  NewAppWizardParameters newAppWizardParameters() {
    return MembershipDashboardWizardParameters();
  }

  MenuItemModel getThatMenuItem(AppModel app) =>  MenuItemModel(
            documentID: newRandomKey(),
            text: 'Members',
            description: 'Members',
            icon: IconModel(
                codePoint: Icons.people.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: OpenDialog(app, dialogID: MEMBERSHIP_DASHBOARD_DIALOG_ID));

  @override
  List<NewAppTask>? getCreateTasks(
    AppModel app,
    NewAppWizardParameters parameters,
    MemberModel member,
    HomeMenuProvider homeMenuProvider,
    AppBarProvider appBarProvider,
    DrawerProvider leftDrawerProvider,
    DrawerProvider rightDrawerProvider,
      ) {
    if (parameters is MembershipDashboardWizardParameters) {
      var membershipDashboardSpecifications =
          parameters.membershipDashboardSpecifications;
      if (membershipDashboardSpecifications
          .shouldCreatePageDialogOrWorkflow()) {
        print("Membership Dashboard");
        List<NewAppTask> tasks = [];
        tasks.add(() async => await MembershipDashboardDialogBuilder(
                app, MEMBERSHIP_DASHBOARD_DIALOG_ID,
                profilePageId: NewAppWizardRegistry.registry().getPageID("profilePageId"),
                feedPageId: NewAppWizardRegistry.registry().getPageID("pageIdProvider"),)
            .create());
        return tasks;
      }
    } else {
      throw Exception(
          'Unexpected class for parameters: ' + parameters.toString());
    }
  }
}

class MembershipDashboardWizardParameters extends NewAppWizardParameters {
  late ActionSpecification membershipDashboardSpecifications;

  MembershipDashboardWizardParameters() {
    membershipDashboardSpecifications = JoinActionSpecifications(
      requiresAccessToLocalFileSystem: false,
      paymentType: JoinPaymentType.Manual,
      availableInLeftDrawer: false,
      availableInRightDrawer: false,
      availableInAppBar: true,
      availableInHomeMenu: false,
      available: false,
    );
  }
}
