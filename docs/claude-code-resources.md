# Claude Code Essential Resources

> **Last Updated:** January 2026 | Comprehensive guide to the best Claude Code extensions, workflows, and tools.

---

## Table of Contents

- [Workflow Systems](#workflow-systems)
- [MCP Servers](#mcp-servers)
- [Command Collections](#command-collections)
- [Skills Packages](#skills-packages)
- [Agent Collections](#agent-collections)
- [Hooks Configuration](#hooks-configuration)
- [CLAUDE.md Templates](#claudemd-templates)
- [Community Resources](#community-resources)
- [Top 30 Resources](#top-30-resources-ranked)
- [Quick Reference](#quick-reference)

---

## Workflow Systems

Full SDLC workflow systems deliver the highest impact for Claude Code productivity.

### BMAD Method (32.9k stars) - RECOMMENDED

The most adopted framework with 21 specialized agents and 50+ guided workflows.

```bash
# Install
npx bmad-method install

# Or clone manually
git clone https://github.com/bmadcode/BMAD-METHOD ~/.claude/bmad
```

**Key Features:**
- Scale-adaptive intelligence (bug fixes to enterprise systems)
- Workflows: `/quick-spec` → `/dev-story` → `/code-review`
- Full planning: PRD creation, architecture, sprint planning
- Claude Code native port: `github.com/aj-geddes/claude-code-bmad-skills`

**Repository:** https://github.com/bmad-code-org/BMAD-METHOD

---

### SuperClaude (20.5k stars)

Structured development platform with 30 commands, 16 agents, and 8 MCP integrations.

```bash
# Install with pipx
pipx install superclaude && superclaude install

# Or npm
npm install -g superclaude
```

**Key Commands:**
- `/sc:brainstorm` - Ideation and planning
- `/sc:design` - System architecture
- `/sc:implement` - Code generation
- `/sc:test` - Test creation
- `/sc:research` - Deep web research (Tavily MCP)

**Benefits:** 2-3x faster execution, 30-50% fewer tokens with MCPs enabled.

**Repository:** https://github.com/SuperClaude-Org/SuperClaude_Framework

---

### CCPM - Claude Code PM (6.1k stars)

GitHub-native project management using Issues as source of truth.

```bash
curl -sSL https://automaze.io/ccpm/install | bash
```

**Key Features:**
- 5-8 parallel AI agents via Git worktrees
- Full traceability: PRD → Epic → Task → Issue → Code → Commit
- 89% less context switching reported
- Up to 3x faster feature delivery

**Repository:** https://github.com/automazeio/ccpm

---

## MCP Servers

Model Context Protocol servers extend Claude Code with external integrations.

### Official MCP Servers (HTTP Transport)

```bash
# GitHub MCP (Official)
claude mcp add --transport http github https://api.githubcopilot.com/mcp/

# Notion MCP (Official)
claude mcp add --transport http notion https://mcp.notion.com/mcp

# Sentry MCP (Error tracking)
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp
```

### NPX-Based MCP Servers

```bash
# Playwright (Microsoft, 25.9k stars) - Browser automation
claude mcp add playwright -- npx @playwright/mcp@latest

# Memory Server - Persistent knowledge graph
claude mcp add memory -- npx -y @modelcontextprotocol/server-memory

# Filesystem Server - Secure file operations
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem "/path/to/allowed"

# DBHub (Bytebase) - Universal database connector
claude mcp add db -- npx -y @bytebase/dbhub --dsn "postgresql://user:pass@localhost:5432/db"

# PostgreSQL
claude mcp add postgres -- npx -y @anthropic-ai/mcp-server-postgres $DATABASE_URL

# Puppeteer - Browser automation
claude mcp add puppeteer -- npx -y @anthropic-ai/mcp-server-puppeteer
```

### Enterprise MCP Servers

| Server | Repository | Purpose |
|--------|------------|---------|
| **AWS MCP** | github.com/awslabs/mcp | Bedrock, S3, Lambda, DynamoDB |
| **Cloudflare MCP** | github.com/cloudflare/mcp-server-cloudflare | Workers, KV, R2, D1 |
| **Neon MCP** | github.com/neondatabase/mcp-server-neon | Serverless Postgres |
| **Supabase MCP** | github.com/supabase/mcp-server | Auth, Storage, Database |

### MCP Management Commands

```bash
# List installed servers
claude mcp list

# Remove a server
claude mcp remove github

# Debug MCP issues
claude --mcp-debug
```

**Registry:** https://registry.modelcontextprotocol.io
**Awesome List:** https://github.com/punkpeye/awesome-mcp-servers (11k+ stars)

---

## Command Collections

### wshobson/commands (57 commands, 1.2k stars)

Production-ready commands for full development lifecycle.

```bash
# Install via plugin
/plugin install https://github.com/wshobson/commands

# Or clone
git clone https://github.com/wshobson/commands ~/.claude/commands
```

**Highlights:**
- `/workflows:feature-development` - Full feature workflow
- `/tools:security-scan` - Security analysis
- `/tools:tdd-cycle` - Test-driven development
- `/tools:k8s-manifest` - Kubernetes generation

---

### Claude-Command-Suite (148+ commands)

Comprehensive command library across all development areas.

```bash
git clone https://github.com/qdhenry/Claude-Command-Suite ~/.claude/commands-suite
```

**Categories:** Testing, Documentation, Refactoring, Git, DevOps, API design

---

### claudekit (20+ subagents)

Auto-checkpointing with specialized subagents.

```bash
/plugin install https://github.com/carlrannaberg/claudekit
```

**Agent Types:** Researcher, Planner, Debugger, Optimizer, Reviewer

---

### Example Commands

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
6. Commit with message: "fix: resolve #$ARGUMENTS"
```

#### `/architect.md` - System Design

```markdown
---
description: Design system architecture
---
Design architecture for: $ARGUMENTS

1. Analyze requirements
2. Define components and responsibilities
3. Design data models
4. Plan API contracts
5. Identify integration points
6. Document trade-offs
7. Create implementation roadmap
```

#### `/security-audit.md` - Security Analysis

```markdown
---
description: Perform security audit
---
Audit security for: $ARGUMENTS

Check for:
1. SQL injection vulnerabilities
2. XSS in templates/outputs
3. CSRF protection
4. Authentication/authorization flaws
5. Hardcoded secrets
6. Insecure dependencies
7. Input validation gaps

Rate: Critical > High > Medium > Low
Provide fixes for each finding.
```

---

## Skills Packages

Skills auto-activate based on context matching.

### Official Anthropic Skills

```bash
git clone https://github.com/anthropics/skills ~/.claude/skills/anthropic
```

**Included:** `docx`, `pdf`, `webapp-testing`, `mcp-builder`

---

### cc-devops-skills (31 skills)

DevOps and infrastructure automation.

```bash
git clone https://github.com/akin-ozer/cc-devops-skills ~/.claude/skills/devops
```

**Categories:**
- Terraform/Terragrunt IaC
- Kubernetes troubleshooting
- AWS cost optimization
- CI/CD automation
- Docker best practices

---

### trailofbits/skills - Security Auditing

Security-focused code analysis from Trail of Bits.

```bash
git clone https://github.com/trailofbits/claude-skills ~/.claude/skills/security
```

**Features:** Vulnerability scanning, SAST patterns, security reviews

---

### VoltAgent/awesome-agent-skills (200+ skills)

Universal skills that work across Claude Code, Codex, and Gemini CLI.

```bash
# Universal installer
npx ai-agent-skills install <repo> --agent claude
```

**Repository:** https://github.com/VoltAgent/awesome-agent-skills

---

### SkillsMP.com Marketplace (71k+ skills)

Searchable marketplace for Claude Code skills.

**Browse:** https://skillsmp.com

---

### Example Skills

#### Code Quality Skill

```markdown
---
name: code-quality
description: Enforce code quality standards
---
When writing or reviewing code:

1. Follow project style guide (check CLAUDE.md)
2. Use meaningful variable names
3. Keep functions under 50 lines
4. Add error handling for external calls
5. Write self-documenting code
6. Avoid magic numbers (use constants)
7. Use early returns to reduce nesting
8. Add JSDoc/docstrings for public APIs
```

#### Security Skill

```markdown
---
name: security
description: Security best practices
---
Always check for:

1. SQL injection - use parameterized queries
2. XSS - escape all user input in HTML
3. Hardcoded secrets - use environment variables
4. Insecure dependencies - check npm audit
5. Missing input validation - validate all inputs
6. Improper error exposure - don't leak stack traces
7. Missing authentication - verify auth on all routes
```

#### Testing Skill

```markdown
---
name: testing
description: Write comprehensive tests
---
When writing tests:

1. Use descriptive names: "should [behavior] when [condition]"
2. Follow Arrange-Act-Assert pattern
3. Test edge cases: null, empty, boundary values
4. Mock external dependencies
5. Prefer integration tests for critical paths
6. Aim for 80% coverage minimum
```

---

## Agent Collections

Custom agents enable parallel and specialized work.

### claude-flow (12.8k stars)

Enterprise-grade multi-agent orchestration with swarm coordination.

```bash
# Install
npm install -g claude-flow

# Or via MCP
claude mcp add claude-flow -- npx -y claude-flow@latest mcp start
```

**Features:**
- 60+ specialized agents
- Hive mind topology with queen-led hierarchies
- Byzantine fault-tolerant consensus
- 175+ MCP tools
- 3-tier model routing (75% cost savings claimed)

**Repository:** https://github.com/ruvnet/claude-flow

---

### VoltAgent/subagents (6.2k stars)

100+ agents across 10 categories.

```bash
git clone https://github.com/VoltAgent/awesome-claude-code-subagents ~/.claude/agents/voltagent
```

**Categories:** Code analysis, documentation, testing, debugging, optimization

---

### wshobson/agents (108 agents)

Comprehensive agent collection with 15 orchestrators.

```bash
git clone https://github.com/wshobson/agents ~/.claude/agents/wshobson
```

---

### Example Agents

#### Researcher Agent

```markdown
---
name: researcher
description: Research codebase thoroughly
tools: Read, Glob, Grep
context: fork
---
You are a research agent. Your job is to:

1. Find all relevant files for the topic
2. Understand code patterns and conventions
3. Document dependencies and relationships
4. Summarize findings with file references

Do NOT modify any files. Output structured markdown.
```

#### Security Auditor Agent

```markdown
---
name: security-auditor
description: Security-focused code analysis
tools: Read, Glob, Grep
context: fork
agent: Explore
---
Audit code for security vulnerabilities:

1. Search for SQL query patterns
2. Find user input handling
3. Check authentication logic
4. Review authorization checks
5. Identify secrets handling

Rate: Critical/High/Medium/Low
Output as security report with remediation.
```

#### Test Writer Agent

```markdown
---
name: test-writer
description: Generate comprehensive tests
tools: Read, Write, Glob, Grep, Bash
context: fork
---
Generate tests for the target:

1. Analyze existing test patterns
2. Identify all functions/methods
3. Write unit tests for each
4. Add edge case tests
5. Add integration tests if applicable
6. Run tests to verify

Match project's test framework and conventions.
```

---

## Hooks Configuration

Hooks are configured in `.claude/settings.json` using the new event-based system.

### Hook Events

| Event | When Triggered |
|-------|----------------|
| `UserPromptSubmit` | Before user prompt is sent |
| `PreToolUse` | Before a tool executes |
| `PostToolUse` | After a tool completes |
| `SessionStart` | When session begins |
| `Stop` | When Claude stops |

### Basic Configuration

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": { "tool": "Bash" },
        "command": "echo 'Running command...'"
      }
    ],
    "PostToolUse": [
      {
        "matcher": { "tool": "Write" },
        "command": "echo 'File written: $TOOL_INPUT_PATH'"
      }
    ]
  }
}
```

### Auto-Lint on File Write

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": { "tool": "Write", "path": "*.ts" },
        "command": "npx eslint --fix $TOOL_INPUT_PATH"
      },
      {
        "matcher": { "tool": "Write", "path": "*.tsx" },
        "command": "npx eslint --fix $TOOL_INPUT_PATH"
      },
      {
        "matcher": { "tool": "Write", "path": "*.py" },
        "command": "ruff format $TOOL_INPUT_PATH"
      }
    ]
  }
}
```

### Pre-Commit Validation

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": { "tool": "Bash", "command": "git commit*" },
        "command": "npm run lint && npm test"
      }
    ]
  }
}
```

### Block Dangerous Commands

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": { "tool": "Bash" },
        "command": "echo $TOOL_INPUT | grep -qE '(rm -rf /|curl.*\\|.*sh)' && exit 1 || exit 0"
      }
    ]
  }
}
```

**Tutorial:** https://github.com/disler/claude-code-hooks-mastery

---

## CLAUDE.md Templates

Project memory files persist context across sessions.

### Template Collections

| Resource | Description | Stars |
|----------|-------------|-------|
| [claude-code-showcase](https://github.com/ChrisWiles/claude-code-showcase) | Complete production config | 3.8k |
| [claude-code-templates](https://github.com/davila7/claude-code-templates) | CLI with 100+ templates | - |
| [claude-flow templates](https://github.com/ruvnet/claude-flow/wiki/CLAUDE-MD-Templates) | Framework-specific | - |

### Quick Template Installation

```bash
# Interactive mode
npx claude-code-templates@latest

# Specific template
npx claude-code-templates@latest --template nextjs-typescript --yes
```

### Example: Next.js Project

```markdown
# Project: [App Name]

## Tech Stack
- Next.js 15 (App Router)
- TypeScript 5.x strict mode
- TailwindCSS 4.x
- Drizzle ORM + PostgreSQL
- Vercel deployment

## Directory Structure
- `app/` - Routes and layouts
- `components/` - React components
- `lib/` - Utilities and helpers
- `db/` - Database schema and queries

## Commands
- `pnpm dev` - Start dev server (Turbopack)
- `pnpm build` - Production build
- `pnpm db:push` - Push schema changes
- `pnpm db:studio` - Open Drizzle Studio

## Conventions
- Use Server Components by default
- Client Components in `components/client/`
- API routes in `app/api/`
- Prefer Zod for validation
- Use conventional commits
```

### Example: Python FastAPI Project

```markdown
# Project: [API Name]

## Tech Stack
- Python 3.12+
- FastAPI + Uvicorn
- SQLAlchemy 2.0 + Alembic
- PostgreSQL
- Docker + Docker Compose

## Directory Structure
- `app/` - Application code
- `app/api/` - Route handlers
- `app/models/` - SQLAlchemy models
- `app/schemas/` - Pydantic schemas
- `tests/` - Pytest tests

## Commands
- `uv run dev` - Start dev server
- `uv run test` - Run tests
- `uv run lint` - Run ruff
- `alembic upgrade head` - Run migrations

## Conventions
- Type hints required everywhere
- Async by default
- Dependency injection via FastAPI
- Repository pattern for data access
```

---

## Community Resources

### Essential Links

| Resource | Description | Stats |
|----------|-------------|-------|
| [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | Curated everything list | 16.9k stars |
| [r/ClaudeCode](https://reddit.com/r/ClaudeCode) | Reddit community | 49k members |
| [SkillsMP.com](https://skillsmp.com) | Skills marketplace | 71k+ skills |
| [MCP Registry](https://registry.modelcontextprotocol.io) | Official MCP registry | Official |

### GitHub Topics

Search these topics for more resources:
- `claude-code` - Primary topic
- `claude-code-skills` - Skills repositories
- `claude-code-commands` - Command collections
- `mcp-server` - MCP servers

### Learning Resources

| Resource | Type |
|----------|------|
| [Anthropic Best Practices](https://anthropic.com/engineering/claude-code-best-practices) | Official Guide |
| [claude-code-hooks-mastery](https://github.com/disler/claude-code-hooks-mastery) | Tutorial |
| [ykdojo/claude-code-tips](https://github.com/ykdojo/claude-code-tips) | 40+ Tips |

### Tools

| Tool | Description |
|------|-------------|
| [Claude Squad](https://github.com/smtg-ai/claude-squad) | Run multiple agents in parallel |
| [ccusage](https://github.com/ryoppippi/ccusage) | Token usage analytics |
| [Container Use](https://github.com/dagger/container-use) | Sandboxed agent environments |

---

## Top 30 Resources Ranked

| Rank | Resource | Category | Stars | Install |
|------|----------|----------|-------|---------|
| 1 | BMAD Method | Workflow | 32.9k | `npx bmad-method install` |
| 2 | SuperClaude | Workflow | 20.5k | `pipx install superclaude` |
| 3 | awesome-claude-code | List | 16.9k | Browse |
| 4 | claude-flow | Agents | 12.8k | `npm install -g claude-flow` |
| 5 | awesome-mcp-servers | MCP | 11k | Browse |
| 6 | VoltAgent/subagents | Agents | 6.2k | Clone to ~/.claude/agents |
| 7 | CCPM | Workflow | 6.1k | `curl -sSL .../install \| bash` |
| 8 | GitHub MCP | MCP | Official | `claude mcp add --transport http github ...` |
| 9 | Playwright MCP | MCP | 25.9k | `claude mcp add playwright -- npx ...` |
| 10 | claude-code-showcase | Template | 3.8k | Clone and customize |
| 11 | wshobson/commands | Commands | 1.2k | `/plugin install ...` |
| 12 | anthropics/skills | Skills | Official | Clone to ~/.claude/skills |
| 13 | cc-devops-skills | Skills | 31 skills | Clone to ~/.claude/skills |
| 14 | VoltAgent/agent-skills | Skills | 200+ | `npx ai-agent-skills install` |
| 15 | claude-code-templates | Template | CLI | `npx claude-code-templates@latest` |
| 16 | everything-claude-code | Config | Winner | Add to marketplace |
| 17 | Notion MCP | MCP | Official | `claude mcp add --transport http notion ...` |
| 18 | Memory Server | MCP | Official | `claude mcp add memory -- npx ...` |
| 19 | trailofbits/skills | Skills | Security | Clone to ~/.claude/skills |
| 20 | claudekit | Commands | 20+ | `/plugin install ...` |
| 21 | Sentry MCP | MCP | Official | `claude mcp add --transport http sentry ...` |
| 22 | DBHub | MCP | DB | `claude mcp add db -- npx ...` |
| 23 | hooks-mastery | Hooks | Tutorial | Clone and learn |
| 24 | Claude-Command-Suite | Commands | 148+ | Clone to ~/.claude/commands |
| 25 | Simone | Workflow | 519 | See docs |
| 26 | wshobson/agents | Agents | 108 | Clone to ~/.claude/agents |
| 27 | AWS MCP | MCP | Official | See github.com/awslabs/mcp |
| 28 | Cloudflare MCP | MCP | Official | See GitHub |
| 29 | SkillsMP.com | Skills | 71k+ | Browse marketplace |
| 30 | r/ClaudeCode | Community | 49k | Join discussions |

---

## Quick Reference

### Built-in Subagents

| Agent | Purpose | Context |
|-------|---------|---------|
| `Explore` | Read-only codebase research | Isolated |
| `Plan` | Create implementation plans | Isolated |
| `general-purpose` | Full tool access | Forked |

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

```bash
# Increase skill budget
export SLASH_COMMAND_TOOL_CHAR_BUDGET=30000

# Enable extended thinking
# Add "ultrathink" anywhere in skill content
```

### Directory Setup Script

```bash
# Create Claude Code directories
mkdir -p ~/.claude/{commands,skills,agents}

echo "Directories created:"
echo "  ~/.claude/commands/ - Custom slash commands"
echo "  ~/.claude/skills/   - Auto-invoked skills"
echo "  ~/.claude/agents/   - Custom subagents"
```

---

## Learn More

- **Official Docs:** https://docs.anthropic.com/claude-code
- **Best Practices:** https://anthropic.com/engineering/claude-code-best-practices
- **Skills Docs:** https://code.claude.com/docs/en/skills
- **MCP Registry:** https://registry.modelcontextprotocol.io
- **Awesome List:** https://github.com/hesreallyhim/awesome-claude-code
