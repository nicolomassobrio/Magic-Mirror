# Magic-Mirror

The project consists of an interactive mirror, made using Microsoft Kinect v1 and Processing 3.5.2. The user stands in front of a display, connected to a device with processing and he's able to see his mood projected according to his posture.

### Prerequisites

* Processing 3.5.2 (22 January 2019). Download and install from: https://processing.org/download/.
* OpenNI 2.2.0.33. Download and install from: https://structure.io/openni.
* NITE 2.2. Download and install from: https://code.google.com/archive/p/simple-openni/downloads.
* Processing’s library SimpleOpenNI v1.96. Download and install from: https://code.google.com/archive/p/simple-openni/downloads.
* Processing’s library Mimin. Install from Processing at Contribution Manager's Libraries panel.

Windows version:
* Kinect for Windows SDK v1.8. Download and install from: https://www.microsoft.com/en-us/download/details.aspx?id=40278.

### The technique
* The program uses the SimpleOpenNi v1.96 Processing library, which traces a basic skeleton of the user when the kinect detects its presence.
*  The program allows the user to color the background of the mirror moving legs and arms in predefined positions, acquired from the Processing file.
* The processing file stores in memory 4 user positions related to four moods, 2 positions related to a dance pose and 2 relative to gestural indicators.
* The second processing file, called SkeletonPoser, defines a series of variables and functions that can be used whenever an element of the class with the same name is created, allowing to build new positions and associate new colors, texts and music to them.



