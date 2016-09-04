#!/bin/bash
echo '=================================='
echo ' Free Law Machine [Tesseract]'
echo '=================================='
export INSTALL_ROOT=/var/www/courtlistener

sudo apt-get -yf install imagemagick libpng12-dev zlib1g-dev autoconf automake

sudo mkdir -p /opt/ocr
sudo chown -R vagrant:vagrant /opt/ocr
cd /opt/ocr
wget https://github.com/tesseract-ocr/tesseract/archive/3.04.01.tar.gz
wget https://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.eng.tar.gz
wget https://github.com/DanBloomberg/leptonica/archive/v1.73.tar.gz

# these tarballs extract both to a tesseract-oct directory and the english
# language one is designed to just magically next in the directory structure
tar -zvxf 3.04.01.tar.gz
tar -zvxf tesseract-ocr-3.02.eng.tar.gz

# required for tesseract 3.x+
tar -zvxf v1.73.tar.gz

# Install leptonica
cd leptonica-1.73
chmod +x configure
./configure
make
sudo make install
cd ..
rm -Rf v1.73.tar.gz

# Install tesseract
cd tesseract-3.04.01
./autogen.sh
./configure
make
sudo make install
sudo ldconfig
cd ..
rm 3.04.01.tar.gz tesseract-ocr-3.02.eng.tar.gz

# Link the OCR data over to support good fonts
sudo ln -s $INSTALL_ROOT/OCR/eng.traineddata \
 /usr/local/share/tessdata/eng.traineddata
