import 'package:eliud_core/core/wizards/tools/documentIdentifier.dart';
import 'package:eliud_core/core/wizards/registry/action_specification.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/core/wizards/widgets/action_specification_widget.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/wizards/join_action_specification_parameters.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component.dart';
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
                pageID: constructDocumentId(uniqueId: uniqueId, documentId: membershipPageId)))
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
    PageProvider pageProvider,
  ) {
    if (parameters is MembershipDashboardWizardParameters) {
      var membershipDashboardSpecifications =
          parameters.membershipDashboardSpecifications;
      if (membershipDashboardSpecifications
          .shouldCreatePageDialogOrWorkflow()) {
        print("Membership Dashboard");
        var memberId = member.documentID!;
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
          pageProvider,
            ).run(componentIdentifier: membershipDashboardComponentIdentifier));
        return tasks;
      }
    } else {
      throw Exception(
          'Unexpected class for parameters: ' + parameters.toString());
    }
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
      throw Exception(
          'Unexpected class for parameters: ' + parameters.toString());
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
      return text(app, context,
          'Unexpected class for parameters: ' + parameters.toString());
    }
  }

  @override
  PublicMediumModel? getPublicMediumModel(String uniqueId, NewAppWizardParameters parameters, String pageType) => null;
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
