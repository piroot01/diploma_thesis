# Builds the documents with tectonic. Each src/<doc>/main.tex becomes out/<doc>/main.pdf.

TECTONIC ?= tectonic
SRC_DIR := src
OUT_DIR := out

DOCS := $(patsubst $(SRC_DIR)/%/main.tex,%,$(wildcard $(SRC_DIR)/*/main.tex))

.PHONY: all clean $(DOCS)
.SECONDEXPANSION:

all: $(DOCS)

$(DOCS): %: $(OUT_DIR)/%/main.pdf

$(OUT_DIR)/%/main.pdf: $(SRC_DIR)/%/main.tex $$(shell find $(SRC_DIR)/$$* -type f)
	@mkdir -p $(@D)
	$(TECTONIC) -X compile $< --outdir $(@D) --keep-logs

clean:
	rm -rf $(OUT_DIR)
