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

### Class-related.
#### `frwyslnd-book`.
DIR_BOOK := $(DIR_CLS)/book

### Package-related.
#### `frwyslnd-filler`.
DIR_FILLER := $(DIR_PKG)/filler

#### `frwyslnd-util`.
DIR_UTIL := $(DIR_PKG)/util

## File stems.
### Class-related.
#### `frwyslnd-book`.
STEM_BOOK := $(BUNDLE_NAME)-book

### Package-related.
#### `frwyslnd-filler`.
STEM_FILLER := $(BUNDLE_NAME)-filler

#### `frwyslnd-util`.
STEM_UTIL := $(BUNDLE_NAME)-util

## File basenames.
### Class-related.
#### `frwyslnd-book`.
BASENAME_CLS_BOOK := $(STEM_BOOK).cls
BASENAME_DTX_BOOK := $(STEM_BOOK).dtx
BASENAME_INS_BOOK := $(STEM_BOOK).ins
BASENAME_PDF_BOOK := $(STEM_BOOK).pdf

### Package-related.
#### `frwyslnd-filler`.
BASENAME_DTX_FILLER := $(STEM_FILLER).dtx
BASENAME_INS_FILLER := $(STEM_FILLER).ins
BASENAME_PDF_FILLER := $(STEM_FILLER).pdf
BASENAME_STY_FILLER := $(STEM_FILLER).sty

#### `frwyslnd-util`.
BASENAME_DTX_UTIL := $(STEM_UTIL).dtx
BASENAME_INS_UTIL := $(STEM_UTIL).ins
BASENAME_PDF_UTIL := $(STEM_UTIL).pdf
BASENAME_STY_UTIL := $(STEM_UTIL).sty

## Files.
### Class-related.
#### `frwyslnd-book`.
CLS_BOOK := $(DIR_TEX)/$(BASENAME_CLS_BOOK)
CLS_BOOK_COPY := $(DIR_BOOK)/$(BASENAME_CLS_BOOK)
DTX_BOOK := $(DIR_BOOK)/$(BASENAME_DTX_BOOK)
INS_BOOK := $(DIR_BOOK)/$(BASENAME_INS_BOOK)
PDF_BOOK := $(DIR_DOC)/$(BASENAME_PDF_BOOK)
__CLS_BOOK := $(DIR_BUILD)/$(BASENAME_CLS_BOOK)
__DTX_BOOK := $(DIR_BUILD)/$(BASENAME_DTX_BOOK)
__INS_BOOK := $(DIR_BUILD)/$(BASENAME_INS_BOOK)
__PDF_BOOK := $(DIR_BUILD)/$(BASENAME_PDF_BOOK)

### Package-related.
#### `frwyslnd-filler`.
DTX_FILLER := $(DIR_FILLER)/$(BASENAME_DTX_FILLER)
INS_FILLER := $(DIR_FILLER)/$(BASENAME_INS_FILLER)
PDF_FILLER := $(DIR_DOC)/$(BASENAME_PDF_FILLER)
STY_FILLER := $(DIR_TEX)/$(BASENAME_STY_FILLER)
STY_FILLER_COPY := $(DIR_FILLER)/$(BASENAME_STY_FILLER)
__DTX_FILLER := $(DIR_BUILD)/$(BASENAME_DTX_FILLER)
__INS_FILLER := $(DIR_BUILD)/$(BASENAME_INS_FILLER)
__PDF_FILLER := $(DIR_BUILD)/$(BASENAME_PDF_FILLER)
__STY_FILLER := $(DIR_BUILD)/$(BASENAME_STY_FILLER)

#### `frwyslnd-util`.
DTX_UTIL := $(DIR_UTIL)/$(BASENAME_DTX_UTIL)
INS_UTIL := $(DIR_UTIL)/$(BASENAME_INS_UTIL)
PDF_UTIL := $(DIR_DOC)/$(BASENAME_PDF_UTIL)
STY_UTIL := $(DIR_TEX)/$(BASENAME_STY_UTIL)
STY_UTIL_COPY := $(DIR_UTIL)/$(BASENAME_STY_UTIL)
__DTX_UTIL := $(DIR_BUILD)/$(BASENAME_DTX_UTIL)
__INS_UTIL := $(DIR_BUILD)/$(BASENAME_INS_UTIL)
__PDF_UTIL := $(DIR_BUILD)/$(BASENAME_PDF_UTIL)
__STY_UTIL := $(DIR_BUILD)/$(BASENAME_STY_UTIL)

## Lists.
### By extension.
#### Quoted.
LIST_QUOTED_CLS := "$(CLS_BOOK)" \
                   "$(CLS_BOOK_COPY)"
LIST_QUOTED_DTX := "$(DTX_BOOK)" \
                   "$(DTX_FILLER)" \
									 "$(DTX_UTIL)"
LIST_QUOTED_INS := "$(INS_BOOK)" \
                   "$(INS_FILLER)" \
									 "$(INS_UTIL)"
LIST_QUOTED_PDF := "$(PDF_BOOK)" \
                   "$(PDF_FILLER)" \
									 "$(PDF_UTIL)"
LIST_QUOTED_STY := "$(STY_FILLER)" \
                   "$(STY_FILLER_COPY)" \
                   "$(STY_UTIL)" \
                   "$(STY_UTIL_COPY)"

#### Unquoted.
LIST_CLS := $(CLS_BOOK)
LIST_DTX := $(DTX_BOOK) \
            $(DTX_FILLER) \
						$(DTX_UTIL)
LIST_INS := $(INS_BOOK) \
            $(INS_FILLER) \
						$(INS_UTIL)
LIST_PDF := $(PDF_BOOK) \
            $(PDF_FILLER) \
						$(PDF_UTIL)
LIST_STY := $(STY_FILLER) \
            $(STY_UTIL)

### Class-related.
#### `frwyslnd-book`.
#### # Quoted.
LIST_QUOTED_BOOK := "$(CLS_BOOK)" \
                    "$(INS_BOOK)"
__LIST_QUOTED_BOOK := "$(__CLS_BOOK)" \
                      "$(__INS_BOOK)"
#### # Unquoted.
LIST_BOOK := $(CLS_BOOK) \
             $(INS_BOOK)
__LIST_BOOK := $(__CLS_BOOK) \
               $(__INS_BOOK)

### Package-related.
#### `frwyslnd-filler`.
#### # Quoted.
LIST_QUOTED_FILLER := "$(INS_FILLER)" \
                    "$(STY_FILLER)"
__LIST_QUOTED_FILLER := "$(__INS_FILLER)" \
                      "$(__STY_FILLER)"
#### # Unquoted.
LIST_FILLER := $(INS_FILLER) \
             $(STY_FILLER)
__LIST_FILLER := $(__INS_FILLER) \
               $(__STY_FILLER)

#### `frwyslnd-util`.
#### # Quoted.
LIST_QUOTED_UTIL := "$(INS_UTIL)" \
                    "$(STY_UTIL)"
__LIST_QUOTED_UTIL := "$(__INS_UTIL)" \
                      "$(__STY_UTIL)"
#### # Unquoted.
LIST_UTIL := $(INS_UTIL) \
             $(STY_UTIL)
__LIST_UTIL := $(__INS_UTIL) \
               $(__STY_UTIL)

## Shell commands and executables.
### Non-OS-specific.
LUALATEX := latexmk \
            -lualatex \
            -file-line-error \
            -interaction=nonstopmode \
            -synctex=1
LUATEX := luatex \
          --file-line-error \
          --interaction=nonstopmode \
          --output-directory="$(DIR_BUILD)"

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
## Special targets.
.PHONY: all \
        all-with-doc \
        clean \
        util \
        util-with-doc

.SILENT:

## Phony targets.
all-with-doc: $(LIST_CLS) \
              $(PDF_UTIL) \
              $(LIST_PDF)

all: $(LIST_CLS) \
     $(LIST_STY)

book: $(CLS_BOOK)

book-with-doc: $(CLS_BOOK) \
               $(PDF_BOOK)

clean:
	-$(call rmdir, "$(DIR_BUILD)")
	-$(call rmdir, "$(DIR_DOC)")
	-$(RM) $(LIST_QUOTED_CLS) $(LIST_QUOTED_INS) $(LIST_QUOTED_STY)

filler: $(STY_FILLER)

filler-with-doc: $(PDF_FILLER)

util: $(STY_UTIL)

util-with-doc: $(PDF_UTIL)

## Classes.
### `frwyslnd-book`.
$(CLS_BOOK): $(INS_BOOK)
	$(MKDIR) "$(DIR_BUILD)"
	$(LUATEX) "$(INS_BOOK)"
	$(MKDIR) "$(DIR_TEX)"
	$(MV) "$(__CLS_BOOK)" "$(CLS_BOOK)"
	$(CP) "$(CLS_BOOK)" "$(CLS_BOOK_COPY)"

$(INS_BOOK): $(DTX_BOOK)
	$(MKDIR) "$(DIR_BUILD)"
	$(LUATEX) "$(DTX_BOOK)"
	$(MV) "$(__INS_BOOK)" "$(INS_BOOK)"

$(PDF_BOOK): $(DTX_BOOK) \
             $(STY_UTIL)
	$(LUALATEX) "$(DTX_BOOK)"
	$(MV) $(__LIST_QUOTED_BOOK) "$(DIR_BOOK)/"
	$(MKDIR) "$(DIR_DOC)"
	$(MV) "$(__PDF_BOOK)" "$(PDF_BOOK)"

## Packages.
### `frwyslnd-filler`.
$(INS_FILLER): $(DTX_FILLER)
	$(MKDIR) "$(DIR_BUILD)"
	$(LUATEX) "$(DTX_FILLER)"
	$(MV) "$(__INS_FILLER)" "$(INS_FILLER)"

$(PDF_FILLER): $(DTX_FILLER) \
               $(STY_UTIL)
	$(LUALATEX) "$(DTX_FILLER)"
	$(MV) $(__LIST_QUOTED_FILLER) "$(DIR_FILLER)/"
	$(MKDIR) "$(DIR_DOC)"
	$(MV) "$(__PDF_FILLER)" "$(PDF_FILLER)"

$(STY_FILLER): $(INS_FILLER)
	$(MKDIR) "$(DIR_BUILD)"
	$(LUATEX) "$(INS_FILLER)"
	$(MKDIR) "$(DIR_TEX)"
	$(MV) "$(__STY_FILLER)" "$(STY_FILLER)"
	$(CP) "$(STY_FILLER)" "$(STY_FILLER_COPY)"

### `frwyslnd-util`.
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
