# Claude Code Essential Resources

## Quick Setup: Install Community Plugins

```powershell
# Plugin marketplace (in Claude Code)
/plugin install https://github.com/wshobson/commands
```

---

## Must-Have Slash Commands

### Create These in `.claude/commands/`

#### `/fix-issue.md` - Auto-fix GitHub Issues

```markdown
---
description: Analyze and fix a GitHub issue
---
Please analyze and fix GitHub issue: $ARGUMENTS

1. Use `gh issue view $ARGUMENTS` to get details
2. Search codebase for relevant files
3. Implement the fix
4. Write tests
5. Run linter
6. Commit with message referencing issue
```

#### `/review.md` - Code Review

```markdown
---
description: Review code for best practices
---
Review the code for:
1. Security vulnerabilities
2. Performance issues
3. Error handling
4. Code style consistency
5. Test coverage gaps

Provide specific suggestions with code examples.
```

#### `/test.md` - Generate Tests

```markdown
---
description: Generate tests for a file
---
Generate comprehensive tests for: $ARGUMENTS

1. Unit tests for all functions
2. Edge cases
3. Error scenarios
4. Integration tests if applicable
5. Use existing test patterns in codebase
```

#### `/refactor.md` - Smart Refactoring

```markdown
---
description: Refactor code with best practices
---
Refactor the following code: $ARGUMENTS

1. Improve readability
2. Extract reusable functions
3. Add proper typing
4. Improve error handling
5. Maintain backward compatibility
```

#### `/document.md` - Auto Documentation

```markdown
---
description: Generate documentation
---
Generate documentation for: $ARGUMENTS

1. Function/class docstrings
2. README sections if needed
3. Usage examples
4. Type annotations
5. Inline comments for complex logic
```

---

## Essential Skills

### Create These in `.claude/skills/`

#### `.claude/skills/code-quality/SKILL.md`

```markdown
---
name: code-quality
description: Enforce code quality standards
---
When writing or reviewing code:

1. Follow project style guide
2. Use meaningful variable names
3. Keep functions under 50 lines
4. Add error handling
5. Write self-documenting code
6. Avoid magic numbers
7. Use early returns
```

#### `.claude/skills/security/SKILL.md`

```markdown
---
name: security
description: Security best practices
---
Always check for:

1. SQL injection vulnerabilities
2. XSS in user inputs
3. Hardcoded secrets
4. Insecure dependencies
5. Missing input validation
6. Improper error exposure
7. Missing authentication checks
```

#### `.claude/skills/git-workflow/SKILL.md`

```markdown
---
name: git-workflow
description: Git best practices
---
When working with git:

1. Write clear commit messages
2. Keep commits atomic
3. Use conventional commits format
4. Create feature branches
5. Squash WIP commits before merge
6. Always pull before push
```

---

## Useful Subagents

### Create in `.claude/agents/`

#### `.claude/agents/researcher.md`

```markdown
---
name: researcher
description: Research codebase thoroughly
tools: Read, Glob, Grep
---
You are a research agent. Your job is to:

1. Find all relevant files
2. Understand code patterns
3. Document dependencies
4. Summarize findings

Do NOT modify any files.
```

#### `.claude/agents/planner.md`

```markdown
---
name: planner
description: Create implementation plans
tools: Read, Glob, Grep
---
You are a planning agent. Create detailed plans:

1. Break down the task
2. Identify files to modify
3. List potential risks
4. Estimate complexity
5. Suggest testing approach

Output a structured plan in markdown.
```

---

## Hooks Examples

Create hooks in `.claude/hooks.json`:

```json
{
  "hooks": [
    {
      "event": "preToolUse",
      "matcher": { "tool": "Write" },
      "command": "echo 'Writing file...'"
    },
    {
      "event": "postToolUse", 
      "matcher": { "tool": "Bash" },
      "command": "echo 'Command completed'"
    }
  ]
}
```

### Common Hook Events

| Event | When |
|-------|------|
| `preToolUse` | Before a tool runs |
| `postToolUse` | After a tool completes |
| `onNotification` | On notifications |
| `onError` | On errors |

### Pre-commit Hook Example

Create `.claude/hooks/pre-commit.sh`:

```bash
#!/bin/bash
npm run lint
npm run test
```

---

## Popular MCP Servers

```powershell
# GitHub integration
claude mcp add github npx @anthropic-ai/mcp-server-github

# File system access
claude mcp add filesystem npx @anthropic-ai/mcp-server-filesystem

# Browser automation
claude mcp add puppeteer npx @anthropic-ai/mcp-server-puppeteer

# PostgreSQL database
claude mcp add postgres npx @anthropic-ai/mcp-server-postgres

# Web search
claude mcp add brave-search npx @anthropic-ai/mcp-server-brave-search
```

---

## CLAUDE.md Template

Create this in your project root:

```markdown
# Project: [Name]

## Overview
[Brief description]

## Tech Stack
- Frontend: [e.g., Next.js, React, Vue]
- Backend: [e.g., Node.js, Python, Go]
- Database: [e.g., PostgreSQL, MongoDB]
- Deployment: [e.g., Vercel, AWS, Docker]

## Directory Structure
- `/src` - Source code
- `/tests` - Test files
- `/docs` - Documentation

## Commands
- `npm run dev` - Start development
- `npm run build` - Build for production
- `npm run test` - Run tests
- `npm run lint` - Lint code

## Coding Standards
- Use TypeScript strict mode
- Follow ESLint rules
- Write tests for new features
- Use conventional commits

## Important Files
- `src/config.ts` - Configuration
- `src/types/` - Type definitions
- `.env.example` - Environment template

## Notes
[Any special instructions or gotchas]
```

---

## Community Resources

### Plugin Collections

| Resource | Description |
|----------|-------------|
| [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | Curated list of everything Claude Code |
| [wshobson/commands](https://github.com/wshobson/commands) | 57+ production-ready commands |
| [claude-code-templates](https://github.com/davila7/claude-code-templates) | Templates with UI dashboard |

### Workflows

| Resource | Description |
|----------|-------------|
| [Claude Code PM](https://github.com/automazeio/ccpm) | Project management workflow |
| [Simone](https://github.com/Helmi/claude-simone) | Full SDLC workflow |
| [SuperClaude](https://github.com/ArcadeLabsInc/superClaude) | Enhanced commands & personas |

### Tools

| Resource | Description |
|----------|-------------|
| [Claude Squad](https://github.com/smtg-ai/claude-squad) | Run multiple agents in parallel |
| [ccusage](https://github.com/ryoppippi/ccusage) | Token usage analytics |
| [Container Use](https://github.com/dagger/container-use) | Sandboxed agent environments |

---

## Quick Reference

### Built-in Subagents

| Agent | Use For |
|-------|---------|
| `Explore` | Read-only codebase research |
| `Plan` | Create implementation plans |
| `general-purpose` | Full tool access tasks |

### Skill Frontmatter Options

```markdown
---
name: skill-name
description: When to use this skill
context: fork          # Run in isolated context
agent: Explore         # Use specific subagent
allowed-tools: Bash(*) # Restrict tools
---
```

### Useful Environment Variables

```powershell
# Increase skill budget
$env:SLASH_COMMAND_TOOL_CHAR_BUDGET = "30000"

# Enable extended thinking
# Add "ultrathink" anywhere in skill content
```

---

## Installation Script

Save and run to set up essentials:

```powershell
# Create directories
New-Item -ItemType Directory -Force -Path "$HOME\.claude\commands"
New-Item -ItemType Directory -Force -Path "$HOME\.claude\skills"
New-Item -ItemType Directory -Force -Path "$HOME\.claude\agents"

Write-Host "Claude Code directories created!" -ForegroundColor Green
Write-Host "Add your custom commands to: $HOME\.claude\commands\" 
Write-Host "Add your skills to: $HOME\.claude\skills\"
Write-Host "Add your agents to: $HOME\.claude\agents\"
```

---

## Learn More

- **Official Docs**: https://docs.anthropic.com/claude-code
- **Best Practices**: https://anthropic.com/engineering/claude-code-best-practices
- **Skills Docs**: https://code.claude.com/docs/en/skills
- **Awesome List**: https://github.com/hesreallyhim/awesome-claude-code
