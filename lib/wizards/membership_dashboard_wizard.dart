import 'package:eliud_core_main/apis/action_api/actions/goto_page.dart';
import 'package:eliud_core_main/apis/wizard_api/action_specification.dart';
import 'package:eliud_core_main/apis/wizard_api/action_specification_widget.dart';
import 'package:eliud_core_main/wizards/tools/document_identifier.dart';
import 'package:eliud_core_main/apis/wizard_api/new_app_wizard_info.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/icon_model.dart';
import 'package:eliud_core_main/model/member_model.dart';
import 'package:eliud_core_main/model/menu_item_model.dart';
import 'package:eliud_core_main/model/public_medium_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_text.dart';
import 'package:eliud_core_main/apis/action_api/action_model.dart';
import 'package:eliud_core_helpers/etc/random.dart';
import 'package:eliud_pkg_membership/wizards/builders/membership_dashboard_page_builder.dart';
import 'package:flutter/material.dart';

class MembershipDashboardWizard extends NewAppWizardInfo {
  static String membershipPageId = 'membership';
  static String membershipDashboardComponentIdentifier = 'membership';

  MembershipDashboardWizard()
      : super(
          'membershipdashboard',
          'Membership Dashboard',
        );

  @override
  String getPackageName() => "eliud_pkg_membership";

  @override
  NewAppWizardParameters newAppWizardParameters() {
    return MembershipDashboardWizardParameters();
  }

  List<MenuItemModel>? getThoseMenuItems(String uniqueId, AppModel app) => [
        MenuItemModel(
            documentID: newRandomKey(),
            text: 'Members',
            description: 'Members',
            icon: IconModel(
                codePoint: Icons.people.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: GotoPage(app,
                pageID: constructDocumentId(
                    uniqueId: uniqueId, documentId: membershipPageId)))
      ];

  @override
  List<NewAppTask>? getCreateTasks(
    String uniqueId,
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
        var memberId = member.documentID;
        List<NewAppTask> tasks = [];
        tasks.add(() async => await MembershipDashboardPageBuilder(
              uniqueId,
              membershipPageId,
              app,
              memberId,
              homeMenuProvider(),
              appBarProvider(),
              leftDrawerProvider(),
              rightDrawerProvider(),
            ).run(componentIdentifier: membershipDashboardComponentIdentifier));
        return tasks;
      }
    } else {
      throw Exception('Unexpected class for parameters: $parameters');
    }
    return null;
  }

  @override
  List<MenuItemModel>? getMenuItemsFor(String uniqueId, AppModel app,
      NewAppWizardParameters parameters, MenuType type) {
    if (parameters is MembershipDashboardWizardParameters) {
      if (parameters.membershipDashboardSpecifications.should(type)) {
        return getThoseMenuItems(
          uniqueId,
          app,
        );
      }
    } else {
      throw Exception('Unexpected class for parameters: $parameters');
    }
    return null;
  }

  @override
  String? getPageID(String uniqueId, NewAppWizardParameters parameters,
          String pageType) =>
      null;

  @override
  ActionModel? getAction(
    String uniqueId,
    NewAppWizardParameters parameters,
    AppModel app,
    String actionType,
  ) =>
      null;

  @override
  AppModel updateApp(String uniqueId, NewAppWizardParameters parameters,
          AppModel adjustMe) =>
      adjustMe;

  @override
  Widget wizardParametersWidget(
      AppModel app, BuildContext context, NewAppWizardParameters parameters) {
    if (parameters is MembershipDashboardWizardParameters) {
      return ActionSpecificationWidget(
          app: app,
          actionSpecification: parameters.membershipDashboardSpecifications,
          label: 'Generate a default Membership Dashboard Dialog');
    } else {
      return text(app, context, 'Unexpected class for parameters: $parameters');
    }
  }

  @override
  PublicMediumModel? getPublicMediumModel(String uniqueId,
          NewAppWizardParameters parameters, String mediumType) =>
      null;
}

class MembershipDashboardWizardParameters extends NewAppWizardParameters {
  late ActionSpecification membershipDashboardSpecifications;

  MembershipDashboardWizardParameters() {
    membershipDashboardSpecifications = ActionSpecification(
      requiresAccessToLocalFileSystem: false,
      availableInLeftDrawer: false,
      availableInRightDrawer: true,
      availableInAppBar: false,
      availableInHomeMenu: false,
      available: false,
    );
  }
}
