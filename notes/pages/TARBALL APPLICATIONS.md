roles that installs tarball applications use the same system configurations:

- they create a user for run the program, the user home is located under `/usr/local` and is where the program files are located.  
- they setup a systemd service which runs the program and limits it's permission to the `$HOME` directory


