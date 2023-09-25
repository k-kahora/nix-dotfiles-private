{pkgs, config, ...}:
{
  home.packages = with pkgs;[
  
  (writeShellApplication {

    name = "show-nix-os.org";
    runtimeInputs = [curl w3m cowsay];
    text = ''
    curl -s 'https://nixos.org' | w3m -dump -T text/html
    '';
  })


  ];
}
