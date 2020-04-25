tmux kill-session -t tf_sdk
tmux kill-session -t tf_info
tmux kill-session -t caddy
sudo sed -i .back "/threefold/d" /private/etc/hosts
