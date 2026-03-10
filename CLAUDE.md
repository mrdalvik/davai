# Davai

If `installed/config.yml` exists and has a `tool:` value other than `null` — the framework is configured. Read and follow `.claude/CLAUDE.md` for full instructions.

Otherwise, this is the first launch:

1. Greet the user (detect language from their message, use both if unknown):

"Hi! I'm Davai. Setting up the framework..."

2. Run `bash framework/setup.sh claude-code` to configure.

3. Read `.claude/CLAUDE.md` (it was just created by setup). Follow those instructions for the rest of this session — starting from the Startup section. Do NOT ask the user to restart.

**Important:** Detect the user's language from their first message and respond in that language.
