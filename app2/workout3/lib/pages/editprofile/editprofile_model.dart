import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'editprofile_widget.dart' show EditprofileWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditprofileModel extends FlutterFlowModel<EditprofileWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for nameset widget.
  FocusNode? namesetFocusNode;
  TextEditingController? namesetController;
  String? Function(BuildContext, String?)? namesetControllerValidator;
  DateTime? datePicked;
  // State field(s) for genderDD widget.
  String? genderDDValue;
  FormFieldController<String>? genderDDValueController;
  // State field(s) for weightset widget.
  FocusNode? weightsetFocusNode;
  TextEditingController? weightsetController;
  String? Function(BuildContext, String?)? weightsetControllerValidator;
  // State field(s) for heightset widget.
  FocusNode? heightsetFocusNode;
  TextEditingController? heightsetController;
  String? Function(BuildContext, String?)? heightsetControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    namesetFocusNode?.dispose();
    namesetController?.dispose();

    weightsetFocusNode?.dispose();
    weightsetController?.dispose();

    heightsetFocusNode?.dispose();
    heightsetController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
