# Secret Emotion

**Secret Emotion** is a narrative-driven project built using [Godot Engine](https://godotengine.org/) **v4.4.1-stable**.
This repository includes development tooling such as Git hooks, linters, and formatters to enforce clean GDScript code.

---

## 📁 Project Structure

```text
project-root/
├── .github/                   # GitHub configuration — Actions workflows, templates, etc.
├── .godot/                    # Godot editor state (safe to ignore in VCS)
├── .editorconfig              # Shared editor settings (indentation, charset, …)
├── .gitattributes             # Text‑file normalization & merge rules
├── .gitignore                 # Files/directories Git should ignore
├── .pre-commit-config.yaml    # Linting / formatting hooks
├── .python-version            # Local Python version for githooks & tooling
│
├── project.godot              # The main configuration file for your Godot project
├── icon.svg                   # Project icon shown in the Godot launcher
├── icon.svg.import            # Import metadata for the icon asset (*.import are ignored in VCS)
├── README.md                  # Project overview & setup guide
│
└── source/                    # **All game content lives here**
	├── player/                # Player domain (example below)
	└── …                      # Additional domains (enemies/, ui/, levels/, …)
```

### ▶️ `source/player/`

```text
player/
├── assets/                    # Raw art / audio (.png, .wav, ...)
│   ├── sprite.png
│   └── dash_sound.wav
│
├── scenes/                    # Packed Godot scenes (.tscn)
│   ├── Player.tscn            # Main player scene
│   └── DashEffect.tscn        # Dash VFX
│
├── scripts/                   # GDScript sources (.gd)
│   ├── player.gd              # Core movement & input
│   ├── player_state.gd        # State‑machine logic
│   └── player_attack.gd       # Combat behaviours
│
└── resources/                 # Data‑only assets (.tres)
	└── player_stats.tres      # Tunable stats (speed, health, …)
```

---

## Naming convention

| Type         | Convention      | Example                     |
| ------------ | --------------- | --------------------------- |
| File names   | `snake_case`    | `yaml_parser.gd`            |
| Class names  | `PascalCase`    | `class_name YAMLParser`     |
| Node names   | `PascalCase`    | `Camera3D`, `Player`        |
| Functions    | `snake_case`    | `func load_level():`        |
| Variables    | `snake_case`    | `var particle_effect`       |
| Signals      | `snake_case`    | `signal door_opened`        |
| Constants    | `CONSTANT_CASE` | `const MAX_SPEED = 200`     |
| Enum names   | `PascalCase`    | `enum Element`              |
| Enum members | `CONSTANT_CASE` | `{EARTH, WATER, AIR, FIRE}` |

---

## Code order

```text
01. @tool, @icon, @static_unload
02. class_name
03. extends
04. ## doc comment

05. signals
06. enums
07. constants
08. static variables
09. @export variables
10. remaining regular variables
11. @onready variables

12. _static_init()
13. remaining static methods
14. overridden built-in virtual methods:
	1. _init()
	2. _enter_tree()
	3. _ready()
	4. _process()
	5. _physics_process()
	6. remaining virtual methods
15. overridden custom methods
16. remaining methods
17. subclasses
```

And put the class methods and variables in the following order depending on their access modifiers:

```text
1. public
2. private
```

This code order follows four rules of thumb:

1. Properties and signals come first, followed by methods.
2. Public comes before private.
3. Virtual callbacks come before the class's interface.
4. The object's construction and initialization functions, \_init and \_ready, come before functions that modify the object at runtime.

---

## 🔧 GDScript Linting & Formatting (via Git Hooks)

Formatting and Linting are delegated to [gdtoolkit](https://github.com/Scony/godot-gdscript-toolkit).

This section guides you through setting up Python-based [pre-commit](https://pre-commit.com/) hooks using [gdtoolkit](https://github.com/Scony/godot-gdscript-toolkit).

### ✅ Requirements

- Ubuntu
- Git
- Python (installed via `pyenv` for isolation)

---

### 1. 📆 Install `pyenv`

```bash
curl -fsSL https://pyenv.run | bash
```

---

### 2. 🖠️ Update Shell Configuration

Add the following to both `~/.bashrc` and `~/.profile`:

```bash
# >>> pyenv setup >>>
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
eval "$(pyenv virtualenv-init -)"
# <<< pyenv setup <<<
```

Then reload:

```bash
exec "$SHELL"
```

---

### 3. 📥 Install Python & Dependencies

Install build dependencies:

```bash
sudo apt update
sudo apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
libffi-dev liblzma-dev
```

Install Python:

```bash
pyenv install 3.12.11
pyenv global 3.12.11
```

Verify installation:

```bash
python --version     # Python 3.12.11
which python         # ~/.pyenv/shims/python
```

---

### 4. 🪄 Set Up Project Virtual Environment

```bash
cd ~/path/to/this/project/root/secret-emotion
pyenv virtualenv 3.12.11 secret-emotion-env
pyenv local secret-emotion-env
```

This creates a `.python-version` file and auto-activates the environment in this project directory.

---

### 5. 📦 Install Tooling

```bash
pip install gdtoolkit pre-commit
```

---

### 6. 🗒️ Add `.pre-commit-config.yaml`

Create this file at the project root:

```yaml
repos:
  # GDScript Toolkit
  - repo: https://github.com/Scony/godot-gdscript-toolkit
	rev: 4.3.4
	hooks:
	  - id: gdlint
		name: gdlint
		description: "gdlint - linter for GDScript"
		entry: gdlint
		language: python
		language_version: python3
		require_serial: true
		types: [gdscript]
		additional_dependencies: [setuptools]
	  - id: gdformat
		name: gdformat
		description: "gdformat - formatter for GDScript"
		entry: gdformat
		language: python
		language_version: python3
		require_serial: true
		types: [gdscript]
		additional_dependencies: [setuptools]
```

---

### 7. 🔌 Install the Hook

```bash
pre-commit install
pre-commit run --all-files
```

Now every `git commit` will auto-format and lint your `.gd` files.

---

## 🤖 CI: GitHub Actions

To enforce formatting/linting on pull requests, add this workflow:

### `.github/workflows/static-checks.yml`

```yaml
name: Static checks

on:
  push:
	branches: [ "main" ]
  pull_request:
	branches: [ "main" ]

jobs:
  static-checks:
	name: 'Static checks'
	runs-on: ubuntu-latest
	steps:
	- uses: actions/checkout@v4
	- uses: Scony/godot-gdscript-toolkit@master
	- run: gdformat --check source/
	- run: gdlint source/
```

---

## 🧪 Example

### Bad Code:

```gdscript
extends Node

func movePlayer(aPos, aSpeed):
	print("Moving to", aPos, "with speed", aSpeed)
```

```bash
$ gdlint test.gd
test.gd:3: Error: Function name "movePlayer" is not valid (function-name)
test.gd:3: Error: Function argument name "aPos" is not valid (function-argument-name)
test.gd:3: Error: Function argument name "aSpeed" is not valid (function-argument-name)
```

### Formatter Output:

Before:

```gdscript
class X:
	var x=[1,2,{'a':1}]
	var y=[1,2,3,]     # trailing comma
	func foo(a:int,b,c=[1,2,3]):
		if a in c and \
		   b > 100:
			print('foo')
func bar():
	print('bar')
```

```bash
$ gdformat test.gd
reformatted test.gd
1 file reformatted, 0 files left unchanged.
```

After:

```gdscript
class X:
	var x = [1, 2, {"a": 1}]
	var y = [
		1,
		2,
		3,
	]  # trailing comma

	func foo(a: int, b, c = [1, 2, 3]):
		if a in c and b > 100:
			print("foo")


func bar():
	print("bar")
```

---

## 🛠️ Extra Tools

- `gdparse` – Parses GDScript into an AST.
- `gdradon` – Calculates cyclomatic complexity.

More tools and details: [Scony/godot-gdscript-toolkit](https://github.com/Scony/godot-gdscript-toolkit)
