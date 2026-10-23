# skills

Five small skills for Claude Code. Each skill is one `SKILL.md` file. Together they cut wasted code, wasted words and UI drift.

| Skill | Loads | What it makes Claude do |
|---|---|---|
| [`yagni`](yagni/SKILL.md) | Any coding task | Build only what the task needs. Reuse code that exists. Fix the cause, not the symptom. |
| [`ooga-bogga`](ooga-bogga/SKILL.md) | Every chat reply | Answer first. Cut filler, pleasantries and recaps. Keep code and numbers exact. |
| [`asd-ste100`](asd-ste100/SKILL.md) | Any writing task | Write docs, commits and comments in Simplified Technical English. |
| [`ui-ux`](ui-ux/SKILL.md) | UI work only | Copy sibling screens, reuse tokens and animations, build every state. |
| [`quickaudit`](quickaudit/SKILL.md) | Only on `/quickaudit` | Audit a repo for bugs, doc errors and sensitive data. Report fixes. Edit nothing. |

## What each skill does

**yagni**
- Read the task and trace the real flow first.
- Check the codebase, the standard library and installed dependencies before you add one.
- Write the smallest change that works. No abstraction or flag for one use.
- When unsure, pick the simple default and say what you left out.

**ooga-bogga**
- Lead with the result. Then the next step.
- Keep articles, "not" and "never". Clarity beats brevity.
- Drops terse mode for security warnings, irreversible actions and unclear order of steps.
- Applies to chat only. Docs and commits stay in normal prose.

**asd-ste100**
- One idea per sentence, 20 words or fewer. Active voice, present tense.
- One term for one thing. Simple verbs: "use", not "utilize".
- State the current fact. Give a past mistake one line: "Was: X. Is: Y."

**ui-ux**
- Name the one job of the screen. Make that action the most visible.
- Read 2 sibling screens and copy their spacing, type and colors.
- Define each animation once by role (press, toggle, screen enter). Reuse it everywhere.
- Build all states: default, pressed, focus, disabled, loading, empty, error.
- Contrast 4.5:1 or more. Touch targets 48 dp or more.
- Run the UI at the smallest and largest size. Report what you saw.

**quickaudit**
- Ask for the repo, the branch and the history scan with a picker.
- Read every tracked file, code and docs.
- Check for bugs, secrets, personal data, broken links and stale facts.
- Report one finding per line, sorted by severity, with a fix marked safe or risky.
- Edit nothing until you approve a fix.

## Status line (optional)

[`statusline/`](statusline/README.md) is not a skill. It is a script for the Claude Code status bar. It shows your active skills, the 5 h and 7 d usage limits, and context use. The folder has manual steps and a prompt that tells an agent to install it.

## Install

```sh
git clone https://github.com/spizganed/skills.git
cp -r skills/{yagni,ooga-bogga,asd-ste100,ui-ux,quickaudit} ~/.claude/skills/
```

Restart Claude Code. Install only the skills you want: each folder works alone.

To update, run `git pull` and copy the folders again.

## How a skill loads

Claude reads the `description` line in each `SKILL.md` front matter. It loads the full file only when the description matches the task. This keeps the context small. `quickaudit` never loads on its own: it sets `disable-model-invocation`, so only `/quickaudit` starts it.

## Use `ooga-bogga` and `asd-ste100` together

They do not conflict. `ooga-bogga` shapes chat replies. `asd-ste100` shapes everything written to files.

## License

MIT. See [LICENSE](LICENSE).
