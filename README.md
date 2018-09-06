# AIDE Development from real-life interviews

**AIDE** stands for **A**mbient **I**ntelligence **D**evelopment **E**nvironment and is a set of tools to model, simulate and rapid prototype Ambient Intelligence systems. For more information please visit [this link.](http://grasia.fdi.ucm.es/aide/)

This is a set of examples modelled after real-life interviews with dementia patients (Alzheimer included) using PHAT Framework which is part of AIDE.

PHAT Framework is a set of tools (coded using Java) to model and simulate activities of daily living.
The main components are:

- **[SociAALML Editor](https://github.com/Grasia/sociaalml)** is a graphical editor to model the elements for the simulation. The editor is based on [INGENME](https://github.com/Grasia/ingenme) framework.
- **PHAT Simulator** is a simulator developed from scratch using jMonkeyEngine.
- **PHAT Generator** is a tool that transforms the model defined with SociAALML in java code. The code extends PHAT Simulator and can be simulated.
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

2. To generate the java code of the simulation using the model:
    
    **$ mvn clean compile**

3. To run a simulation
    
    **$ ant runSimName**

*NOTE:* Bash completion for ant is useful when searching for simulations: http://ingenias.sourceforge.net/blog/2012/12/04/a-useful-bashcompletion-extension-for-ant/

## Acknowledgements

This development is part of [ColoSAAL](http://grasia.fdi.ucm.es/colosaal/) project which is funded by Spain's Ministerio de Economía y Competitividad. Developed at Universidad Complutense de Madrid.

![logo saal](http://grasia.fdi.ucm.es/colosaal/img/logo_colosaal.png)
![logo ucm](https://biblioteca.ucm.es/data/cont/docs/60-2016-09-20-Marca%20UCM%20Secundaria%20Monocromo%20Negro.jpg)
![logo min](http://grasia.fdi.ucm.es/colosaal/img/gobspain.png)