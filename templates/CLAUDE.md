# Project: [Your Project Name]

This is an example, not detected project configuration. Replace the stack,
commands, paths, and conventions with those verified in your repository before
using this file. Record actual dependency versions from its manifests/lockfiles.

## Overview
[Brief description of what this project does]

## Tech Stack
- **Frontend**: [framework and verified project version, e.g., Next.js, React, Vue, Svelte]
- **Backend**: [e.g., Node.js, Python, Go, Rust]
- **Database**: [e.g., PostgreSQL, MongoDB, SQLite]
- **Styling**: [e.g., TailwindCSS, CSS Modules, Styled Components]
- **Deployment**: [e.g., Vercel, AWS, Docker, Railway]

## Directory Structure
```
/src
  /components    # Reusable UI components
  /pages         # Page components / routes
  /lib           # Utility functions
  /hooks         # Custom React hooks
  /types         # TypeScript type definitions
  /styles        # Global styles
/tests           # Test files
/public          # Static assets
/docs            # Documentation
```

## Commands
```bash
npm run dev      # Start development server
npm run build    # Build for production
npm run start    # Start production server
npm run test     # Run tests
npm run lint     # Lint code
npm run format   # Format code with Prettier
```

## Coding Standards
- Use TypeScript strict mode
- Follow ESLint rules (no warnings allowed)
- Format with Prettier on save
- Write tests for new features
- Use conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`
- Maximum function length: 50 lines
- Prefer composition over inheritance

## Environment Variables
Copy `.env.example` to `.env.local` and fill in:
```
DATABASE_URL=
API_KEY=
NEXT_PUBLIC_APP_URL=
```

## Important Files
- `src/lib/config.ts` - App configuration
- `src/types/index.ts` - Shared type definitions
- `src/lib/api.ts` - API client
- `prisma/schema.prisma` - Database schema

## Git Workflow
1. Inspect the repository's current branch and contribution workflow
2. Make the requested local changes while preserving existing work
3. Run the relevant tests and linter
4. Report the diff and validation results for review
5. Commit, push, create a PR, or merge only when the user explicitly requests it

## Notes
- [Add any special instructions]
- [Known issues or gotchas]
- [Links to related docs]
