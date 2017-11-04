include vendor/opengapps/build/core/definitions.mk
include vendor/opengapps/build/config.mk
include vendor/opengapps/build/opengapps-files.mk

DEVICE_PACKAGE_OVERLAYS += $(GAPPS_DEVICE_FILES_PATH)/overlay/pico

GAPPS_PRODUCT_PACKAGES += \
		BugReportSender \
		ConfigUpdater \
		GoogleBackupTransport \
		GoogleContactsSyncAdapter \
		GoogleServicesFramework \
		NoTouchAuthDelegate \
		PrebuiltGmsCorePano \
		Tubesky \
		Backdrop \
		AndroidMediaShell \
		GlobalKeyInterceptor \
		TV \
		Overscan \
		RemoteControlService \
		SecondScreenSetup \
		SecondScreenSetupAuthBridge \
		talkback \
		LeanbackLauncher \
		LeanbackIme \
		VideosPano \
		Music2Pano \
		CanvasPackageInstaller \
		PlayGames \
		Katniss \
		AtvWidget \
		YouTubeLeanback \
		SetupWraith \
		AtvRemoteService

ifneq ($(filter $(call get-allowed-api-levels),23),)
GAPPS_PRODUCT_PACKAGES += \
    GoogleTTS \
    GooglePackageInstaller
endif

ifneq ($(filter $(call get-allowed-api-levels),24),)
GAPPS_PRODUCT_PACKAGES += \
    GooglePrintRecommendationService \
    GoogleExtServices \
    GoogleExtShared \
    LandscapeWallpaper
endif

# This needs to be at the end of standard files, but before the GAPPS_FORCE_* options,
# since those also affect DEVICE_PACKAGE_OVERLAYS. We don't want to exclude a package
# that also has an overlay, since that will make us use the overlay but not have the
# package. This can cause issues.
PRODUCT_PACKAGES += $(filter-out $(GAPPS_EXCLUDED_PACKAGES),$(GAPPS_PRODUCT_PACKAGES))

ifeq ($(GAPPS_FORCE_WEBVIEW_OVERRIDES),true)
ifneq ($(filter-out $(call get-allowed-api-levels),24),)
DEVICE_PACKAGE_OVERLAYS += $(GAPPS_DEVICE_FILES_PATH)/overlay/webview/21
else
DEVICE_PACKAGE_OVERLAYS += $(GAPPS_DEVICE_FILES_PATH)/overlay/webview/24
endif
PRODUCT_PACKAGES += WebViewGoogle
endif
