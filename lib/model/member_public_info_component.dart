/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_public_info_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/core/widgets/progress_indicator.dart';

import 'package:eliud_pkg_membership/model/member_public_info_component_bloc.dart';
import 'package:eliud_pkg_membership/model/member_public_info_component_event.dart';
import 'package:eliud_pkg_membership/model/member_public_info_model.dart';
import 'package:eliud_pkg_membership/model/member_public_info_repository.dart';
import 'package:eliud_pkg_membership/model/member_public_info_component_state.dart';

abstract class AbstractMemberPublicInfoComponent extends StatelessWidget {
  static String componentName = "memberPublicInfos";
  final String memberPublicInfoID;

  AbstractMemberPublicInfoComponent({this.memberPublicInfoID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MemberPublicInfoComponentBloc> (
          create: (context) => MemberPublicInfoComponentBloc(
            memberPublicInfoRepository: getMemberPublicInfoRepository(context))
        ..add(FetchMemberPublicInfoComponent(id: memberPublicInfoID)),
      child: _memberPublicInfoBlockBuilder(context),
    );
  }

  Widget _memberPublicInfoBlockBuilder(BuildContext context) {
    return BlocBuilder<MemberPublicInfoComponentBloc, MemberPublicInfoComponentState>(builder: (context, state) {
      if (state is MemberPublicInfoComponentLoaded) {
        if (state.value == null) {
          return alertWidget(title: 'Error', content: 'No MemberPublicInfo defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is MemberPublicInfoComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is MemberPublicInfoComponentError) {
        return alertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: DelayedCircularProgressIndicator(),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, MemberPublicInfoModel value);
  Widget alertWidget({ title: String, content: String});
  MemberPublicInfoRepository getMemberPublicInfoRepository(BuildContext context);
}

