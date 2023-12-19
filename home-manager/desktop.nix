{pkgs, config, ...}:
{ 
  home.file.".local/share/applications/emacs-client.desktop".text = ''
[Desktop Entry]
Name=Emaxclient
Exec=emacsclient -c
Icon=myapp
Type=Application
Categories=Utility
'';
  home.file.".local/share/applications/emacs.desktop".text = ''
[Desktop Entry]
Name=Emax
Exec=emacs 
Icon=myapp
Type=Application
Categories=Utility
'';
  home.file.".local/share/applications/emacs-server.desktop".text = ''
[Desktop Entry]
Name=Emaxserver
Exec=emacs --init-directory=/home/malcolm/nix-dotfiles/home-manager/emacs --fg-daemon
Icon=myapp
Type=Application
Categories=Utility
'';
}
