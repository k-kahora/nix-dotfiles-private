{pkgs, config, ...}:
{
  home.packages = with pkgs;[
  
  # Testing out writing shell applications
  (writeShellApplication {

    name = "show-nix-os.org";
    runtimeInputs = [curl w3m cowsay];
    text = ''
    curl -s 'https://nixos.org' | w3m -dump -T text/html
    '';
  })


  # easy tcnj vpn
  (writeShellApplication {

    name = "tcnj-vpn";
    runtimeInputs = [openconnect];
    text = ''
         sudo openconnect --protocol=gp vpn-gw-ft.tcnj.edu --quiet --user=kahoram1
         '';
  })

  # precise controlling of inputs
  # Updates the lock attribute for the input you give it
  (writeShellApplication {
    name = "update-inputs";
    runtimeInputs = [jq fzf];
    
    text = ''
    input=$( \
      nix flake metadata --json \
      | jq ".locks.nodes.root.inputs[]" \
      | sed "s/\"//g" \
      | fzf ) 
    nix flake lock --update-input "$input"
    '';
  })

  ];
}
