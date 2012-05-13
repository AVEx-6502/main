UNAME := $(shell uname)

ifeq ($(UNAME), Linux)
	NUM_JOBS:=$(shell expr `grep -c ^processor /proc/cpuinfo` + 1)
else
	NUM_JOBS:=1
endif


target = 6502-softmmu

qemusrcdir = $(CURDIR)/qemu-6502

bindir = $(CURDIR)/bin
builddir = $(CURDIR)/build

qemu = $(builddir)/bin/qemu-system-6502

all: configure install

configure:
ifeq ($(wildcard $(bindir)/config-host.mak),)
	@echo "  Configuring Qemu"
	@mkdir -p $(bindir) $(builddir); \
	cd $(bindir); \
	$(qemusrcdir)/configure --enable-debug --target-list=$(target) --prefix=$(builddir)
endif
	
install:
	@echo "  Compiling Qemu"
	cd $(bindir); \
	make -j $(NUM_JOBS); \
	make install;
	
clean:
	@rm -fr $(builddir) $(bindir)

start:
	$(qemu)
	
test:
	cd ./tests-6502/; \
	./runtests.sh $(qemu);

demo:
	$(qemu) -bios ./tests-6502/demo1
	
update:
	git submodule update --init --recursive
	cd $(qemusrcdir) && git checkout master

