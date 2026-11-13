function ai() {
  local harness="${1}"

  if [[ -z "${TMUX}" ]]; then
    echo "ai: must be run inside a tmux session" >&2
    return 1
  fi

  if [[ -z "${harness}" ]]; then
    echo "Usage: ai <agent-command>" >&2
    return 1
  fi

  local editor_pane="${TMUX_PANE}"
  local ai_pane

  # Right split (40% width) for the AI agent harness.
  # The harness is sent to a normal shell so the pane returns to a prompt
  # when the harness exits, making it easy to restart manually.
  ai_pane=$(tmux split-window -h -p 40 -d -P -F '#{pane_id}' -t "${editor_pane}")
  tmux send-keys -t "${ai_pane}" "${harness}" C-m

  # Bottom split (15% height) under the editor for a terminal
  tmux split-window -v -p 15 -t "${editor_pane}"

  # Focus the editor pane and open Neovim in the current directory
  tmux select-pane -t "${editor_pane}"
  tmux send-keys -t "${editor_pane}" 'nvim .' C-m
}
