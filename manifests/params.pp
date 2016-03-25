# sumo::params
#
# Default values for parameters used in the module.
#
class sumo::params(
  $sumo_download_installer        = false,
  $sumo_install_dir          = '/opt/SumoCollector',
  $sumo_installer_dir        = '/tmp',
)
{
  case $::osfamily {
    RedHat: {
      $sumo_package_name   = 'SumoCollector'
      $sumo_service_config  = '/etc/sumo.conf'
      $sumo_service_name  = 'collector'
      $syncSources    = '/etc/sumo.sources.d'
    }
    Debian: {
      $sumo_package_name   = 'SumoCollector'
      $sumo_service_config  = '/etc/sumo.conf'
      $sumo_service_name  = 'collector'
      $syncSources    = '/etc/sumo.sources.d'
    }
    default: {
      fail("Module pjorg-sumo does not support osfamily: ${::osfamily}")
    }
  }
  $accessid = undef
  $accesskey = undef
  $clobber = undef
  $collectorName = undef
  $email = undef
  $ephemeral = undef
  $override = undef
  $password = undef
  $proxyHost = undef
  $proxyNtlmDomain = undef
  $proxyPassword = undef
  $proxyPort = undef
  $proxyUser = undef
  $sources = undef


  case $::architecture {
    x86_64, amd64: {
      $download_url = 'https://collectors.sumologic.com/rest/download/linux/64'
    }
    x86: {
      $download_url = 'https://collectors.sumologic.com/rest/download/linux/32'
    }
    default: {
      fail("Module pjorg-sumo does not support architecture: ${::architecture} for the downloaded installer")
    }
  }

  $sumo_installer_script    = 'sumo_install.sh'

  $download_installer_command = "/usr/bin/curl -o ${sumo_installer_script} ${download_url}"
}
