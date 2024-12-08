#!/bin/bash

SESH="dora"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then 
#	tmux new-session -d -s pg -n "docker-postgres"
	#tmux send-keys -t pg:docker-postgres "docker start -i backend-db-1" C-m

	tmux new-session -d -s $SESH -n "frontend"
	tmux send-keys -t $SESH:frontend "cd ~/Development/ng-dora/frontend/" C-m
	tmux send-keys -t $SESH:frontend "nvim ." C-m

	tmux new-window -t $SESH -n "backend"
	tmux send-keys -t $SESH:backend "cd ~/Development/ng-dora/backend/" C-m
	tmux send-keys -t $SESH:backend "nvim ." C-m

	tmux new-window -t $SESH -n "client"
	tmux send-keys -t $SESH:client "cd ~/Development/ng-dora/frontend/" C-m
	tmux send-keys -t $SESH:client "npm run turbo" C-m

	tmux new-window -t $SESH -n "server"
	tmux send-keys -t $SESH:server "cd ~/Development/ng-dora/backend/" C-m
	tmux send-keys -t $SESH:server "air" C-m

	tmux new-window -t $SESH -n "db"
	tmux send-keys -t $SESH:db "cd ~/Development/ng-dora/backend/" C-m
	tmux send-keys -t $SESH:db "docker compose up -d" C-m
	tmux send-keys -t $SESH:db "make pg" C-m

	tmux select-window -t $SESH:frontend
fi

tmux attach-session -t  $SESH
