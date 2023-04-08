function rebase-dev --wraps=git\ checkout\ dev\ \\\ git\ pull\ origin\ dev\ \\\ git\ checkout\ chizi-dev\ \\\ git\ rebase\ dev --wraps='git checkout dev && git pull origin dev && git checkout chizi-dev && git rebase dev' --description 'alias rebase-dev git checkout dev && git pull origin dev && git checkout chizi-dev && git rebase dev'
  git checkout dev && git pull origin dev && git checkout chizi-dev && git rebase dev $argv; 
end
