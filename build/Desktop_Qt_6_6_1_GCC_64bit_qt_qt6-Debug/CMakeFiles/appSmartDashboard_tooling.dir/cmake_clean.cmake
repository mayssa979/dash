file(REMOVE_RECURSE
  "SmartDashboard/assets/fonts/CodecPro-Italic.ttf"
  "SmartDashboard/assets/fonts/CodecPro-Regular.ttf"
  "SmartDashboard/assets/fonts/fontawesome.otf"
  "SmartDashboard/assets/icons/Bookmarks.svg"
  "SmartDashboard/assets/icons/Explore.svg"
  "SmartDashboard/assets/icons/Fetch.svg"
  "SmartDashboard/assets/icons/Location.svg"
  "SmartDashboard/assets/icons/Menu.svg"
  "SmartDashboard/assets/icons/Messages.svg"
  "SmartDashboard/assets/icons/Notifications.svg"
  "SmartDashboard/assets/icons/Profile.svg"
  "SmartDashboard/assets/icons/Setting.svg"
  "SmartDashboard/assets/images/location.png"
  "SmartDashboard/qml/Main.qml"
  "SmartDashboard/qml/components/CircularProgressBar.qml"
  "SmartDashboard/qml/components/Device.qml"
  "SmartDashboard/qml/components/Edev.qml"
  "SmartDashboard/qml/components/Gateways.qml"
  "SmartDashboard/qml/components/IconLabel.qml"
  "SmartDashboard/qml/components/LeftPane.qml"
  "SmartDashboard/qml/components/Maps.qml"
  "SmartDashboard/qml/components/MiddlePane.qml"
  "SmartDashboard/qml/components/MiddlePaneWidget.qml"
  "SmartDashboard/qml/components/Progressbar.qml"
  "SmartDashboard/qml/components/RightPane.qml"
  "SmartDashboard/qml/components/RightPaneLightSwitchComponent.qml"
  "SmartDashboard/qml/components/Sidebar.qml"
  "SmartDashboard/qml/components/Switch.qml"
  "SmartDashboard/qml/messages/MessageStore.qml"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/appSmartDashboard_tooling.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
