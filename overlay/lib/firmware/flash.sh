
#!/bin/sh

cd /lib/firmware
# Load firmware
echo system_top.bit.bin > /sys/class/fpga_manager/fpga0/firmware
if [ $? -ne 0 ]; then
    echo "Failed to load firmware"
    exit 1
fi

# Reset board
echo 79024000.cf-ad9361-dds-core-lpc > /sys/bus/platform/drivers/cf_axi_dds/unbind
if [ $? -ne 0 ]; then
    echo "Failed to unbind cf-ad9361-dds-core-lpc"
    exit 1
fi

echo 79020000.cf-ad9361-lpc > /sys/bus/platform/drivers/cf_axi_adc/unbind
if [ $? -ne 0 ]; then
    echo "Failed to unbind cf-ad9361-lpc"
    exit 1
fi

echo 7c400000.dma > /sys/bus/platform/drivers/dma-axi-dmac/unbind
if [ $? -ne 0 ]; then
    echo "Failed to unbind dma-axi-dmac (7c400000)"
    exit 1
fi

echo 7c420000.dma > /sys/bus/platform/drivers/dma-axi-dmac/unbind
if [ $? -ne 0 ]; then
    echo "Failed to unbind dma-axi-dmac (7c420000)"
    exit 1
fi

echo 7c420000.dma > /sys/bus/platform/drivers/dma-axi-dmac/bind
if [ $? -ne 0 ]; then
    echo "Failed to bind dma-axi-dmac (7c420000)"
    exit 1
fi

echo 7c400000.dma > /sys/bus/platform/drivers/dma-axi-dmac/bind
if [ $? -ne 0 ]; then
    echo "Failed to bind dma-axi-dmac (7c400000)"
    exit 1
fi

echo 79024000.cf-ad9361-dds-core-lpc > /sys/bus/platform/drivers/cf_axi_dds/bind
if [ $? -ne 0 ]; then
    echo "Failed to bind cf-ad9361-dds-core-lpc"
    exit 1
fi

echo 79020000.cf-ad9361-lpc > /sys/bus/platform/drivers/cf_axi_adc/bind
if [ $? -ne 0 ]; then
    echo "Failed to bind cf-ad9361-lpc"
    exit 1
fi

# Leave timestamping enabled indicator
echo 1 > /tmp/timestamping_enabled


