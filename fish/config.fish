if status is-interactive
  # Commands to run in interactive sessions can go here

  set -U fish_features qmark-noglob
  set -g fish_key_bindings fish_hybrid_key_bindings

  if functions -q skim_key_bindings
    skim_key_bindings
  end
end

if should_launch_sway
  launch_sway
end
