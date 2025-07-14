# Secret Emotion

**Secret Emotion** is a narrative-driven project built using [Godot Engine](https://godotengine.org/) **v4.4.1-stable**.
This repository includes development tooling such as Git hooks, linters, and formatters to enforce clean GDScript code.

---

## 📁 Project Structure

| File/Folder               | Description                                                        |
| ------------------------- | ------------------------------------------------------------------ |
| `.github/`                | GitHub configuration — contains Actions workflows, etc.            |
| `.godot/`                 | Godot editor state — can be ignored for version control.           |
| `.editorconfig`           | Shared editor configuration (e.g., indent style, size).            |
| `.gitattributes`          | Git settings for text normalization and merge behavior.            |
| `.gitignore`              | Specifies intentionally untracked files to ignore in Git.          |
| `.pre-commit-config.yaml` | Configuration for pre-commit hooks (e.g., linting and formatting). |
| `.python-version`         | Pyenv-local Python version for this project (optional).            |
| `icon.svg`                | Project icon for Godot editor display.                             |
| `icon.svg.import`         | Auto-generated import metadata for the `icon.svg` asset.           |
| `project.godot`           | The main configuration file for your Godot project.                |
| `README.md`               | Project overview, setup instructions, and tooling documentation.   |

---

## 🔧 GDScript Linting & Formatting (via Git Hooks)

This section guides you through setting up Python-based [pre-commit](https://pre-commit.com/) hooks using [gdtoolkit](https://github.com/Scony/godot-gdscript-toolkit).

### ✅ Requirements

* Ubuntu
* Git
* Python (installed via `pyenv` for isolation)

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
	rev: 4.2.2
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

* `gdparse` – Parses GDScript into an AST.
* `gdradon` – Calculates cyclomatic complexity.

More tools and details: [Scony/godot-gdscript-toolkit](https://github.com/Scony/godot-gdscript-toolkit)
