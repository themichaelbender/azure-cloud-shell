
    ##############################################
    ##### GIT DEMO
    ##############################################

    # GIT Integration
    
        # Set remote url to repository; SSH must be created and stored
        #Setting up GIT
        cd $home/clouddrive
        mkdir github
        cd ./github
        git config --global user.email "mbender@tailwindtraders.net"
        git config --global user.name "mbender"
        git clone https://github.com/themichaelbender-ms/azure-cloud-shell.git
        dir

        #Add Public key to GitHub
        cat ~/.ssh/id_rsa.pub
        cls
        
        # Set remote url to repository; SSH must be created and stored
        cd ./azure-cloud-shell
        git remote set-url origin git@github.com:themichaelbender-ms/azure-cloud-shell.git
        git status
        git branch
        git checkout -b demo-cs
        cd ./scripts
        code ./New-testScriptv2.ps1 
        code ./New-ServiceScript.ps1 #Update Script
        cls
        git status
        git add ./New-TestScriptv2.ps1
        git commit -a -m 'New Script and Update'
        git status
        git push -u origin demo-cs
        #If Necessary Commit on GitHub
