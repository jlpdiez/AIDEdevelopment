# AIDE for Dementia Patients from Real-life Interviews

This is a set of simulations modeled after real-life interviews with dementia patients (Alzheimer included) using PHAT Framework / AIDE.

From the interview data given by the patient or caregiver a 24-hour period was modeled which represents a typical day in their life. Once this was done the next task was to analyse and recreate the problems they encounter daily. For these, filters were applied that try to mimick their troubles. 
Afterwards, simulations were run and analysed, and videos were generated.

**AIDE** stands for **A**mbient **I**ntelligence **D**evelopment **E**nvironment and is a set of tools to model, simulate and rapid prototype Ambient Intelligence systems. For more information please visit [this link.](http://grasia.fdi.ucm.es/aide/)

PHAT Framework is a set of tools (coded using Java) to model and simulate activities of daily living.
The main components are:

- **[SociAALML Editor](https://github.com/Grasia/sociaalml)** is a graphical editor to model the elements for the simulation. The editor is based on [INGENME](https://github.com/Grasia/ingenme) framework.
- **PHAT Generator** is a tool that transforms the model defined with SociAALML into java code which can then be executed to see the simulations in action.
- **PHAT Simulator** is a simulator developed from scratch using jMonkeyEngine, which makes the entire framework [FOSS](https://en.wikipedia.org/wiki/Free_and_open-source_software).
*Note:* Both PHAT components can be found [here](https://github.com/Grasia/phatsim)

![activities](http://grasia.fdi.ucm.es/aide/img/activities.png)

### REQUIREMENTS:
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

## USAGE:
1. To open SociAALML Editor you go to a project's folder and type:

    **$ ant edit**

2. To generate the java code of the simulation from the model:
    
    **$ mvn clean compile**

3. To run a simulation
    
    **$ ant runSimName**

*NOTE:* Bash completion for ant is useful when searching for simulations with "ab" key: http://ingenias.sourceforge.net/blog/2012/12/04/a-useful-bashcompletion-extension-for-ant/

## Acknowledgements

This development is part of [ColoSAAL](http://grasia.fdi.ucm.es/colosaal/) project which is funded by Spain's Ministerio de Economía y Competitividad. Developed at Universidad Complutense de Madrid.

![logo saal](http://grasia.fdi.ucm.es/colosaal/img/logo_colosaal.png)
![logo ucm](http://grasiagroup.fdi.ucm.es/dementia/wp-content/uploads/UCM-logo-blanco-300x78.png)
![logo min](http://grasia.fdi.ucm.es/colosaal/img/gobspain.png)