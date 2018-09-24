#  Ambient Intelligence Development Environment for People with Neurodegenerative Diseases

This site shows how to use the [AIDE](http://grasia.fdi.ucm.es/aide/) toolset for the deveolopment of AAL solutions for people with neurogenerative diseases (NDD).

It first briefly explains what is [AIDE](http://grasia.fdi.ucm.es/aide/), how to install it, and then a set of case studies that illustrate what can be done with it.

This has been developed in the context of the project [ColoSAAL](http://grasia.fdi.ucm.es/colosaal/), whose purpose is to facilitate the co-creation of AAL solutions for people with NDD. 

The [ColoSAAL](http://grasia.fdi.ucm.es/colosaal/) project proposes a process that involves different actors: end-users, relatives, care-givers, health experts, sociologists, software engineers, and other relevant stakeholders.

They will co-create AAL solutions in an iterative process, where the interaction artifacts are simulations of scenarios of the solutions in daily activities of the end-users (in this case, the people with NDD).

These simulations can be seen and analysed by the different actors, who can comment on them, and such information is taken to provide a refined solution.

In order to do this, several tools are used: [**AIDE**](http://grasia.fdi.ucm.es/aide/) and [**PHAT simulator**](https://github.com/Grasia/phatsim).

## Introduction to the Framework:

[**AIDE**](http://grasia.fdi.ucm.es/aide/) stands for **A**mbient **I**ntelligence **D**evelopment **E**nvironment and is a set of tools to model, simulate and rapid prototype Ambient Intelligence systems. For more information please visit [this link.](http://grasia.fdi.ucm.es/aide/)

[**PHAT Framework**](https://github.com/Grasia/phatsim) is a set of tools (coded using Java) to model and simulate activities of daily living.
The main components are:

- **[SociAALML Editor](https://github.com/Grasia/sociaalml)** is a graphical editor to model the elements for the simulation. The editor is based on [INGENME](https://github.com/Grasia/ingenme) framework.
- [**PHAT Generator**](https://github.com/Grasia/phatsim) is a tool that transforms the model defined with SociAALML into java code which can then be executed to see the simulations in action.
- [**PHAT Simulator**](https://github.com/Grasia/phatsim) is a simulator developed from scratch using jMonkeyEngine, which makes the entire framework [FOSS](https://en.wikipedia.org/wiki/Free_and_open-source_software).
*Note:* Both PHAT components can be found [here](https://github.com/Grasia/phatsim)

![activities](http://grasia.fdi.ucm.es/aide/img/activities.png)

## Getting Started:

### Installation:
#### Java 1.7 at least (set variable JAVA_HOME). 

In ubuntu at the time of writing the minimun version is 1.8. Install it by typing:
```
$ sudo apt install openjdk-8-jre
$ sudo apt install openjdk-8-jdk-headless
```
You can check the java version with:
```
$ java -version
$ javac -version
```
To change between java versions:
```
sudo update-alternatives --config java
```

#### Maven 3.1.1+ at least (set variable M2_HOME).

```
$ sudo apt install maven
```
If you need to set M2 variables add the following lines to your .bashrc or .zshrc or whatever you use:
```
export M2_HOME="/usr/share/maven"
export M2="$M2_HOME/bin"
export PATH="$M2:$PATH"
```

#### Ant (set variable ANT_HOME)

```
$ sudo apt install ant
```

### Usage:
1. To open SociAALML Editor you go to a project's folder and type:

    **$ ant edit**

2. To generate the java code of the simulation from the model:
    
    **$ mvn clean compile**

3. To run a simulation
    
    **$ ant runSimName**

*NOTE:* Bash completion for ant is useful when searching for simulations with "ab" key: http://ingenias.sourceforge.net/blog/2012/12/04/a-useful-bashcompletion-extension-for-ant/

### Case Study Usage Example:
Download full repository
```
$ git clone git@github.com:Melkoroth/AIDEdevelopment.git
$ cd AIDEdevelopment
```
Enter project directory, compile and run a simulation
```
$ cd e6interview
$ mvn clean compile 
$ ant runSimAll
```
If you get an error message complaining about encoding you should call maven with the following line:
```
$ mvn clean compile -Dfile.encoding=UTF8
```
This should launch a PHATSIM window with the simulation. It should be similar to this one:
![phatsim example](https://github.com/Melkoroth/AIDEdevelopment/raw/master/documentation/phatExample.png)

## Acknowledgements

This development is part of [ColoSAAL](http://grasia.fdi.ucm.es/colosaal/) project (TIN2014-57028-R) which is funded by Spain's Ministerio de Economía y Competitividad. Developed at Universidad Complutense de Madrid.

![logo saal](http://grasia.fdi.ucm.es/colosaal/img/logo_colosaal.png)
![logo ucm](http://grasiagroup.fdi.ucm.es/aidendd/wp-content/uploads/logo_ucm-e1537792345349.jpg)
![logo min](http://grasia.fdi.ucm.es/colosaal/img/gobspain.png)
