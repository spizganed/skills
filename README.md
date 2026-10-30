# skills

Six small skills for Claude Code and DeepSeek Harness. Each skill is one `SKILL.md` file. Together they cut wasted code, wasted words and UI drift.

| Skill | Loads | What it makes Claude do |
|---|---|---|
| [`yagni`](yagni/SKILL.md) | Any coding task | Build only what the task needs. Reuse code that exists. Fix the cause, not the symptom. |
| [`ooga-bogga`](ooga-bogga/SKILL.md) | Every chat reply | Answer first. Cut filler, pleasantries and recaps. Keep code and numbers exact. |
| [`asd-ste100`](asd-ste100/SKILL.md) | Any writing task | Write docs, commits and comments in Simplified Technical English. |
| [`ui-ux`](ui-ux/SKILL.md) | UI work (screens, themes, layouts, animation) | Copy sibling screens, use shared tokens, build every state. Android first (Material 3), also iOS and web. |
| [`audit-repo`](audit-repo/SKILL.md) | Only on `/audit-repo` | Audit a repo for bugs, doc errors and sensitive data. Report fixes. Edit nothing. |
| [`audit-ui`](audit-ui/SKILL.md) | Only on `/audit-ui` | Audit a UI against the `ui-ux` rules: quick by default (6 images), full on request. Report fixes. Edit nothing. |

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
- Read 2 sibling screens and copy their spacing, type and colors. Use the shared tokens, never a literal value.
- Define each animation once by role (press, toggle, screen enter). Reuse it everywhere.
- Build all states: default, pressed, focus, disabled, loading, empty, error.
- Follow the platform: Material 3 on Android, the HIG on iOS. Values are in `references/platforms.md`.
- Contrast 4.5:1 or more. Touch targets 48 dp (44 pt on iOS). Text grows to 200 percent.
- Render the final content first, then animate once. Clip rounded shapes cleanly.

**audit-repo**
- Ask for the repo, the branch and the history scan with a picker.
- Read every tracked file, code and docs.
- Check for bugs, secrets, personal data, broken links and stale facts.
- Report one finding per line, sorted by severity, with a fix marked safe or risky.
- Edit nothing until you approve a fix.

**audit-ui**
- Quick by default: at most 6 images of one screen (light, dark, 200 percent text, empty, error, keyboard). Add `full` for the whole matrix.
- Run the cheap checks first. On Android, [whiskerADB](https://github.com/spizganed/whiskerADB) `pp audit` finds small targets and unlabeled controls with no image.
- Cite measured values: `contrast 3.1:1, needs 4.5:1`.
- Report one finding per line with evidence, a severity and a fix. Skip findings in `.audit-ui-baseline.md`.
- Edit nothing until you approve a fix. Then capture again and confirm.

## Example

`ui-ux` shapes the UI while Claude builds it. `/audit-ui` checks the result.

![Screen built without and with the ui-ux skill](examples/ui-ux-before-after.png)

The source is [`examples/mock.html`](examples/mock.html).

`/audit-ui` on the left screen:

![Annotated findings](examples/audit-ui-annotated.png)

The full report is [`examples/audit-ui-report.md`](examples/audit-ui-report.md). It comes from the earlier, deeper version of the audit. The report format is the same.

## Status line (optional)

[`statusline/`](statusline/README.md) is not a skill. It is a script for the Claude Code status bar. It shows your active skills, the 5 h and 7 d usage limits, and context use. The folder has manual steps and a prompt that tells an agent to install it.

## Install

```sh
git clone https://github.com/spizganed/skills.git
cp -r skills/{yagni,ooga-bogga,asd-ste100,ui-ux,audit-repo,audit-ui} ~/.claude/skills/
```

Restart Claude Code. Install only the skills you want: each folder works alone.

To update, run `git pull` and copy the folders again.

### DeepSeek Harness (dsh)

The `SKILL.md` files work in [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness) with no change. Run the installer:

```sh
git clone https://github.com/spizganed/skills.git
skills/dsh/install.sh
```

- dsh has no switch that loads a skill in every session. The installer puts `yagni`, `ooga-bogga` and `asd-ste100` into `~/.dsh/AGENTS.md`, which every session reads.
- It copies `ui-ux`, `audit-repo` and `audit-ui` to `~/.dsh/skills`. dsh loads `ui-ux` on UI work. The audit skills load only on `/audit-repo` and `/audit-ui`.
- It replaces only its own block in `AGENTS.md`. Your other lines stay.
- `DSH_HOME` sets another dsh home. To update, run `git pull` and the installer again.

Tested with dsh 0.2.1-rc.2.

## How a skill loads

Claude reads the `description` line in each `SKILL.md` front matter. It loads the full file only when the description matches the task. This keeps the context small. `audit-repo` and `audit-ui` never load on their own: they set `disable-model-invocation`, so only `/audit-repo` and `/audit-ui` start them. `ui-ux` loads on UI work and holds the rules. `audit-ui` checks the UI against them.

## Use `ooga-bogga` and `asd-ste100` together

They do not conflict. `ooga-bogga` shapes chat replies. `asd-ste100` shapes everything written to files.

## License

MIT. See [LICENSE](LICENSE).
