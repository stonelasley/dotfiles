format:
	stylua lazy/lua/

verify:
	stylua --check lazy/lua/
	ansible-lint main.yml
	python3 scripts/check-manifest.py
