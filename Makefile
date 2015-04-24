PROJECT        := wiringpi2
INTERFACE_FILE := $(PROJECT).i
CONFIG_FILE    := Makefile.config

SOURCES        := $(shell find $(SOUCEDIR) -name '*.c')
C_WRAPPER      := $(PROJECT)_wrap.cxx

include $(CONFIG_FILE)


all: $(PROJECT).py

$(PROJECT).py _$(PROJECT).so: setup.py $(INTERFACE_FILE) $(SOURCES) $(C_WRAPPER)
	$(PYTHON) $< build_ext --inplace -g

$(C_WRAPPER): $(INTERFACE_FILE)
	$(SWIG)	-python -c++ $<

install:
	sudo $(PYTHON) setup.py install

install-develop:
	sudo $(PYTHON) setup.py develop

.PHONY: all install install-develop
