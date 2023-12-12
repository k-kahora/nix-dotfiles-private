{pkgs, config, ...}:
{
  programs.firefox = {
    enable = true;
    profiles.holly-hawk = {
   search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
      };

      userChrome = ''                         
        /* some css */                        
      '';    

      # See all extensions
      # nix flake show "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        block-origin
        ponsorblock
        arkreader
        ridactyl
        youtube-shorts-block
	org-capture
      ];

    };
}
