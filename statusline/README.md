# statusline

A status line for Claude Code. It is not a skill. A skill cannot draw the bar, so this folder holds a script and a setting.

```
YAGNI ● │ OOGA-BOGGA ● │ ASD-STE100 ● │ UI-UX ● │ QUICKAUDIT ●
5h ███░░░ 48% 2h10m │ 7d █░░░░░ 17% 4d3h
Opus 5.5 high │ ctx ██░░░░ 31% 62k/200k
```

- **Row 1, skills.** Green: on. Red: you switched it off in `settings.json`. Grey: not used yet.
- **Row 2, limits.** Usage of the 5 h and 7 d limits, with the time to reset. Claude.ai plans only.
- **Row 3.** Model, effort, and context use in tokens.
- Bars turn yellow at 60 % and red at 85 %.

## Install by hand

Works on Linux, macOS, Windows (Git Bash) and Termux. The script uses only bash 3.2 features, `grep -E` and `jq`.

Needs `bash` and `jq` (1.6 or newer). Install `jq` with `sudo pacman -S jq` (Arch), `sudo apt install jq` (Debian, Ubuntu), `brew install jq` (macOS) or `pkg install jq` (Termux).
Claude Code runs the command with `sh`, so your login shell (fish, zsh) does not matter. On Windows, run Claude Code with Git Bash on `PATH`.

1. Copy the script:
   ```sh
   mkdir -p ~/.claude
   cp statusline.sh ~/.claude/statusline.sh
   ```
2. Add this to `~/.claude/settings.json`. Merge it with the keys that are already there.
   ```json
   "statusLine": { "type": "command", "command": "bash ~/.claude/statusline.sh" }
   ```
3. Restart Claude Code.

Edit `ALWAYS` and `ON_USE` at the top of the script to list your skills, or set the variables `STATUSLINE_ALWAYS` and `STATUSLINE_ON_USE`. A skill that is not installed is not shown. Without `jq`, the bar shows "statusline: install jq".
- `ALWAYS`: green while the skill file exists and `settings.json` does not set it to `"off"`.
- `ON_USE`: grey until this session invokes the skill. Use it for skills that load on their own.

## Let an agent install it

Give your agent this prompt. Replace `<path>` with the folder of this repo.

> Install the Claude Code status line from `<path>/statusline`. Read its README first.
> Check that `jq` exists. Copy `statusline.sh` to `~/.claude/statusline.sh`.
> Add the `statusLine` key to `~/.claude/settings.json` and keep every other key.
> If a `statusLine` key exists already, show it to me and ask before you replace it.
> Set `ALWAYS` and `ON_USE` to the skills in `~/.claude/skills`.
> Test with: `echo '{}' | bash ~/.claude/statusline.sh`. Tell me to restart Claude Code.

Or from GitHub: "Fetch https://github.com/spizganed/skills/tree/main/statusline and install it as its README says."

## Test

```sh
echo '{"model":{"display_name":"Opus"},"context_window":{"used_percentage":31,"total_input_tokens":62000,"context_window_size":200000},"rate_limits":{"five_hour":{"used_percentage":48,"resets_at":'$(( $(date +%s) + 7800 ))'}}}' | bash statusline.sh
```

## Notes

- The script reads one JSON object from stdin. Claude Code sends it on every refresh.
- `rate_limits` is absent on API-key use. Row 2 then stays empty.
- Remove it: delete the `statusLine` key.
