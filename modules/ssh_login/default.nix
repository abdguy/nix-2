_:
{
  users.users.lun = {
    uid = 1000;
    isNormalUser = true;

    openssh.authorizedKeys.keyFiles = [
      ./keys.pub
    ];
  };
}
