function pcli --wraps='sudo -u postgres psql' --description 'alias pcli sudo -u postgres psql'
  sudo -u postgres psql $argv; 
end
