# Git

## Setting a user

To set a global user / default, run these commands.

```bash
git config --global user.name <username>
git config --global user.email <email>
```

To set a local repos user, run these commands. This will override the global config.

```bash
git config user.name <username>
git config user.email <email>
```

## Changing commit author

Github wrote an awesome guide on rewriting a repo's commit history in case you were like me and used the wrong account to commit to a repo. The guide [is here](https://help.github.com/articles/changing-author-info/).

Keep in mind this will rewrite the history hashes which can be VERY BAD for other developers.

In case the location changes:

1. Run `git clone --bare https://github.com/user/repo.git`
2. Change the email to the correct one in this script

```bash
#!/bin/sh

git filter-branch --env-filter '
OLD_EMAIL="your-old-email@example.com"
CORRECT_NAME="Your Correct Name"
CORRECT_EMAIL="your-correct-email@example.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
```

3. Push the changes with `git push --force --tags origin 'refs/heads/*'`