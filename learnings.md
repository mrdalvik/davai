# Learnings

Project insights accumulated over time. Read this before making recommendations for new projects.

Each entry follows a structured format — see CEO instructions (Learnings Format section) for the schema.

## second-by-kxtss (2026-03-08)
- **Type**: онлайн-секондхенд, каталог + бронирование
- **Stack**: Node.js (генератор сайта) + Python (Telegram-бот + FastAPI + SQLite)
- **Skills used**: frontend-design (library), site-generator (custom), telegram-bot (custom)
- **What worked**: статусы вещей подгружаются динамически через API бота (а не пересборка сайта); slug (имя папки) = ID вещи везде (сайт, API, бот deep link)
- **What didn't**: —
- **Notes**: хостинг GitHub Pages (статика) + VPS (бот + API)
