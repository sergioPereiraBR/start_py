artifact=start_py
python_version=3.10.11
TEST_TARGET = tests\test_app.py
POETRY = poetry run
FLAKE8_FLAGS = --ignore=W503,E501
ISORT_FLAGS = --profile=black --lines-after-import=2
help = scripts
limpa = Get-ChildItem -Path .\ -include __pycache__ -filter __pycache__.* -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force
tes = .

ifneq (,$(wildcard .\poetry.lock))
all: verify
else
all: project
endif

project: poetry.lock verify help

verify: doc	analytic format lint test sec app

app: app.py
	python app.py
	@echo ${tes}

poetry.lock: install update_toml quit_vscode

quit_vscode:
	poetry shell

## @ instalcao
install: .git python pyproject.toml ## instala dependencias usando poetry.
	poetry add rich
	@echo ${tes}
	poetry add --group test pytest
	poetry add --group test pytest-coverage
	@echo ${tes}
	poetry add --group dev blue
	poetry add --group dev isort
	poetry add --group dev mypy
	poetry add --group dev pip-audit
	poetry add --group dev taskipy
	@echo ${tes}
	poetry add --group doc mkdocs
	poetry add --group doc mkdocs-macros-plugin
	poetry add --group doc mkdocs-material
	poetry add --group doc mkdocs_pymdownx_material_extras
	poetry add --group doc mkdocstrings
	poetry add --group doc mkdocstrings-python
	
## @ python
python: ## Altera a versao do python
	pyenv install $(python_version)
	@echo ${tes}
	pyenv local $(python_version)
	@echo ${tes}
	poetry env use $(python_version)
	poetry config virtualenvs.prefer-active-python true
	poetry config virtualenvs.in-project true
	poetry install
	@echo ${tes}

.git:
	git init .
	@echo ${tes}
	
pyproject.toml:
	poetry init
	@echo ${tes}
	poetry install
	@echo ${tes}

## @ start
start: ## start do ambiente virtual
	@echo ${tes}

doc: mkdocs.yml docs\assets docs\stylesheets docs\api
	
mkdocs.yml:
	@echo mkdocs
	mkdocs new .
	copy ".\scripts\mkdocs.yml" ".\mkdocs.yml"
	copy ".\scripts\index.md" ".\docs\index.md"
	del ".\scripts\mkdocs.yml"
	del ".\scripts\index.md"

docs\assets:
	@echo docs\assets
	md docs\assets
	copy ".\assets\image\logo.png" ".\docs\assets\logo.png"

docs\stylesheets:
	@echo docs\stylesheets
	md docs\stylesheets
	copy ".\scripts\extra.css" ".\docs\stylesheets\extra.css"
	del ".\scripts\extra.css"
	
docs\api:
	@echo docs\api
	md docs\api
	copy ".\scripts\src.md" ".\docs\api\src.md"
	copy ".\scripts\help.md" ".\docs\api\help.md"
	del ".\scripts\src.md"
	del ".\scripts\help.md"

update_toml:
	md .\temp
	copy "pyproject.toml" ".\temp\a.txt"
	copy ".\scripts\toml.toml" ".\temp\b.txt"
	copy ".\temp\*.txt" ".\pyproject.toml"
	rd /q /s .\temp
	del ".\scripts\toml.toml"
	@echo ${tes}

## @ analise
analytic: lint_mypy lint_isort ## analise estatica do codigo da aplicacao

## @ lint mypy
lint_mypy: ## analise pelo mypy
	@echo mypy
	$(POETRY) mypy .
	@echo ${tes}

## @ lint isort
lint_isort: ## analisa as ordens dos imports
	@echo isort
	$(POETRY) isort . ${ISORT_FLAGS} --check --diff
	@echo ${tes}

## @ formatacao
format: ## analise da formatacao do codigo da aplicacao
	@echo ${tes}
	@echo blue
	$(POETRY) blue .
	@echo isort
	$(POETRY) isort ${ISORT_FLAGS} .
	@echo ${tes}

## @ tipagem
lint: ## verificacao da tipagem 
	@echo blue
	$(POETRY) blue . --check --diff
	@echo isort
	$(POETRY) isort . ${ISORT_FLAGS} --check --diff
	@echo ${tes}
# $(POETRY) prospector . --with-tool pep257 --dic-warning
# @echo ${tes}

## @ teste
test: ## analise dinamica
	@echo pytest
	$(POETRY) pytest -v
	@echo coverage
	$(POETRY) pytest --cov=. --cov-report=html

## @ seguranca
sec: ## verifica vunerabilidades nas dependencias
	@echo pip-audit
	@echo ${tes}

## @ atualiza kanban
update_kanban: .\.kanbn\index.md remove_kanban ## atualiza os arquivos do kanban no mkdocs
	xcopy ".\.kanbn\." ".\docs\work_process" /s /i

remove_kanban:
	RD /s /q ".\docs\work_process"

## @ limpeza do pycache
clean: ## deleta oas arquivos __pycache__ 
	@echo clean
	$(limpa)
	@echo ${tes}

## @ ajuda 
help: ## ajuda sobre os comandos das diretrizes no make
	$(POETRY) python $(help)\help.py
	@echo ${tes}
