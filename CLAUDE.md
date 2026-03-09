# davai — first launch

This is a bootstrap file. The framework is not yet configured.

## What to do

1. Greet the user (detect language from their message, use both if unknown):

"Hi! I'm davai. Before we start, let's set up the framework."

2. Ask which AI tool they're using:

"Which AI tool are you using?
1) Claude Code
2) Cursor"

3. Run `framework/setup.sh` with the user's choice — pass `1` or `2` as stdin input.

4. Tell the user:

"Setup complete! Restart the session to load the full framework."

**Important:** Detect the user's language from their first message and respond in that language.
