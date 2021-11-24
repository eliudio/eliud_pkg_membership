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
import 'package:eliud_pkg_membership/model/membership_dashboard_repository.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';

abstract class AbstractMembershipDashboardComponent extends StatelessWidget {
  static String componentName = "membershipDashboards";
  final String theAppId;
  final String membershipDashboardId;

  AbstractMembershipDashboardComponent({Key? key, required this.theAppId, required this.membershipDashboardId}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MembershipDashboardComponentBloc> (
          create: (context) => MembershipDashboardComponentBloc(
            membershipDashboardRepository: membershipDashboardRepository(appId: theAppId)!)
        ..add(FetchMembershipDashboardComponent(id: membershipDashboardId)),
      child: _membershipDashboardBlockBuilder(context),
    );
  }

  Widget _membershipDashboardBlockBuilder(BuildContext context) {
    return BlocBuilder<MembershipDashboardComponentBloc, MembershipDashboardComponentState>(builder: (context, state) {
      if (state is MembershipDashboardComponentLoaded) {
        if (state.value == null) {
          return AlertWidget(title: "Error", content: 'No MembershipDashboard defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is MembershipDashboardComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is MembershipDashboardComponentError) {
        return AlertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, MembershipDashboardModel value);
}

