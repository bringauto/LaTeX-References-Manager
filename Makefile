TMP_DIR := _tmp
MAKEFILE_COMMON := Makefile.common
REFERENCES = references.tex
REFERENCES_CONFIG = references_config.tex
REFERENCES_LIB = references_lib
EXAMPLE = example
LIB_PATH = latex-references-manager/
INIT_DIR = ../

init_manager:
	echo "Initializing library"
	ln -sf $(LIB_PATH)$(MAKEFILE_COMMON) $(INIT_DIR)$(MAKEFILE_COMMON)
	ln -sf $(LIB_PATH)$(REFERENCES) $(INIT_DIR)$(REFERENCES)
	ln -sf $(LIB_PATH)$(REFERENCES_CONFIG) $(INIT_DIR)$(REFERENCES_CONFIG)
	ln -sf $(LIB_PATH)$(REFERENCES_LIB) $(INIT_DIR)$(REFERENCES_LIB)
	ln -sf $(LIB_PATH)$(EXAMPLE) $(INIT_DIR)$(EXAMPLE)

