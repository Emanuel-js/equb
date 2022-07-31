class ApiEndPoints {
  static const login = "auth/login";
  static const getAllUsers = "auth/getAllUsers";

  static const adminAddSales = "admin/addSales";
  static const updateMainCollector = "admin/update/personalInfo";
  static const analytics = "admin/adminGetAnalyticsMetrics";

  static const addNewAgent = "sales/addMyAgent";
  static const addClient = "agent/addClient";
  static const searchUser = "agent/searchClientByPhoneNumberOrEmail?";

  static const getUserWalletAccount = "wallet/user";

  static const transferMoney = "transaction/transferBalance";
  static const transferWalletToSales = "transaction/addBalance";
  static const transactionHistory = "transaction/user";
  static const savingAccount = "wallet/accumlatedBalance";

  // static const subCollectorRegister = "mainCollector/addMySubCollector";
  // static const updateSubCollector = "mainCollector/update/personalInfo";

  // static const clientRegister = "subCollector/addClient";

  static const createDropTickets = "lotto/createDropTickets";
  static const dropTicketForClient = "lotto/createDropTicketsForClient";
  static const getCreatedTickets = "lotto/GetAllMyTickets/";

  static const getMyUsers = "common/getAllMyUsers";

  static const requestRefund = "refund/requestRefund";
  static const getReqRefund = "refund/getAllRefundRequests";
  // static const requestApprove = "refund/approveRefundRequest";
  // static const searchUser =
  // "subCollector/searchClientByUserNameOrPhoneNumberOrEmail";
}
