# Global Game Jam 2021

Github repository for Global Game Jam 2021. This game was submitted to the [Seattle Indies Jam Site](https://globalgamejam.org/2021/jam-sites/seattle-indies)

## Setup

- Clone this project to your hard drive: `https://github.com/Moogen/GGJ2021.git`
- Open the Godot editor
- Click on the "Import" button
- Navigate to the `GGJ2021/src` folder
- Import the `project.godot` file

## Collaboration and Development Process

- Make a new branch on Github; make the name somewhat related to what you are trying to change
- In your local terminal, run the following:

```bash
git pull

git checkout --track origin/[your branch name]
```

- You should now be able to make your edits as needed
- When you are done making your changes, do the following:

```bash
git add .
# OR
git add [the relevant files here]

git commit -m "commit message describing your changes"
git push
```

- In Github, navigate to your branch and submit a pull request. Write a description if you wish
- Ping @here in the #updates Discord channel to notify people there is an active PR
- Someone will merge it; go get some coffee or work on something else in the meantime
- After the PR is accepted, delete the branch both in Github and locally by running the following:

```bash
# Github branch deletion can either be done in the Github UI or from your terminal
git push -d origin [your branch name here]

# Pull the changes locally and delete the branch
git checkout main
git pull
git branch -d [your branch name here]
```

- Go back to step 1 and work on something else :sunglasses:

## Collaborators

- [Jeff Tucker](https://github.com/jeffman323)
- [Jesse Peng](https://github.com/jessepinwheel)
- [Jon Hu](https://github.com/stitchless)
- [Josh Wu](https://github.com/moogen)
