class AccountInfo {
  final String email;
  final String subscriptionStatus;
  final String expirationDate;
  final int connectedDevices;
  final String inviteLink;

  const AccountInfo({
    required this.email,
    required this.subscriptionStatus,
    required this.expirationDate,
    required this.connectedDevices,
    required this.inviteLink,
  });
}
