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

