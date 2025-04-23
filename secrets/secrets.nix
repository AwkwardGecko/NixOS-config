let
   github-token = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmBtbRHIiny56UVPCWE3icyyHZLZdb2U2Y3eDWUbtXE";
in

{ "github-token.age".publicKeys = github-token; }
