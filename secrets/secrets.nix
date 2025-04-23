let
   github-token-ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmBtbRHIiny56UVPCWE3icyyHZLZdb2U2Y3eDWUbtXE";
   
   systems = [ 
      github-token-ssh
   ];

in

{
   "github-token.age".publicKeys = systems;
}
