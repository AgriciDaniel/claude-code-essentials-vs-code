# Claude Code Complete Guide

## Requirements

- Node.js 18+
- Anthropic account (Claude Pro, Max, Teams, or API)

## Installation

### CLI (Terminal)

```powershell
npm install -g @anthropic-ai/claude-code
```

### VS Code Extension (Beta) ⭐ NEW

```powershell
code --install-extension anthropic.claude-code
```

Or search "Claude Code" in VS Code Extensions (Anthropic publisher).

**VS Code Extension Features:**
- Native sidebar panel (Spark icon ✨)
- Plan mode with editing
- Auto-accept edits mode
- File @-mentions and image support
- Multiple simultaneous sessions
- Real-time inline diffs

> Requires VS Code 1.98.0+

## First Run

```powershell
claude
```

Login on first use.

---

## Skip Permission Prompts (Optional)

### Method 1: PowerShell Profile (Recommended)

```powershell
notepad $PROFILE

# Add:
function claude { & "C:\Users\$env:USERNAME\AppData\Roaming\npm\claude.cmd" --dangerously-skip-permissions $args }

# Save, restart terminal
```

### Method 2: Run with Flag

```powershell
claude --dangerously-skip-permissions
```

---

## Built-in Slash Commands

| Command | Description |
|---------|-------------|
| `/help` | Show all commands |
| `/config` | Open settings |
| `/permissions` | Manage permissions |
| `/context` | Check context usage |
| `/compact` | Compress conversation |
| `/clear` | Clear conversation |
| `/plugin` | Manage plugins |
| `/mcp` | Manage MCP servers |
| `/model` | Switch models |
| `/cost` | Show session cost |
| `/memory` | View/edit memory |
| `/ide` | Connect to IDE |
| `/rewind` | Go back to previous state |

---

## Memory & Context

### Memory File
Claude Code stores learned preferences in memory. Access with `/memory`.

```powershell
# Add to memory during chat
# Use # at start of message to save to memory
# my preferred language is TypeScript
```

### Model Selection

```powershell
# Switch models during session
/model

# Available models (Claude 4.5 Series):
# - claude-sonnet-4-5 (default) - Best coding model
# - claude-opus-4-5 - Most capable, complex reasoning
# - claude-haiku-4-5 - Fastest, cost-effective
```

**Model Comparison:**
| Model | Best For | Speed |
|-------|----------|-------|
| Sonnet 4.5 | Coding, agents, daily tasks | Fast |
| Opus 4.5 | Complex reasoning, research | Moderate |
| Haiku 4.5 | Quick tasks, cost-sensitive | Fastest |

### Extended Thinking (Hybrid Reasoning)

All Claude 4.5 models support hybrid reasoning with two modes:
- **Instant responses** - Quick answers for simple tasks
- **Extended thinking** - Deep reasoning for complex problems

Add "ultrathink" anywhere in a skill to enable deep reasoning:

```markdown
---
name: complex-analysis
description: Deep code analysis with ultrathink
---
Perform thorough analysis using extended thinking...
```

---

## CLI Flags

| Flag | Description |
|------|-------------|
| `--version` | Check version |
| `--resume` | Resume last session |
| `-p "prompt"` | Run with prompt (headless) |
| `--output-format json` | JSON output |
| `--mcp-debug` | Debug MCP issues |
| `--dangerously-skip-permissions` | Bypass prompts |

---

## CLAUDE.md (Project Memory)

Create `CLAUDE.md` in your project root:

```markdown
# Project: MyApp

## Tech Stack
- Next.js 14, TypeScript, TailwindCSS
- PostgreSQL with Prisma
- Deployed on Vercel

## Coding Standards
- TypeScript strict mode
- ESLint + Prettier
- Tests required for all functions

## Commands
- `npm run dev` - Start dev server
- `npm run test` - Run tests
- `npm run lint` - Lint code
```

---

## Custom Slash Commands

Create `.claude/commands/your-command.md`:

```markdown
---
description: Fix a GitHub issue
---
Analyze and fix GitHub issue: $ARGUMENTS

1. Use `gh issue view $ARGUMENTS` to get details
2. Search codebase for relevant files
3. Implement fix
4. Write tests
5. Commit changes
```

Usage: `/your-command 123`

---

## Skills (Auto-Invoked)

Create `.claude/skills/my-skill/SKILL.md`:

```markdown
---
name: code-review
description: Review code for best practices
---
When reviewing code:
1. Check for security issues
2. Verify error handling
3. Ensure proper typing
4. Suggest improvements
```

Skills auto-activate when description matches the task.

---

## Subagents

Built-in agents for parallel/isolated work:

| Agent | Purpose |
|-------|---------|
| `Explore` | Read-only codebase exploration |
| `Plan` | Create implementation plans |
| `general-purpose` | Full tool access |

Use in skills with `context: fork`:

```markdown
---
name: research
description: Deep research
context: fork
agent: Explore
---
Research $ARGUMENTS thoroughly...
```

---

## MCP Servers (External Tools)

```powershell
# Add MCP server
claude mcp add github npx @anthropic-ai/mcp-server-github

# List servers
claude mcp list

# Remove server
claude mcp remove github
```

Popular MCP servers:
- `@anthropic-ai/mcp-server-github` - GitHub integration
- `@anthropic-ai/mcp-server-filesystem` - File access
- `@anthropic-ai/mcp-server-puppeteer` - Browser automation
- `@anthropic-ai/mcp-server-postgres` - Database access

---

## Plugins

```powershell
# Install plugin
/plugin install https://github.com/user/plugin

# List plugins
/plugin list

# Remove plugin
/plugin remove plugin-name
```

---

## Hooks (Automation)

Create `.claude/hooks/pre-commit.md`:

```markdown
---
trigger: pre-commit
---
Before committing:
1. Run linter
2. Run tests
3. Check for console.logs
```

---

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `Ctrl+C` | Cancel current action |
| `Ctrl+B` | Send agent to background |
| `Esc` | Exit |
| `Tab` | Autocomplete |
| `↑/↓` | History navigation |

---

## Headless Mode (CI/Automation)

```powershell
# Run single task
claude -p "fix all lint errors" --output-format json

# In CI pipeline
claude -p "run tests and report" --dangerously-skip-permissions
```

---

## Best Practices

1. **Start with CLAUDE.md** - Give project context
2. **Use /compact** - When context gets large
3. **Create slash commands** - For repeated workflows
4. **Use subagents** - For parallel/isolated tasks
5. **Check /context** - Monitor token usage
6. **Use MCP** - For external integrations

---

## Update

```powershell
npm update -g @anthropic-ai/claude-code
```

## Verify

```powershell
claude --version
```

---

## Resources

- Docs: https://docs.anthropic.com/claude-code
- Best Practices: https://anthropic.com/engineering/claude-code-best-practices
- Awesome List: https://github.com/hesreallyhim/awesome-claude-code

---

## Settings Location

Claude Code settings are stored in:

```
# Global settings
~/.claude/settings.json

# Project settings
.claude/settings.json
```

Example settings.json:
```json
{
  "permissions": {
    "allow": ["Read", "Write", "Bash(npm *)"],
    "deny": ["Bash(rm -rf *)"]
  },
  "env": {
    "NODE_ENV": "development"
  }
}
```

---

## Troubleshooting

### Claude Code Not Responding
1. Check internet connection
2. Verify login: `claude --version`
3. Clear cache: `rm -rf ~/.claude/cache`
4. Restart terminal

### Extension Not Working in VS Code
1. Ensure VS Code 1.98.0+
2. Reload window: `Ctrl+Shift+P` → "Reload Window"
3. Check for extension updates

### Permission Denied Errors
```powershell
# Grant permissions
/permissions

# Or use flag
claude --dangerously-skip-permissions
```

### MCP Server Issues
```powershell
# Debug mode
claude --mcp-debug

# Check server status
claude mcp list
```

### High Token Usage
- Use `/compact` to compress history
- Check `/context` for usage
- Start fresh with `/clear`
