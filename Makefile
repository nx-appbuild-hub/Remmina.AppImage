# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)

all: clean
	mkdir --parents $(PWD)/build/Boilerplate.AppDir
	apprepo --destination=$(PWD)/build appdir boilerplate remmina remmina-common remmina-plugin-rdp  remmina-plugin-secret remmina-plugin-vnc \
												remmina-plugin-exec remmina-plugin-kwallet remmina-plugin-nx remmina-plugin-spice remmina-plugin-www \
												remmina-plugin-xdmcp libthai0 libselinux1

	echo 'cd $${APPDIR}/bin && exec ./remmina $${@}' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	sed -i -e 's#/usr#./..#g' $(PWD)/build/Boilerplate.AppDir/bin/remmina

	rm -f $(PWD)/build/Boilerplate.AppDir/*.desktop 		|| true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.png 		  	|| true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.svg 		  	|| true

	cp --force $(PWD)/AppDir/*.svg 		  	$(PWD)/build/Boilerplate.AppDir 			|| true
	cp --force $(PWD)/AppDir/*.desktop 		$(PWD)/build/Boilerplate.AppDir 			|| true
	cp --force $(PWD)/AppDir/*.png 		  	$(PWD)/build/Boilerplate.AppDir 			|| true

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/Remmina.AppImage
	chmod +x $(PWD)/Remmina.AppImage

clean: 
	rm --recursive --force $(PWD)/build