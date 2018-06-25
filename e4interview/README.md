PHAT Framework is a set of tools (coded using Java) to model and simulate activities of daily living.
The main components are:

- **SociAALML Editor** is a graphical editor to model the elements for the simulation.
- **PHAT Simulator** is a simulator developed from scratch using jMonkeyEngine.
- **PHAT Generator** is a tool that transforms the model defined with SociAALML in java code. The code extends PHAT Simulator and can be simulated.

The case study shows a person going to the kitchen, sitting down and drinking, standing up, going to the hall, sitting at the sofa, and going back to the hall. While the activity is going on, there another person cooking in the kitchen. This is the activity of the daily living that is affected by Parkinson. The studied symptom is tremors, and is present in three levels. To address how the symptom affects the application, the scenario is modified. Only low tremors are considered. Low tremors affect the sitting down in the sofa activity. When sitting down in the sofa, after a while, the patient falls, and asks for help. The partner hears the call and comes to aid.

The scenario can be run with the following possible configurations:

- SimAppBodyPosChestNoSymptoms: No tremors with the falling detection device attached to the patient's chest
- SimAppBodyPosHandNoSymptoms: No tremors with the falling detection device attached to the patient's hand
- SimAppBodyPosChest: low tremors with the falling detection device attached to the patient's chest
- SimAppBodyPosHand: low tremors with the falling detection device attached to the patient's hand
- SimTwoDevices: a camera capture device attached to patient relative's right hand wrist plus a fall detection device attached to the patient's right hand wrist
- SimAppCamera: a camera attached to the patient's right hand wrist


### REQUIREMENTS:

The following elements are needed:

- Java 1.7 (set variable JAVA_HOME)
- Maven 3.1.1+ installed, see http://maven.apache.org/download.html (set variable M2_HOME)
- Ant (set variable ANT_HOME)
- Android SDK (r21.1 or later, latest is best supported) installed, preferably with all platforms, see http://developer.android.com/sdk/index.html
- Make sure you have images for API 19 installed in your android SDK. It is required to have the IntelAtomx86 image to permit hardware acceleration. Instructions for Android are available in the [Android site](http://developer.android.com/tools/devices/emulator.html#acceleration)
- Set environment variable ANDROID_HOME to the path of your installed Android SDK and add $ANDROID_HOME/tools as well as $ANDROID_HOME/platform-tools to your $PATH. (or on Windows %ANDROID_HOME%\tools and %ANDROID_HOME%\platform-tools).
- Add binaries to environment variable PHAT (PATH=$PATH:$HOME/bin:$JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$M2_HOME/bin)

### USAGE:

The sequence of commands are:

- First, launch the compilation to enable the generation of some files containing target 

	mvn clean compile

- The SociAAL editor enables you to customize the scenarios and create new ones. There is a tutorial for doing so in the http://grasia.fdi.ucm.es/sociaal site. 

	ant edit
    
- Make sure you have the right AVDs created. This can be done manually or by script. From linux:

	sh target/generated/scripts/createAVDsSim1.sh
	sh target/generated/scripts/createAVDsSim2.sh

And from windows: 

	target/generated/scripts/createAVDsSim1.bat
	target/generated/scripts/createAVDsSim2.bat

- To launch the simulation:

	ant runXXXX 

Where XXX is the name of the intended scenario:

* SimAppBodyPosChestNoSymptoms: No tremors with the falling detection device attached to the patient's chest
* SimAppBodyPosHandNoSymptoms: No tremors with the falling detection device attached to the patient's hand
* SimAppBodyPosChest: low tremors with the falling detection device attached to the patient's chest
* SimAppBodyPosHand: low tremors with the falling detection device attached to the patient's hand
* SimTwoCameras: two cameras, one attached to the patient's wrist and the other to the caregiver's wrist
* SimAppCamera: a camera attached to the patient's right hand wrist

This will launch the whole system (3D environment and Android emulators). If you close the terminal, emulators and 3D environment will close. It takes a while to launch and if you are modifying the specification, it is a time consuming task to launch and relaunch. 

Android Virtual Machines can be kept between simulations or may not be launched at all. To not launch the emulators, the following command is needed:  

	ant runXXXXNoDevices

And to launch only the necessary emulators:

	ant runXXXXOnlyDevices

Where XXX is the name of the simulation. The simulation can connect and disconnect. 

To get a HTML based representation of the specification, you can try to run the following

	mvn clean site site:deploy

And get the HTML doc from target/finalsite

### CREDITS:

Pablo Campillo
Jorge J. Gómez Sanz

