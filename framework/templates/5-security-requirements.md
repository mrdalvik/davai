# Security Requirements: <Product Name>

## Threat Model

Brief overview: what's at risk, who are potential attackers, what's the impact.

### Data Classification
| Data | Sensitivity | Storage | Protection |
|------|------------|---------|------------|
| ... | high/medium/low | where it's stored | how it's protected |

## Authentication & Authorization

- **Auth method:** ...
- **Session management:** ...
- **Access control:** ...

## Input Validation & Output Encoding

| Input Source | Validation | Risks if skipped |
|-------------|------------|------------------|
| ... | ... | ... |

## Secrets & Configuration

| Secret | Where stored | How accessed |
|--------|-------------|--------------|
| ... | ... | ... |

- Environment variable naming convention: ...
- `.env` is in `.gitignore`: yes/no

## Infrastructure & Deployment

- **HTTPS:** ...
- **CORS policy:** ...
- **Headers:** ...
- **Rate limiting:** ...

## Dependencies

- **Lock file:** ...
- **Known vulnerabilities check:** ...
- **Trust boundaries for third-party APIs:** ...

## Security Checklist for Development

Ordered list of security tasks to integrate into development:

- [ ] ...
- [ ] ...
