#!/bin/bash
echo '=================================='
echo ' Free Law Machine [Tesseract]'
echo '=================================='
export INSTALL_ROOT=/var/www/courtlistener

sudo apt-get -yf install imagemagick libpng12-dev zlib1g-dev autoconf automake

cd ~
wget https://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.02.tar.gz
wget https://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.eng.tar.gz
wget https://leptonica.googlecode.com/files/leptonica-1.69.tar.gz
tar -zvxf tesseract-ocr-3.02.02.tar.gz
tar -zvxf tesseract-ocr-3.02.eng.tar.gz
tar -zvxf leptonica-1.69.tar.gz

# Install leptonica
cd leptonica-1.69
./configure
make
sudo make install
sudo rm -Rf leptonica*

# Install tesseract
cd tesseract-ocr
./autogen.sh
./configure
make
sudo make install
sudo ldconfig
cd ~
sudo rm -Rf tesseract* leptonica*

# Link the OCR data over to support good fonts
sudo ln -s $INSTALL_ROOT/OCR/eng.traineddata /usr/local/share/tessdata
