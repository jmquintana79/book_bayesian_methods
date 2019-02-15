.PHONY: clean install remove

## GLOBALS ##

ifeq (,$(shell which conda))
HAS_CONDA=False
else
HAS_CONDA=True
ACT=$(shell which activate)
PY=$(shell which python)
endif

## COMMANDS ##

## Default
default:
	@echo "Options:"
	@echo "    make clean      # Delete all compiled Python files and unnecessary files."
	@echo "    make install    # Install libraries and create the conda environment 'bayes'."
	@echo "    make remove     # Remove libraries and clean del folder."
	@echo ""
	@echo ${PY}

## delete all compiled Python files
clean:
	find . -name "*.pyc" -exec rm {} \;
	find . -name "__pycache__" -exec rmdir {} \;

## set up python interpreter environment
install:
ifeq (True,$(HAS_CONDA))
	@echo ">>> Detected conda, creating conda environment."
	conda env create -f environment.yml
	@echo ">>> done."
else
	@echo ">>> Conda is not available."
endif

## set up python interpreter environment
remove:
ifeq (True,$(HAS_CONDA))
	@echo ">>> Detected conda, removing the conda environment."
	conda remove --name bayes --all
	@echo ">>> done."
else
	@echo ">>> Conda is not available."
endif
