import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_create/registry/registry.dart';
import 'package:eliud_pkg_create/widgets/new_app_bloc/action_specification.dart';
import 'package:eliud_pkg_create/widgets/new_app_bloc/builders/app_builder.dart';
import 'package:eliud_pkg_create/widgets/new_app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'builders/dialog/membership_dashboard_dialog_builder.dart';

class MembershipDashboardWizard extends NewAppWizardInfo {
  static String MEMBERSHIP_DASHBOARD_DIALOG_ID = 'membership_dashboard';

  MembershipDashboardWizard() : super('membership', 'Membership');

  @override
  NewAppWizardParameters newAppWizardParameters() {
    return MembershipDashboardWizardParameters();
  }

  @override
  MenuItemModel? getMenuItemFor(
      AppModel app, NewAppWizardParameters parameters, MenuType type) {
    if (parameters is MembershipDashboardWizardParameters) {
      var examplePolicySpecifications =
          parameters.membershipDashboardSpecifications;
      bool generate = (type == MenuType.leftDrawerMenu) &&
              examplePolicySpecifications.availableInLeftDrawer ||
          (type == MenuType.rightDrawerMenu) &&
              examplePolicySpecifications.availableInRightDrawer ||
          (type == MenuType.bottomNavBarMenu) &&
              examplePolicySpecifications.availableInHomeMenu ||
          (type == MenuType.appBarMenu) &&
              examplePolicySpecifications.availableInAppBar;
      if (generate) {
        return MenuItemModel(
            documentID: newRandomKey(),
            text: 'Members',
            description: 'Members',
            icon: IconModel(
                codePoint: Icons.people.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: OpenDialog(app, dialogID: MEMBERSHIP_DASHBOARD_DIALOG_ID));
      }
    } else {
      throw Exception(
          'Unexpected class for parameters: ' + parameters.toString());
    }
    return null;
  }

  @override
  Widget wizardParametersWidget(
      AppModel app, BuildContext context, NewAppWizardParameters parameters) {
    if (parameters is MembershipDashboardWizardParameters) {
      return ActionSpecificationWidget(
          app: app,
          enabled: true,
          actionSpecification: parameters.membershipDashboardSpecifications,
          label: 'Generate membership dashboard dialog');
    } else {
      return text(app, context,
          'Unexpected class for parameters: ' + parameters.toString());
    }
  }

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

  @override
  AppModel updateApp(
    NewAppWizardParameters parameters,
    AppModel adjustMe,
  ) =>
      adjustMe;

  @override
  String? getPageID(String pageType) => null;
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
