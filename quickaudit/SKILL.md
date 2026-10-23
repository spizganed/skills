---
name: quickaudit
description: Audit code or .md files. Report findings and propose fixes. Run only when the user types /quickaudit.
disable-model-invocation: true
---

# Quick audit

Audit the target. Report findings. Propose fixes. Do not edit any file.

## Target

- Use the argument as the target: a repo, a directory, a file, or a skill name.
- With no argument, use the active repo: run `git rev-parse --show-toplevel` from the current directory.
- If the current directory is not in a repo, use the current directory.
- Confirm the target before you read anything. Use AskUserQuestion to show the selected repo path and the current branch (`git branch --show-current`).
- Offer these options: "Use this repo and branch (Recommended)", "Choose another repo" (list the repos in `~/projects` and `~/misa` and `~/QuickBuds` that exist), "Choose another branch" (list `git branch --all`). The user can also type a path or branch in Other.
- To audit another branch, do not switch the branch in the working tree. Use `git ls-tree` and `git show <branch>:<file>`, or `git worktree add` in the scratchpad directory.
- Audit the whole repo, not only the changed files. Include code and .md files.
- Read every tracked file. Use `git ls-files` to list them. Skip build output, lock files, and binaries.
- Read a large repo in parts. Do not skip a directory.

## Checks for code

- Bugs: wrong logic, unhandled error, race, off-by-one.
- Security: secret in source, unsafe input, unsafe permission.
- Dead code, duplicate code, unused dependency.
- Code that breaks the style of the surrounding code.

## Checks for sensitive data (code and .md files)

- Secrets: API key, token, password, private key, credential in a URL.
- Personal details of any person: real name, email address, phone number, home address, account ID, handle, location.
- Private device data: IP address, MAC address, serial number, hostname, absolute path with a user name.
- Report the place and the kind of data. Do not print the secret or the detail in full. Show the first 4 characters at most.
- Propose a fix: remove it, replace it with a placeholder, move it to an ignored file, or rotate the secret.

## Checks for .md files (docs, skills, memory, CLAUDE.md)

- Frontmatter: `name` matches the directory. `description` is present and says when to use it.
- Broken link, broken `[[memory link]]`, or reference to a file that does not exist.
- A fact that is out of date. Verify it against the files before you report it.
- Two rules that contradict each other, in one file or across files.
- Duplicate text that another file already holds.
- Text that breaks the `asd-ste100` rules: sentence over 20 words, fragment, filler.
- Text that costs context and gives no value.

## Commit history (optional)

- Before you start, ask the user with AskUserQuestion: "Also scan the commit history for sensitive data?"
- Give two options: "No, current files only (Recommended)" and "Yes, scan the history". Note that the history scan costs more.
- On yes, scan only for sensitive data. Do not review old code for bugs.
- Use `git log -p` or `git log --all -S<pattern>` with narrow patterns. Do not read every diff in full.
- Also list the author names and emails in the history with `git log --format='%an <%ae>' | sort -u`.
- For each hit, give the commit hash, the file, and the kind of data.
- Tell the user that a removal from the history needs a rewrite (for example `git filter-repo`) and a force push. A leaked secret needs rotation even after removal.
- Never rewrite the history yourself.

## Report

- One finding per line: `file:line` - problem - severity (high, medium, low).
- Sort by severity, high first.
- After each finding, give one proposed fix. Show the exact new text when the fix is small.
- Mark each fix as safe or risky.
- End with a count per severity. If you find nothing, say so.

## After the report

- Ask which fixes to apply.
- Apply only the fixes the user approves.
