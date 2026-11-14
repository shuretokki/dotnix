---
name: dicoding-skills
description: Read a single Dicoding lesson page as plain text with the owner's saved login. Use when the owner gives a dicoding.com/academies/.../tutorials/... link and wants its content, summary or notes.
---

# Dicoding lessons

Run the script with one or more lesson links:

```
python3 -I <skill-dir>/dicoding.py https://www.dicoding.com/academies/185/tutorials/10014
```

The script prints the lesson as Markdown. It reads the login from `$XDG_DATA_HOME/scrapling/dicoding-state.json`, which is `~/.local/share/scrapling/dicoding-state.json` by default.

## Rules

- Never print, copy or move the login file. It holds secrets.
- Read only the lessons the owner names. Do not download a whole course.
- Never start a final exam or an ILT quiz. They are proctored.
- The script exits with `LOGIN_EXPIRED` when the login no longer works. Stop and tell the owner. Do not try to sign in.
- Save long output to a file and read the part you need, so the context stays small.
