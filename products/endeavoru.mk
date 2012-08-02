# Specify phone tech before including full_phone
$(call inherit-product, vendor/aokp/configs/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := endeavoru

# Inherit some common aokp stuff.
$(call inherit-product, vendor/aokp/configs/common_phone.mk)
$(call inherit-product, vendor/aokp/configs/common_versions.mk)

# Inherit the endeavoru device
$(call inherit-product, device/htc/endeavoru/full_endeavoru.mk)

PRODUCT_PACKAGES += \
	Camera

# Device naming
PRODUCT_DEVICE := endeavoru
PRODUCT_NAME := aokp_endeavoru
PRODUCT_BRAND := htc
PRODUCT_MODEL := HTC One X
PRODUCT_MANUFACTURER := HTC

#Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=endeavoru BUILD_FINGERPRINT="htc_europe/endeavoru/endeavoru:4.0.4/IMM76D/89015.5:userdebug/test-keys" PRIVATE_BUILD_DESC="2.15.401.5 CL89015 test-keys"

# Copy over prebuilt boot animation
PRODUCT_COPY_FILES +=  \
    vendor/aokp/prebuilt/bootanimation/bootanimation_720_1280.zip:system/media/bootanimation.zip

DEVICE_PACKAGE_OVERLAYS += vendor/aokp/overlay/endeavoru

PRODUCT_COPY_FILES += \
	vendor/aokp/prebuilt/common/etc/apns-conf-cdma.xml:system/etc/apns-conf-cdma.xml \
	vendor/aokp/prebuilt/common/etc/spn-conf.xml:system/etc/spn-conf.xml \
