--- iwl7260-ucode-25.228.9.0.ebuild	2014-11-07 12:15:03.051850722 +0100
+++ /usr/portage/sys-firmware/iwl7260-ucode/iwl7260-ucode-23.214.9.0.ebuild	2014-06-16 16:07:54.000000000 +0200
@@ -27,10 +27,10 @@
 ERROR_IWLMVM="CONFIG_IWLMVM is required to be enabled in /usr/src/linux/.config for the kernel to be able to load the ${DEV_N} firmware"
 
 pkg_pretend() {
-	if kernel_is lt 3 14 9; then
+	if kernel_is lt 3 14 7; then
 		ewarn "Your kernel version is ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}."
-		ewarn "This microcode image requires a kernel >= 3.14.9."
-		ewarn "For kernel versions < 3.14.9, you may install older SLOTS"
+		ewarn "This microcode image requires a kernel >= 3.14.7."
+		ewarn "For kernel versions < 3.14.7, you may install older SLOTS"
 	fi
 }
 
