import 'package:core/core.dart';
import '../../../main_lib.dart';

class ProfileUserConverter {
  TextInputType convertKeyboardType(ProfileType type) {
    switch (type) {
      case ProfileType.select:
        return TextInputType.text;
      case ProfileType.text:
        return TextInputType.text;
      case ProfileType.textarea:
        return TextInputType.multiline;
      case ProfileType.number:
        return const TextInputType.numberWithOptions(
            signed: true, decimal: true);
      case ProfileType.email:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  ProfileType convertProfileType(String type) {
    switch (type) {
      case 'select':
        return ProfileType.select;
      case 'text':
        return ProfileType.text;
      case 'textarea':
        return ProfileType.textarea;
      case 'number':
        return ProfileType.number;
      case 'email':
        return ProfileType.email;
      default:
        return ProfileType.text;
    }
  }

  ProfileTag convertProfileTag(String tag) {
    switch (tag) {
      case 'select':
        return ProfileTag.select;
      case 'input':
        return ProfileTag.input;
      case 'textarea':
        return ProfileTag.textarea;
      default:
        return ProfileTag.input;
    }
  }
}
