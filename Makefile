# ──────────────────────────────────────────────────────────────────────────────
# SPDX-FileCopyrightText: 2026 farawayisland
# SPDX-License-Identifier: GPL-3.0-or-later
# ──────────────────────────────────────────────────────────────────────────────
#
# This file is part of the "`frwyslnd` bundle". The development version of
# the bundle can be found at
#
#   https://codeberg.org/farawayisland/frwyslnd.latex
#   https://github.com/farawayisland/frwyslnd.latex
#
# for those people who are interested.
#
# ──────────────────────────────────────────────────────────────────────────────
# PROJECT DEPENDENCIES
## TeX distribution.
### MacTeX (macOS):
### `brew install --cask mactex-no-gui`.

### MikTeX (Windows):
### `winget install -e --id MiKTeX.MiKTeX`.

### TeX Live:
### https://tug.org/texlive/quickinstall.html
# ──────────────────────────────────────────────────────────────────────────────
# VARIABLES
## OS checks.
ifeq ($(OS),Windows_NT)
  ifeq '$(findstring ;,$(PATH))' ';'
    UNIX_LIKE := FALSE
  else
    UNIX_LIKE := TRUE
  endif
else
  UNIX_LIKE := TRUE
endif

## Bundle-related.
BUNDLE_NAME := frwyslnd
BUNDLE_TEX_FORMAT := latex

## Directories.
### Project-related.
DIR_SRC := .
DIR_BUILD := $(DIR_SRC)/build
DIR_CLS := $(DIR_SRC)/cls
DIR_PKG := $(DIR_SRC)/pkg

### TDS-compliant.
DIR_TEXMF := $(DIR_SRC)/../../..
DIR_DOC := $(DIR_TEXMF)/doc/$(BUNDLE_TEX_FORMAT)/$(BUNDLE_NAME)
DIR_TEX := $(DIR_TEXMF)/tex/$(BUNDLE_TEX_FORMAT)/$(BUNDLE_NAME)

### `util` package.
DIR_UTIL := $(DIR_PKG)/util

## File stems.
### `util` package.
STEM_UTIL := $(BUNDLE_NAME)-util

## File basenames.
### `util` package.
BASENAME_DTX_UTIL := $(STEM_UTIL).dtx
BASENAME_INS_UTIL := $(STEM_UTIL).ins
BASENAME_PDF_UTIL := $(STEM_UTIL).pdf
BASENAME_STY_UTIL := $(STEM_UTIL).sty

## Package-related files.
### `util` package.
DTX_UTIL := $(DIR_UTIL)/$(BASENAME_DTX_UTIL)
INS_UTIL := $(DIR_UTIL)/$(BASENAME_INS_UTIL)
STY_UTIL := $(DIR_TEX)/$(BASENAME_STY_UTIL)
STY_UTIL_COPY := $(DIR_UTIL)/$(BASENAME_STY_UTIL)
__DTX_UTIL := $(DIR_BUILD)/$(BASENAME_DTX_UTIL)
__INS_UTIL := $(DIR_BUILD)/$(BASENAME_INS_UTIL)
__STY_UTIL := $(DIR_BUILD)/$(BASENAME_STY_UTIL)

## Documentation-related files.
### `util` package.
PDF_UTIL := $(DIR_DOC)/$(BASENAME_PDF_UTIL)
__PDF_UTIL := $(DIR_BUILD)/$(BASENAME_PDF_UTIL)

## Lists.
### By extension.
#### Unquoted.
LIST_DTX := $(DTX_UTIL)
LIST_INS := $(INS_UTIL)
LIST_PDF := $(PDF_UTIL)
LIST_STY := $(STY_UTIL)

#### Quoted.
LIST_QUOTED_DTX := "$(DTX_UTIL)"
LIST_QUOTED_INS := "$(INS_UTIL)"
LIST_QUOTED_PDF := "$(PDF_UTIL)"
LIST_QUOTED_STY := "$(STY_UTIL)" \
                   "$(STY_UTIL_COPY)"

### `util` package.
#### Unquoted.
LIST_UTIL := $(INS_UTIL) \
             $(STY_UTIL)
__LIST_UTIL := $(__INS_UTIL) \
               $(__STY_UTIL)

#### Quoted.
LIST_QUOTED_UTIL := "$(INS_UTIL)" \
                    "$(STY_UTIL)"
__LIST_QUOTED_UTIL := "$(__INS_UTIL)" \
                      "$(__STY_UTIL)"


## Shell commands and executables.
### Non-OS-specific.
LUATEX := luatex --file-line-error --interaction=nonstopmode --output-directory="$(DIR_BUILD)"
LUALATEX := latexmk -lualatex -file-line-error -interaction=nonstopmode -synctex=1

### OS-specific.
ifeq ($(UNIX_LIKE),FALSE)
  SHELL := powershell.exe
  .SHELLFLAGS := -NoProfile -NoLogo
  CD := set-location
  CP := copy-item -force
  DIRNAME := split-path
  ECHO := write-output
  MKDIR := @$$null = new-item -force -itemtype directory
  MV := move-item -force
  REALPATH := resolve-path
  RM := remove-item -force
  define rmdir
    if (Test-Path $1) { remove-item -recurse $1 }
  endef
  TOUCH := @$$null = new-item -force
else
  CD := cd
  CP := cp -f
  DIRNAME := dirname
  ECHO := printf '%s\n'
  MKDIR := mkdir -p
  MV := mv -f
  REALPATH := realpath
  RM := rm -fr
  define rmdir
    rm -fr $1
  endef
  TOUCH := touch
endif
# ──────────────────────────────────────────────────────────────────────────────
# TARGETS
## Phony targets.
.PHONY: all \
        all-with-doc \
        clean \
        util \
        util-with-doc

all-with-doc: $(LIST_PDF) $(LIST_STY)

all: $(LIST_STY)

clean:
	-$(call rmdir, "$(DIR_BUILD)")
	-$(call rmdir, "$(DIR_DOC)")
	-$(RM) $(LIST_QUOTED_INS) $(LIST_QUOTED_STY)

util: $(STY_UTIL)

util-with-doc: $(PDF_UTIL) $(STY_UTIL)

## `util` package.
$(INS_UTIL): $(DTX_UTIL)
	$(MKDIR) "$(DIR_BUILD)"
	$(LUATEX) "$(DTX_UTIL)"
	$(MV) "$(__INS_UTIL)" "$(INS_UTIL)"

$(PDF_UTIL): $(DTX_UTIL)
	$(LUALATEX) "$(DTX_UTIL)"
	$(MV) $(__LIST_QUOTED_UTIL) "$(DIR_UTIL)/"
	$(MKDIR) "$(DIR_DOC)"
	$(MV) "$(__PDF_UTIL)" "$(PDF_UTIL)"

$(STY_UTIL): $(INS_UTIL)
	$(MKDIR) "$(DIR_BUILD)"
	$(LUATEX) "$(INS_UTIL)"
	$(MKDIR) "$(DIR_TEX)"
	$(MV) "$(__STY_UTIL)" "$(STY_UTIL)"
	$(CP) "$(STY_UTIL)" "$(STY_UTIL_COPY)"
# ──────────────────────────────────────────────────────────────────────────────
