source terryfy/travis_tools.sh
source terryfy/library_installers.sh

function install_qt {
    check_var $QT_URL
    check_var $DOWNLOADS_SDIR
    mkdir -p $DOWNLOADS_SDIR
    local dmg_path=$DOWNLOADS_SDIR/qt.dmg
    # -L for follow redirect
    curl -L $QT_URL > $dmg_path
    require_success "Failed to download $QT_URL"
    hdiutil attach $dmg_path -mountpoint /Volumes/qt
    sudo installer -pkg /Volumes/qt/Qt.mpkg -target /
    require_success "Failed to install $dmg_path"
    hdiutil unmount /Volumes/qt
}

# Set up build
clean_builds
# Make sure we have cmake
brew install cmake
# Download and install qt
install_qt
