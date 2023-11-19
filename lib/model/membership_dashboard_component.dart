/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_membership/model/membership_dashboard_component_bloc.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component_event.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core_model/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core_model/model/app_model.dart';

/*
 * AbstractMembershipDashboardComponent is the base class to extend / implement in case you need to implement a component
 */
abstract class AbstractMembershipDashboardComponent extends StatelessWidget {
  static String componentName = "membershipDashboards";
  final AppModel app;
  final String membershipDashboardId;

  /*
   * Construct AbstractMembershipDashboardComponent
   */
  AbstractMembershipDashboardComponent(
      {super.key, required this.app, required this.membershipDashboardId});

  /*
   * build the component
   */
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MembershipDashboardComponentBloc>(
      create: (context) => MembershipDashboardComponentBloc(
          membershipDashboardRepository:
              membershipDashboardRepository(appId: app.documentID)!)
        ..add(FetchMembershipDashboardComponent(id: membershipDashboardId)),
      child: _membershipDashboardBlockBuilder(context),
    );
  }

  Widget _membershipDashboardBlockBuilder(BuildContext context) {
    return BlocBuilder<MembershipDashboardComponentBloc,
        MembershipDashboardComponentState>(builder: (context, state) {
      if (state is MembershipDashboardComponentLoaded) {
        return yourWidget(context, state.value);
      } else if (state is MembershipDashboardComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is MembershipDashboardComponentError) {
        return AlertWidget(app: app, title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry()
              .styleWithApp(app)
              .frontEndStyle()
              .progressIndicatorStyle()
              .progressIndicator(app, context),
        );
      }
    });
  }

  /*
   * Implement this method to provide your widget
   */
  Widget yourWidget(BuildContext context, MembershipDashboardModel value);
}
