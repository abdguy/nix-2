_:
{
  users.users.hackson = {
    uid = 1000;
    isNormalUser = true;

    openssh.authorizedKeys.keyFiles = [
      ./keys.pub
    ];
  };
}
