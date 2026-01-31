# vim: ft=gitconfig

[alias]
  author = commit --amend --author="$(git config user.name) <$(git config user.email)>" --no-edit
  author-msg = commit --amend --author="$(git config user.name) <$(git config user.email)>" -m
  authorSmsg = commit --amend --author="$(git config user.name) <$(git config user.email)>" -S -m

  reauthor = commit --amend --reset-author --no-edit
  reauthor-msg = commit --amend --reset-author -m
  reauthorSmsg = commit --amend --reset-author -S -m

  amend = commit --amend --no-edit
  amend-msg = commit --amend -m
  amendSmsg = commit --amend -S -m

  Smsg = commit --gpg-sign --message
