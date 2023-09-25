{pkgs, config, ...}:
{
  pkgs.writeShellApplication {

    name = "show-nix-os.org"
    runTimeInputs = [curl w3m ];
    text = ''
    curl -s 'http://nixos.org' | w3m -dump -T text/htmy
    '';
  };
}
