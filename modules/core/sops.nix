{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  # Secrets live encrypted in-tree (secrets/secrets.yaml) and are decrypted at
  # activation into /run/secrets, which never touches the nix store. Recipients
  # are listed in .sops.yaml:
  #   - each host, via its SSH host key (so it can decrypt unattended at boot)
  #   - holly, via ~/.ssh/id_ed25519 (so secrets stay editable)
  # Edit with `sops secrets/secrets.yaml`; re-key after changing recipients with
  # `sops updatekeys secrets/secrets.yaml`.
  #
  # Only the wiring lives here. Individual `sops.secrets.*` belong to the host
  # that is a recipient — declaring one here makes every host try to decrypt it.
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  };

  # `sops` for editing secrets, `ssh-to-age` for turning an SSH key into the age
  # recipient that .sops.yaml wants.
  environment.systemPackages = with pkgs; [
    sops
    ssh-to-age
  ];
}
