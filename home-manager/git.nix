{pkgs, config, ...}:
{
  programs.git = {
    enable = true;
    userName = "k-kahora";
    userEmail = "mango22mjk@gmail.com";
    aliases = {
      pu = "push";
      co = "commit";
      ck = "checkout";
    };
  };
}
