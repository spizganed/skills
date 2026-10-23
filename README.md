# skills

Six small skills for Claude Code. Each skill is one `SKILL.md` file. Together they cut wasted code, wasted words and UI drift.

| Skill | Loads | What it makes Claude do |
|---|---|---|
| [`yagni`](yagni/SKILL.md) | Any coding task | Build only what the task needs. Reuse code that exists. Fix the cause, not the symptom. |
| [`ooga-bogga`](ooga-bogga/SKILL.md) | Every chat reply | Answer first. Cut filler, pleasantries and recaps. Keep code and numbers exact. |
| [`asd-ste100`](asd-ste100/SKILL.md) | Any writing task | Write docs, commits and comments in Simplified Technical English. |
| [`ui-ux`](ui-ux/SKILL.md) | UI work only | Copy sibling screens, reuse tokens and animations, build every state. |
| [`audit-repo`](audit-repo/SKILL.md) | Only on `/audit-repo` | Audit a repo for bugs, doc errors and sensitive data. Report fixes. Edit nothing. |
| [`audit-ui`](audit-ui/SKILL.md) | Only on `/audit-ui` | Check screenshots, a recording or a URL against the `ui-ux` rules. Report fixes. Edit nothing. |

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
- Base rules on the Apple Human Interface Guidelines. Exact values are in `references/hig.md`. Contrast 4.5:1 or more. Touch targets 44 pt or 48 dp or more.
- Render the final content first, then animate once. Clip rounded shapes cleanly.
- Run the UI at the smallest and largest size. Report what you saw.

**audit-repo**
- Ask for the repo, the branch and the history scan with a picker.
- Read every tracked file, code and docs.
- Check for bugs, secrets, personal data, broken links and stale facts.
- Report one finding per line, sorted by severity, with a fix marked safe or risky.
- Edit nothing until you approve a fix.

**audit-ui**
- Take screenshots, a recording or a URL. Judge only what you have seen.
- Check each `ui-ux` rule: job, consistency, layout, targets, states, contrast, content, sizes, motion.
- Zoom in for pixelated or square backgrounds on rounded shapes, blurry assets, mixed icons and odd switches or sliders.
- Split a recording into frames to find a refresh flash before an animation, and two animations that fight.
- Measure values from the image. Cite them: `contrast 3.1:1, needs 4.5:1`.
- Capture a matrix: light, dark and Increase Contrast; default and 200 percent text; small and large windows; empty, long, error and loading content.
- Operate the controls: tap, toggle, drag. Check each result.
- Measure with `measure.py`: contrast, target size, square corners, sharpness and refresh flash. Capture steps are in `capture.md`.
- Report one finding per line with evidence, a severity and a fix. Skip findings in `.audit-ui-baseline.md`.
- Edit nothing until you approve a fix. Then capture again and confirm.

## Example

`ui-ux` shapes the UI while Claude builds it. `/audit-ui` checks the result.

![Screen built without and with the ui-ux skill](examples/ui-ux-before-after.png)

The source is [`examples/mock.html`](examples/mock.html).

`/audit-ui` on the left screen:

![Annotated findings](examples/audit-ui-annotated.png)

The full report is [`examples/audit-ui-report.md`](examples/audit-ui-report.md).

## Status line (optional)

[`statusline/`](statusline/README.md) is not a skill. It is a script for the Claude Code status bar. It shows your active skills, the 5 h and 7 d usage limits, and context use. The folder has manual steps and a prompt that tells an agent to install it.

## Install

```sh
git clone https://github.com/spizganed/skills.git
cp -r skills/{yagni,ooga-bogga,asd-ste100,ui-ux,audit-repo,audit-ui} ~/.claude/skills/
```

Restart Claude Code. Install only the skills you want: each folder works alone.

To update, run `git pull` and copy the folders again.

## How a skill loads

Claude reads the `description` line in each `SKILL.md` front matter. It loads the full file only when the description matches the task. This keeps the context small. `audit-repo` and `audit-ui` never load on their own: they set `disable-model-invocation`, so only `/audit-repo` and `/audit-ui` start them. `ui-ux` loads on UI work and holds the rules. `audit-ui` checks the UI against them.

## Use `ooga-bogga` and `asd-ste100` together

They do not conflict. `ooga-bogga` shapes chat replies. `asd-ste100` shapes everything written to files.

## License

MIT. See [LICENSE](LICENSE).
