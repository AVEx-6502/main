
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
	$(qemusrcdir)/configure --target-list=$(target) --prefix=$(builddir)
endif
	
install:
	@echo "  Compiling Qemu"
	cd $(bindir); \
	make; \
	make install;
	
clean:
	@rm -fr $(builddir) $(bindir)

start:
	$(qemu)
	
	
	
update:
	git submodule update --init --recursive