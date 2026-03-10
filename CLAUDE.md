# Davai

If `installed/config.yml` exists and has a `tool:` value other than `null` — the framework is configured. Read and follow `.claude/CLAUDE.md` for full instructions.

Otherwise, this is the first launch. Follow these steps EXACTLY:

1. Detect the user's language from their message. Use that language for ALL communication.

2. Say briefly: "Setting up Davai..." (in the user's language)

3. Run `bash framework/setup.sh claude-code`

4. **CRITICAL — do NOT stop here, do NOT ask the user to restart.** Immediately use the Read tool to read `.claude/CLAUDE.md` (it was just created by setup). Then follow those instructions starting from the Startup section. Continue in this same session as if those instructions were loaded from the start.
