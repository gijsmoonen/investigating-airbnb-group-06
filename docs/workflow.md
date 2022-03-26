## <IMPORTANT!>

## Contributors/replicators instructions

### The Git Workflow

**Step 1: Git Bash / Clone**
Navigate on your computer to the directory where you want to store the git repository,
- Open git bash
- cd [folder] --> cd [folder] --> etc. OR go right-click in the folder and choose "git bash"
- git clone https://github.com/gijsmoonen/investigating-airbnb-group-06.git

**Step 2: Git Branch**
The assignee of an issue should create a new branch using,
- git branch [branch-name]
The branch-name always use the following convention *issue#XX-description*, where XX is the GitHub issue number (e.g. issue#07) and description is a version of the issue title (e.g. update-readme-instructions). Descriptions are used to give an indication of the problem you are working on. In this example, the full branch-name will be *issue#07-update-readme-instructions*. Then,
- git checkout [branch-name] 
to switch from branch. With,
- git branch
checks in which branch you are. All commits related to an issue should be made to the issue branch. Commits must have a commit message which describes what is happening. Be as specific as possible. For example, adding a figure to the analysis code should be "added robustness figure to analysis", instead of "modified analysis code".  Before commiting any changes, use,
- git status
to see if anybody else have made changes in the meantime. If so, use,
git pull [branch-name] (***not sure if this is the meta)

**Step 3: Git Workflow**
When working on the project, think in which subdirectory in de *src* folder the Rscript should be. Scripts that load and transform the data should be in the *data-preparation* folder and scripts for linear regression or any other kind of analysis or plots, should be in the *analysis* folder. Then use the following command in Git Bash,
- git status
- git add [file_name]
- git commit -m [commit_message]
- git push

**Step 4: Pull request / Merge**
If it is the first time that you want to push commits to the issue branch, then,
- git push --set-upstream origin [issue branch-name]
Now, on GitHub a message pops up that pushes have been commited to the branch and can be compared an pulled to the main branch. Best practice is to only perform a pull request when a issue is completed AND some one has peer reviewed the code that has been changed. Small issues and changes do not have to be peered. When the branch looks good, then we can merge the branch with the main branch,
- go to *code* on GitHub 
- view all branches
- new pull request
The title of the pull request should be *PR for #X: original_issue_title* where X is the GitHub issue number (e.g., PR for #07: add workflow and style guide to readme.md. Optional: provide additional comments for the peer reviewer. Pull request should be assigned to the original issue!

**Step 5: Wrap up

Close issue and delete issue branch!

**Exceptions to the Standard Workflow**
You may skip the branch/merge steps and just commit directly to main branch if the following criteria are met (so no issue branch), 
- The issue is small in scope and will involve no more than a few commits
- No one else is likely to be working on the same content at the same time
- All commits follow complete runs of relevant built scripts (e.g., make.py)
