SOURCE="http://www.remmina.org/appimage-test/x86_64/Remmina-1.2.0_rcgit_20_205df66.glibc2.14-x86_64.AppImage"
OUTPUT="Remmina.AppImage"

all:
	echo "Building: $(OUTPUT)"
	rm -f ./$(OUTPUT)
	#wget --output-document=$(OUTPUT) --continue $(SOURCE)
	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)

