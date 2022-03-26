# Data Preparation & Workflow Management

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

?? squash merge

Close issue and delete issue branch!

**Exceptions to the Standard Workflow**
You may skip the branch/merge steps and just commit directly to main branch if the following criteria are met (so no issue branch), 
- The issue is small in scope and will involve no more than a few commits
- No one else is likely to be working on the same content at the same time
- All commits follow complete runs of relevant built scripts (e.g., make.py)

## Style guide

# Research 

# Motivation
The main objective of this study is to analyze the impact of the Amsterdam Dance event, which is a yearly music festival active from 13th to 17th of October. A vast amount of domestic and international travelers come to the city to enjoy this event. Staying in an Airbnb is a viable option for guests who don't live in or nearby the city. The purpose of the study is to investigate whether an event such as Amsterdam Dance Event has an effect on the number of reviews written by guests. The Amsterdam Dance Event, hereafter also referred to as 'ADE', could increase guests' motivation for leaving a review. When the proposed phenomenon can be confirmed, the research could be replicated with the use of other events to further investigate this correlation. Another possible effect of an event such as ADE could be the increase of prices because of ADE (or other events) taking place in a city. For a detailed overview of the analyses, please proceed to the Analysis description below. 

# Data preparation
After downloading the files with regards to the Airbnb data of Amsterdam, the data was cleaned and ordered in order to be able to perform analyses. For example, all seasonal listings, which were different datasets, were combined in one data set. Furthermore, all relevant variables were selected for the purpose of creating a relevant data frame. The data was cleaned from any dollar signs, commas and other irrelevant signs. These types of steps were executed for the listings and review data as well as a combination of those two. Moreover, dummy variables were created for neighborhoods, seasons and room type. Different data sets were created for the purpose of being able to conduct the desired analyses. Herewith, a dataset including the data of the review per listing per day was created. Among others, a set per neighborhood was created for Amsterdam Dance Event as well as year round, subsets where the data of ADE is excluded and an overview of the distribution of reviews per year (2018-2021). For a detailed overview of the explored, cleaned and prepared data, please refer to the RMarkdown script. 

# Analysis description
**Two analyses are planned for this project**

**#analysis 1**
**Check the correlation between ADE and the amount of reviews left by guests**

The amount of reviews can be retrieved from the dataset. An event such as ADE might boost the motivation to leave a review, which can be further investigated. 
The yearly amount of reviews can be extracted to different neighbourhoods and be related to different time periods.


**#analysis 2**
**Make a price prediction in a linear regression model**

Right now, few prices can be retrieved from the dataset, as the data provider has fetched all the rates for a few dates in the year. Different columms such as the location, room type, and the review amount etc. could have impact on the price. To make a prediction for the prices of rooms throughout the city for next year's event, a regression analysis is run over these variables. 

The reviews can be left by guests of Airbnb up to 2 weeks after the end day of the stay. For this reason, the main time period measured against standardized data has been two weeks after the last date of the event.

