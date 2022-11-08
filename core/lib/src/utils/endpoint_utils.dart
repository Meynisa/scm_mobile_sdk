import '../../core.dart';

class Endpoint {
  static final String baseUrl = FlavorConfig.instance!.values.baseUrl;
  static final String baseUrlDev = 'https://api-sm.s45.in';
  static final String baseUrlStage = 'https://api-sm.s45.in';
  static final String baseUrlProd = 'https://api.sociomile.net';

  static final String socketUrl = FlavorConfig.instance!.values.socketUrl;
  static final String socketUrlDev = 'https://push-sm.s45.in';
  static final String socketUrlStage = 'https://push-sm.s45.in';
  static final String socketUrlProd = 'https://push.sociomile.net';

  static final String baseUrlSociomileSetting = 'http://bebas-sm.s45.in:8003';

  static final String login = '/auth/login';
  static final String logout = '/logout';

  ///CHAT
  static final tickets = '/tickets';
  static final streams = '/streams';
  static final replyChat = '/reply';
  static final editProfile = '/tickets/editable';
  static final unlockTickets = '/tickets/unlock';
  static final meSettings = '/me';

  ///CATEGORIES
  // static final String allCategories = '/multi-category';
  static final String multiCategories = '/multi-category/get-children';
  static final String createTicketCategories = '/tickets/multi-category';
  static final String tagListAutoComplete = '/activity-codes/auto-complete';
  static final String createTag = '/tickets/activity-codes';
  static final String changeStatus = '/tickets/change-status';
  static final String templateMessage = '/template/response';
  static final String statusAgent = '/agent/status';

  ///USER_PROFILE
  static final String customFieldUpdate = '/tickets/custom-field-update';
  static final String customContactFieldUpdate =
      '/contacts/custom-field-update';
}
