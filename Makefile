

cc	= libs/cc65-win/bin/cc65.exe
ca	= libs/cc65-win/bin/ca65.exe

qemusrcdir = $(CURDIR)/qemu-6502
builddir = $(CURDIR)/build

configure:
	@echo "  Configuring Qemu"
	@mkdir -p $(builddir); \
	cd $(builddir); \
	$(qemusrcdir)/configure --target-list=6502-softmmu
	
clean:
	@rm -fr $(builddir)