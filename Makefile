install: root
	@if systemctl -q is-enabled asusgpuboot > /dev/null 2>&1; then \
		systemctl disable asusgpuboot; \
	fi
	cp etc/modprobe.d/asus-linux.conf /etc/modprobe.d/
	cp etc/systemd/system/* /etc/systemd/system/
	cp usr/local/bin/* /usr/local/bin/
	systemctl enable asusgpuboot

uninstall: root
	@if systemctl -q is-enabled asusgpuboot > /dev/null 2>&1; then \
		systemctl disable asusgpuboot; \
	fi
	rm /etc/modprobe.d/asus-linux.conf
	rm /etc/systemd/system/asusgpu*
	rm /usr/local/bin/asusgpu*

root:
ifneq ($(shell id -u), 0)
	@echo "requires root, run with sudo/doas/etc."
	exit 1
endif

.PHONY: install uninstall root
