/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'membership_dashboard_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MembershipDashboardFormState extends Equatable {
  const MembershipDashboardFormState();

  @override
  List<Object> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class MembershipDashboardFormUninitialized extends MembershipDashboardFormState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '''MembershipDashboardFormState()''';
  }
}

// MembershipDashboardModel has been initialised and hence MembershipDashboardModel is available
class MembershipDashboardFormInitialized extends MembershipDashboardFormState {
  final MembershipDashboardModel value;

  @override
  List<Object> get props => [ value ];

  const MembershipDashboardFormInitialized({ this.value });
}

// Menu has been initialised and hence a menu is available
abstract class MembershipDashboardFormError extends MembershipDashboardFormInitialized {
  final String message;

  @override
  List<Object> get props => [ message, value ];

  const MembershipDashboardFormError({this.message, MembershipDashboardModel value }) : super(value: value);

  @override
  String toString() {
    return '''MembershipDashboardFormError {
      value: $value,
      message: $message,
    }''';
  }
}
class DocumentIDMembershipDashboardFormError extends MembershipDashboardFormError { 
  const DocumentIDMembershipDashboardFormError({ String message, MembershipDashboardModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''DocumentIDMembershipDashboardFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AppIdMembershipDashboardFormError extends MembershipDashboardFormError { 
  const AppIdMembershipDashboardFormError({ String message, MembershipDashboardModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''AppIdMembershipDashboardFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class DescriptionMembershipDashboardFormError extends MembershipDashboardFormError { 
  const DescriptionMembershipDashboardFormError({ String message, MembershipDashboardModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''DescriptionMembershipDashboardFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ConditionsMembershipDashboardFormError extends MembershipDashboardFormError { 
  const ConditionsMembershipDashboardFormError({ String message, MembershipDashboardModel value }): super(message: message, value: value);

  @override
  List<Object> get props => [ message, value ];

  @override
  String toString() {
    return '''ConditionsMembershipDashboardFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class MembershipDashboardFormLoaded extends MembershipDashboardFormInitialized { 
  const MembershipDashboardFormLoaded({ MembershipDashboardModel value }): super(value: value);

  @override
  List<Object> get props => [ value ];

  @override
  String toString() {
    return '''MembershipDashboardFormLoaded {
      value: $value,
    }''';
  }
}


class SubmittableMembershipDashboardForm extends MembershipDashboardFormInitialized { 
  const SubmittableMembershipDashboardForm({ MembershipDashboardModel value }): super(value: value);

  @override
  List<Object> get props => [ value ];

  @override
  String toString() {
    return '''SubmittableMembershipDashboardForm {
      value: $value,
    }''';
  }
}


