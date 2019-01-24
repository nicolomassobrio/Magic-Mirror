# Magic-Mirror

The project consists of an interactive mirror, made using Microsoft Kinect v1 and Processing 3.5.2. The user stands in front of a display, connected to a device with processing and he's able to see his mood projected according to his posture.

### Software prerequisites 

* Processing 3.5.2 (22 January 2019). Download and install from: https://processing.org/download/.
* OpenNI 2.2.0.33. Download and install from: https://structure.io/openni.
* NITE 2.2. Download and install from: https://code.google.com/archive/p/simple-openni/downloads.
* Processing’s library SimpleOpenNI v1.96. Download and install from: https://code.google.com/archive/p/simple-openni/downloads.
* Processing’s library Mimin. Install from Processing at Contribution Manager's Libraries panel.

Windows version:
* Kinect for Windows SDK v1.8. Download and install from: https://www.microsoft.com/en-us/download/details.aspx?id=40278.

## Installation and usage
```bash
$ go get -u -f github.com/nicolomassobrio/Magic-Mirror/Magic_Mirror
$ go download
```
* Add the Magic Mirror folder to Processing folder on your device.
* Lantch Processing.
* Open Magic Mirror file.
* Run the Processing file.

### The technique

* The program uses the SimpleOpenNi v1.96 Processing library, which traces a basic skeleton of the user when the kinect detects its presence.
*  The program allows the user to color the background of the mirror moving legs and arms in predefined positions, acquired from the Processing file.
* The processing file stores in memory 4 user positions related to four moods, 2 positions related to a dance pose and 2 relative to gestural indicators.
* The second processing file, called SkeletonPoser, defines a series of variables and functions that can be used whenever an element of the class with the same name is created, allowing to build new positions and associate new colors, texts and music to them.

### Acquired body poses

The following table presents which body poses are already acquired:

| Position | Color | Description/Feeling |
| --- | --- | --- |
| Both arms stretched along the body | Black | neutral position (no feeling) |
| Both hands above the shoulders and both elbows bended below the shoulders | Red | Anger/Strength/Power |
| Right hand above the shoulders | Orange | Greeting/Positiveness/Cordiality |
| Both arms above the shoulders | Yellow | Happiness/Hug/Energy |
| Left hand above the shoulders and right arm stretched down | Green | Disgust |
| Both hands above the shoulders and right elbow bended above the shoulders | Purple | Fear |
| Both hands above the elbows and both elbows bended | - | Asking the current time |
| Right arm stretched above the head and the legs apart | - | playing Bohemian Rhapsody |
| Right hand above the shoulders, left hand below the hips and left foot on the right of right knee | - | playing Staying Alive |
| Left hand near the left ear, left elbow blended above the shoulder and right arm stretched on the right of the right shoulder | - | pausing the music player |

### Examples
![alt text](https://github.com/nicolomassobrio/Magic-Mirror/blob/master/Images/Anger.png)

![alt text](https://github.com/nicolomassobrio/Magic-Mirror/blob/master/Images/Hug.PNG)

![alt text](https://github.com/nicolomassobrio/Magic-Mirror/blob/master/Images/Disgust.PNG)

![alt text](https://github.com/nicolomassobrio/Magic-Mirror/blob/master/Images/Greeting.PNG)

![alt text](https://github.com/nicolomassobrio/Magic-Mirror/blob/master/Images/Fear.PNG)

![alt text](https://github.com/nicolomassobrio/Magic-Mirror/blob/master/Images/Time.PNG)

![alt text](https://github.com/nicolomassobrio/Magic-Mirror/blob/master/Images/PlayMusic.PNG)

![alt text](https://github.com/nicolomassobrio/Magic-Mirror/blob/master/Images/PauseMusic.PNG)



## License
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Magic Mirror</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/nicolomassobrio/Magic-Mirror" property="cc:attributionName" rel="cc:attributionURL"> Nicolò Massobrio</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/nicolomassobrio/Magic-Mirror" rel="dct:source">https://github.com/nicolomassobrio/Magic-Mirror</a>.
