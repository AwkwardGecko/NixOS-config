{
  github-token.age = {
    file = ./github-token.txt;
    # Make sure the host name matches your nixosConfiguration key
    # You called it `z-nixos` in flake.nix
    # Also, you can add other users or machines here.
    publicKeys = [ ./agenix-ssh-key.pub ];
    # Where to place the decrypted secret on the target machine
    path = "/etc/secrets/github-token";
    owner = "root";
    group = "root";
    mode = "0400";
  };
}

