# Code README

Code samples from tutorial chapters, HW answer keys, and scripts
Save these to a Code directory in Rclass (your working directory for the class).  

# Download manually via your browser:
1. Click on the link of interest (e.g., anolis.csv)
2. Right-click or control-click on the "Raw" box on the right just above the screen showing the file contents
3. **MAC USERS**: click on "Download Linked File As..."     
   **PC USERS**: click (left-click is regular click) on "Save Target As" (Internet Explorer) or "Save Link Target As" (Netscape, Mozilla)
4. Specify the directory where you want to save the file (e.g. Rclass/Data/)
5. Click save

# Using Git to clone this directory and keep it up to date:
Git is a free open-source version control system. You can copy repositories of files to your local computer, and use Git to automatically update your local copies when any new files are added to the server (by me). **Please let me know if any of this needs to be corrected**
1. Install Git if you havenʻt aready https://git-scm.com/downloads
2. **Mac USERS** open your Terminal.app (look under Applications > Utilities)  
   **PC USERS** open your "Command Prompt". Either search for "Command Prompt" or look for it under your Start Menu > Programs list. If you canʻt find it [read this](https://www.digitalcitizen.life/7-ways-launch-command-prompt-windows-7-windows-8)
3. Navigate to your Rclass working directory. (The terminal window or the command prompt window is your terminal-interface into your computer.) If you are on a Mac and you created it at the top level of your user directory it would be: 

   ```
   cd ~/Rclass
   ```

   On a PC it would be

   ```
   cd ʻC:/path to my directory/Rclassʻ 
   ```

4. Clone the repository. Type the line below, hit return, and it will create a folder called `Code` in your working directory that contains a copy of all the files currently at that location on the server. Note this will create a new copy of the whole directory, so you only do this the first time. 

    ```
    git clone https://github.com/Rbootcamp-UHM/Code.git
    ```
 
5. Update the repository. Later when Iʻve added more files, do the following to add the new files from the server to your local directory.   
      1. Open your terminal and navigate to within your Code folder:

      ```
      cd ~/Rclass/Code
      ```
      2. Update the repository:

      ```
      git pull origin master
      ```
   Voila! All the new files have been added to your local directory. The last line tells git to pull any new changes from the origin (the server where I am putting all the files) to the master (your local directory). 

6. If you want to check if all is up to date:

   ```
   git status
   ```
   
   If everyting is up to date it will say `Your branch is up-to-date with 'origin/master'. nothing to commit, working tree clean`

7. Note: Git works directory by directory (it saves a hidden status file within the cloned directory).  If you want to clone the Data directory, for example, you will have to repeat steps 3-> for the Data directory and each directory you want to clone. 
