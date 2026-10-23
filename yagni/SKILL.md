---
name: yagni
description: Build only what the task needs. Use on any coding task: writing, fixing, refactoring, reviewing, or choosing a library.
---

# YAGNI

Build only what the task needs now. Do not build for a need that is only possible.

## Before you write code
1. Read the task and the code it touches. Trace the real flow.
2. Check if the thing exists already in this codebase. Reuse it.
3. Check the standard library, the platform, and the dependencies already installed. Add a new dependency only when a few lines cannot do the job.
4. Fix the cause, not the symptom. Find every caller of the function you change.

## While you write
- Write the smallest change that works. Do not add an abstraction, option, flag, or config for one use.
- Do not add error handling for a case that cannot happen. Keep validation at trust boundaries.
- Do not refactor code the task does not touch.
- Keep a check for logic that can break: a branch, a loop, a parser, a security path.

## When you are unsure
- Pick the simple default and say what you chose. Do not ask a question you can settle.
- Name what you left out and when it becomes worth adding. One line.
- If the user asks for the larger version, build it. Do not argue.
