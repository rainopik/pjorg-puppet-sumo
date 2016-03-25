# sumo::install
#
# Performs installation of the collector package.
#
# Installation method can be configured with $sumo::sumo_download_installer
#  * false (default) - this class assumes the package is avaialble to the platform's
#                      native package management tool.
#  * true            - download and run the Installer script from Sumo Logic website
#
class sumo::install {

  if ($::sumo::sumo_download_installer) {
    exec { 'Create directory for Sumo Logic installer':
      command   => "/bin/mkdir -p -m 0500 ${::sumo::sumo_installer_dir}",
      creates   => $::sumo::sumo_installer_dir,
    }

    exec { 'Download Sumo Logic installer':
      command   => $::sumo::params::download_installer_command,
      cwd       => $::sumo::sumo_installer_dir,
      creates   => "${::sumo::sumo_installer_dir}/${::sumo::params::sumo_installer_script}",
      require   => Exec['Create directory for Sumo Logic installer'],
    }

    file { "${::sumo::sumo_installer_dir}/${::sumo::params::sumo_installer_script}":
      ensure    => present,
      mode      => '0500',
      owner     => 'root',
      group     => 'root',
      require   => Exec['Download Sumo Logic installer'],
      before    => Exec['Run Sumo Logic installer'],
    }

    exec { 'Run Sumo Logic installer':
      command   => "/bin/sh ${::sumo::sumo_installer_dir}/${::sumo::params::sumo_installer_script} -q -dir ${::sumo::sumo_install_dir}",
      cwd       => $::sumo::sumo_installer_dir,
      creates   => $::sumo::sumo_install_dir,
    }

  } else {

    package { $::sumo::params::sumo_package_name:
      ensure  => present,
    }

  }

}
