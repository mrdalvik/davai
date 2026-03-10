# Davai

If `installed/config.yml` exists and has a `tool:` value other than `null` — the framework is configured. Read and follow `.claude/CLAUDE.md` for full instructions.

Otherwise, this is the first launch:

1. Greet the user (detect language from their message, use both if unknown):

"Hi! I'm Davai. Setting up the framework..."

2. Run `bash framework/setup.sh claude-code` to configure.

3. Tell the user:

"Setup complete! Restart the session to load the full framework."

**Important:** Detect the user's language from their first message and respond in that language.
