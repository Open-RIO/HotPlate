# HotPlate
Toast module building made easy.

## Installation

### Install Ruby
- Windows
  - Install Ruby using the [Ruby Installer](http://rubyinstaller.org/). (Make sure to check the box that says "Add Ruby executables to your PATH")
- Mac
  - While mac comes with a Ruby version preinstalled, you may reinstall using the rbenv package from Homebrew
- Linux
  - It is recommended to use [RVM](http://rvm.io/) to install ruby, however you can also run ```sudo apt-get install ruby```.

### Install Hotplate
Running ```gem install hotplate``` in a command line terminal will install the HotPlate utility to your system.

## Usage
HotPlate is used from the Command Line. The following commands are valid:  
- ``` toast init ```
  - Will create a Toast module in either Java or JavaScript. The CLI will walk you through all the options for the module and create it in a new folder relative to the current directory.  

  ![](img/init.png)
- ``` toast build ```
  - To be run inside a Module folder. Will build the module and dump it in ``` build/ ``` for JavaScript and ``` build/libs/ ``` for Java.

  ![](img/build.png)  

- ``` toast idea ``` and ``` toast eclipse ```
  - To be run inside a Java Module Folder. This will create the development environment for either the IntelliJ IDEA IDE or the Eclipse IDE
