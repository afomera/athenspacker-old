## AthensPacker

This script will take files in ../to_package/ and zip them up for uploading them to Solder.

It's not the best implementation I could think of but it is functional and will save many minutes of work. 

### Instructions
Place files in to_package/ like 'to_package/test.jar'

You should recieve a file in 'to_upload/' named 'test.zip'

Obviously before uploading the file to TechnicSolder you'd want to rename the file to whatever structure you have the mod-slugs in as and add a version number (or fix the version number). I intend to improve this in future updates but feel free to modify and submit a pull request if you'd like. 

We also intend to add support for configuration files and possibly even Forge uploading. 



### Example: 
/to_package/FastLeafDecay-1.7.10-1.0.jar and outputs it as FastLeafDecay-1.7.10-1.0.zip

## AthensPacker 2 Plans

Below I'll list the steps the script may take for full automation.

* User puts modfiles into a ~/package/ folder
* The script will take the modfile, strip the name of spaces, [, ], (,), and other edge cases. Put the modjar in a mods/ folder and then zip that folder with the cleaned name. 
* Once all mods are packaged and put into ~/output/ the ~/package/ folder should be empty
* The script then says "40 mods packaged and ready for upload" or something close. 
* Script connects to the remote database and pulls a list of Mod's, Slugs and stores them for use in comparing filenames. 
* For each one it'll need to go into the proper folder in the server files. So it'll need to go into ~/TechnicSolder/public/mods/modslug/
* modslug will represent the mod name mostly represented by replacing spaces with dashes (-). If the modslug folder doesn't exist it'll need to be created and then that mod will need to be added to the database.
* The best case situation is the script should keep track of those it can't handle/find spots for and notify the user / prompt the user to create it via the commandline.
