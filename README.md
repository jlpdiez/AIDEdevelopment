PHAT Framework is a set of tools (coded using Java) to model and simulate activities of daily living.
The main components are:

- **SociAALML Editor** is a graphical editor to model the elements for the simulation.
- **PHAT Simulator** is a simulator developed from scratch using jMonkeyEngine.
- **PHAT Generator** is a tool that transforms the model defined with SociAALML in java code. The code extends PHAT Simulator and can be simulated.

### REQUIREMENTS:

- Java 1.7 (set variable JAVA_HOME)
- Maven 3.1.1+ installed, see http://maven.apache.org/download.html (set variable M2_HOME)
- Ant (set variable ANT_HOME)
#### OPTIONAL REQUIREMENTS (If an Android emulator are associated with a device):
- Android SDK (r21.1 or later, latest is best supported) installed, preferably with all platforms, see http://developer.android.com/sdk/index.html
- Make sure you have images for API 19 installed in your android SDK. It is required to have the IntelAtomx86 image to permit hardware acceleration. Instructions for Android are available in the [Android site](http://developer.android.com/tools/devices/emulator.html#acceleration)
- Set environment variable ANDROID_HOME to the path of your installed Android SDK and add $ANDROID_HOME/tools as well as $ANDROID_HOME/platform-tools to your $PATH. (or on Windows %ANDROID_HOME%\tools and %ANDROID_HOME%\platform-tools).
- Add binaries to environment variable PHAT (PATH=$PATH:$HOME/bin:$JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$M2_HOME/bin)


### USAGE:
Make sure the Android SDK is available in the classpath. In particular, the following paths are needed 
*ANDROID_HOME/tools* and *ANDROID_HOME/platform-tools* are in the PATH variable.  

The sequence of commands are:

1. To open SociAALML Editor:

    **$ ant edit**
    
    Once the editor is opend, you can model and and save at any point.

2. To generate the java code to the simulation using the las model saved:
    
    **$ mvn clean compile**

3. Make sure you have the right AVDs created. This can be done manually or by script:

    **$ sh target/generated/scripts/createAVDsSim1.sh** in linux
    **$ target/generated/scripts/createAVDsSim1.bat** in windows

4. To launch the simulation:

    **$ mvn exec:java -Dexec.mainClass="phat.sim.MainSim1PHATSimulation"**

This will launch the whole system (3D environment and Android emulators). If you close the terminal, emulators and 3D environment will close. It takes a while to launch and if you are modifying the specification, it is a time consuming task to launch and relaunch. 

Once you get used to to it, we reccommend to keep emulators always on and start/stop only the 3D environment. Emulators can be launched separatedly with:

**$ mvn exec:java -Dexec.mainClass="phat.sim.MainSim1PHATSimulationOnlyDevices"**

While keeping the emulators, you can launch

  **$ mvn exec:java -Dexec.mainClass="phat.sim.MainSim1PHATSimulation"**

And it will reconnect with emulators safely.
