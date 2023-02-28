################################################################################
#
# gnuradio
#
################################################################################

GNURADIO_VERSION = 3.10.3.0
GNURADIO_SOURCE = v$(GNURADIO_VERSION).tar.gz
GNURADIO_SITE = https://github.com/gnuradio/gnuradio/archive/refs/tags
GNURADIO_LICENSE = GPL-3.0+
GNURADIO_LICENSE_FILES = COPYING
GNURADIO_SUPPORTS_IN_SOURCE_BUILD = NO

# needed to determine site-packages path
GNURADIO_PYVER = $(PYTHON3_VERSION_MAJOR)

# host-python-mako and host-python-six are needed for volk to compile
GNURADIO_DEPENDENCIES = \
	host-python3 \
	python-pip \
	python-pybind \
    host-python-numpy \
    host-python-packaging \
	host-python-mako \
	host-python-six \
	boost \
    spdlog \
	log4cpp \
	gmp \
	volk

GNURADIO_CONF_OPTS = \
	-DPYTHON_EXECUTABLE=$(HOST_DIR)/bin/python \
	-DENABLE_DEFAULT=OFF \
	-DENABLE_GNURADIO_RUNTIME=ON \
	-DENABLE_TESTING=OFF \
	-DXMLTO_EXECUTABLE=NOTFOUND

# For third-party blocks, the gnuradio libraries are mandatory at
# compile time.
GNURADIO_INSTALL_STAGING = YES

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
GNURADIO_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-latomic
endif

ifeq ($(BR2_PACKAGE_ORC),y)
GNURADIO_DEPENDENCIES += orc
GNURADIO_CONF_OPTS += -DENABLE_ORC=ON
else
GNURADIO_CONF_OPTS += -DENABLE_ORC=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_ANALOG),y)
GNURADIO_CONF_OPTS += -DENABLE_GR_ANALOG=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_ANALOG=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_AUDIO),y)
ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
GNURADIO_DEPENDENCIES += alsa-lib
endif
ifeq ($(BR2_PACKAGE_PORTAUDIO),y)
GNURADIO_DEPENDENCIES += portaudio
endif
GNURADIO_CONF_OPTS += -DENABLE_GR_AUDIO=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_AUDIO=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_BLOCKS),y)
GNURADIO_CONF_OPTS += -DENABLE_GR_BLOCKS=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_BLOCKS=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_CHANNELS),y)
GNURADIO_CONF_OPTS += -DENABLE_GR_CHANNELS=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_CHANNELS=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_CTRLPORT),y)
GNURADIO_CONF_OPTS += -DENABLE_GR_CTRLPORT=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_CTRLPORT=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_DIGITAL),y)
GNURADIO_CONF_OPTS += -DENABLE_GR_DIGITAL=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_DIGITAL=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_DTV),y)
GNURADIO_CONF_OPTS += -DENABLE_GR_DTV=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_DTV=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_FEC),y)
GNURADIO_DEPENDENCIES += gsl
GNURADIO_CONF_OPTS += -DENABLE_GR_FEC=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_FEC=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_FFT),y)
GNURADIO_DEPENDENCIES += fftw-single
GNURADIO_CONF_OPTS += -DENABLE_GR_FFT=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_FFT=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_FILTER),y)
GNURADIO_CONF_OPTS += -DENABLE_GR_FILTER=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_FILTER=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_PYTHON),y)
GNURADIO_DEPENDENCIES += python3
GNURADIO_CONF_OPTS += -DENABLE_PYTHON=ON
# mandatory to install python modules in site-packages and to use
# correct path for python libraries
GNURADIO_CONF_OPTS += -DGR_PYTHON_RELATIVE=ON \
	-DGR_PYTHON_DIR=lib/python$(GNURADIO_PYVER)/site-packages \
	-DCMAKE_CXX_FLAGS="${TARGET_CXXFLAGS} -isystem $(STAGING_DIR)/usr/lib/python$(GNURADIO_PYVER)/site-packages/numpy/core/include"
        #-Dpybind11_DIR="$(STAGING_DIR)/usr/lib/python$(GNURADIO_PYVER)/site-packages/pybind11/share/cmake/pybind11"
else
GNURADIO_CONF_OPTS += -DENABLE_PYTHON=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_PAGER),y)
GNURADIO_CONF_OPTS += -DENABLE_GR_PAGER=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_PAGER=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_QTGUI),y)
GNURADIO_DEPENDENCIES += qt5base python-pyqt5 qwt
GNURADIO_CONF_OPTS += -DENABLE_GR_QTGUI=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_QTGUI=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_TRELLIS),y)
GNURADIO_CONF_OPTS += -DENABLE_GR_TRELLIS=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_TRELLIS=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_UHD),y)
GNURADIO_DEPENDENCIES += uhd
GNURADIO_CONF_OPTS += -DENABLE_GR_UHD=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_UHD=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_UTILS),y)
GNURADIO_CONF_OPTS += -DENABLE_GR_UTILS=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_UTILS=OFF
endif

ifeq ($(BR2_PACKAGE_GNURADIO_ZEROMQ),y)
GNURADIO_DEPENDENCIES += cppzmq
ifeq ($(BR2_PACKAGE_GNURADIO_PYTHON),y)
GNURADIO_DEPENDENCIES += python-pyzmq
endif
GNURADIO_CONF_OPTS += -DENABLE_GR_ZEROMQ=ON
else
GNURADIO_CONF_OPTS += -DENABLE_GR_ZEROMQ=OFF
endif

GNURADIO_TARGET: $(GNURADIO_DEPENDENCIES)

$(eval $(cmake-package))
