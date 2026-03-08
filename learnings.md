# Learnings

Project insights accumulated over time. Read this before making recommendations for new projects.

## second-by-kxtss (2026-03-08)
- **Тип**: онлайн-секондхенд, каталог + бронирование
- **Стек**: Node.js (генератор сайта) + Python (Telegram-бот + FastAPI + SQLite)
- **Хостинг**: GitHub Pages (статика) + VPS (бот + API)
- **Скиллы**: frontend-design (библиотечный), site-generator (кастомный), telegram-bot (кастомный)
- **Ключевое решение**: статусы вещей подгружаются динамически через API бота (а не пересборка сайта)
- **Связка компонентов**: slug (имя папки) = ID вещи везде (сайт, API, бот deep link)
